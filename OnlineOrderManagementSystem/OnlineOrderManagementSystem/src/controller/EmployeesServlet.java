package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import domain.Employee;
import domain.Office;
import sessionbean.EmployeesSessionBeanLocal;
import sessionbean.OfficeSessionBeanLocal;
import utilities.ValidateManageLogic;

/**
 * Servlet implementation class EmployeesServlet
 */
@WebServlet("/EmployeesServlet")
public class EmployeesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@EJB
	private EmployeesSessionBeanLocal employeeBean;
    /**
     * @see HttpServlet#HttpServlet()
     */
	
	
	
    public EmployeesServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		if(request.getParameter("employeeNumber")!= null) {
			//Either update or delete offices
			//Get 1 employee
			String employeeNumber = request.getParameter("employeeNumber");
			Employee employee = employeeBean.findEmployee(employeeNumber);
			request.setAttribute("1employee", employee);
			//Get list of offices
			List<Office> offices = employeeBean.getOffices();
			request.setAttribute("offices", offices);
			//Get all employees
			List<Employee> listOfEmployees = employeeBean.getAllEmployees();
			request.setAttribute("allemployees", listOfEmployees);
			
			RequestDispatcher req = request.getRequestDispatcher("EmployeeUpdate.jsp");
			System.out.println("----------------------------in EmployeeUpdate.jsp");
			req.forward(request, response);
			
			
			
		}else {
			//Just view list of offices
			try {

				//Get list of offices
				List<Office> offices = employeeBean.getOffices();
				request.setAttribute("offices", offices);
				//Get list of all employees
				List<Employee> lists = employeeBean.getAllEmployees();
				request.setAttribute("employees", lists);
				// List<EmployeeTest> lists = empdao.readStaff(currentPage, recordsPerPage);
				
				
			
			} catch (EJBException ex) {
			}
			RequestDispatcher dispatcher = request.getRequestDispatcher("employee.jsp");
			dispatcher.forward(request, response);

		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String employeeNumber = request.getParameter("employeenumber");
		String lastName= request.getParameter("lastname");
		String firstName= request.getParameter("firstname");
		String extension= request.getParameter("extension");
		String email= request.getParameter("email");
		String officeCode = request.getParameter("officecode");
		String reportsTo = request.getParameter("reportsto");
		String jobTitle= request.getParameter("jobtitle");
		PrintWriter out = response.getWriter();
		String[] s = { employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle};

		try {
			String validateVal = ValidateManageLogic.validateManageTrainer(request);
			if (validateVal.equals("UPDATE")) {
				// call session bean updateEmployee method
				employeeBean.updateEmployee(s);
				// empdao.updateEmployee(s);
			} else if (validateVal.equals("DELETE")) {
				// call session bean deleteEmployee method
				// empdao.deleteEmployee(eid);
				employeeBean.deleteEmployee(employeeNumber);
				// if ADD button is clicked
			} else {
				// call session bean addEmployee method
				employeeBean.addEmployee(s);
				// empdao.addEmployee(s);
			}
			// this line is to redirect to notify record has been updated and redirect to
			// another page
			ValidateManageLogic.navigateJSEmployees(out, validateVal);
		} catch (EJBException ex) {
		}
	}

}
