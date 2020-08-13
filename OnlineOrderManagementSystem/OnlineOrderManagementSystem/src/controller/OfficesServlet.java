package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import domain.Office;
import sessionbean.OfficeSessionBeanLocal;
import utilities.ValidateManageLogic;

/**
 * Servlet implementation class OfficesServlet
 */
@WebServlet("/OfficesServlet")
public class OfficesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@EJB
	private OfficeSessionBeanLocal officeBean;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public OfficesServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		
		if(request.getParameter("officeCode")!= null) {
			//Either update or delete offices
			String officeCode = request.getParameter("officeCode");
			Office office = officeBean.findOffice(officeCode);
			request.setAttribute("1office", office);
			RequestDispatcher req = request.getRequestDispatcher("OfficeUpdate.jsp");
			req.forward(request, response);
			
			
		}else {
			//Just view list of offices
			try {

				List<Office> lists = officeBean.getAllOffices();
				// List<EmployeeTest> lists = empdao.readStaff(currentPage, recordsPerPage);
				request.setAttribute("offices", lists);
				
			
			} catch (EJBException ex) {
			}
			RequestDispatcher dispatcher = request.getRequestDispatcher("office.jsp");
			dispatcher.forward(request, response);

		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String officeCode = request.getParameter("officecode");
		String city = request.getParameter("city");
		String phone = request.getParameter("phone");
		String addressLine1 = request.getParameter("addressline1");
		String addressLine2 = request.getParameter("addressline2");
		String state = request.getParameter("state");
		String country = request.getParameter("country");
		String postalCode = request.getParameter("postalcode");
		String territory = request.getParameter("territory");
		PrintWriter out = response.getWriter();
		String[] s = { officeCode, city, phone, addressLine1, addressLine2, state, country, postalCode, territory };

		try {
			String validateVal = ValidateManageLogic.validateManageTrainer(request);
			if (validateVal.equals("UPDATE")) {
				// call session bean updateEmployee method
				officeBean.updateOffice(s);
				// empdao.updateEmployee(s);
			} else if (validateVal.equals("DELETE")) {
				// call session bean deleteEmployee method
				// empdao.deleteEmployee(eid);
				officeBean.deleteOffice(officeCode);
				// if ADD button is clicked
			} else {
				// call session bean addEmployee method
				officeBean.addOffice(s);
				// empdao.addEmployee(s);
			}
			// this line is to redirect to notify record has been updated and redirect to
			// another page
			ValidateManageLogic.navigateJS(out, validateVal);
		} catch (EJBException ex) {
		}

	}

}
