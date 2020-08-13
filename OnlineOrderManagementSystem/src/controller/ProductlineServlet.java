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

import domain.Productline;
import sessionbean.ProductLineSessionBeanLocal;
import utilities.ValidateManageLogic;

/**
 * Servlet implementation class ProductlineServlet
 */
@WebServlet("/ProductlineServlet")
public class ProductlineServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@EJB
	private ProductLineSessionBeanLocal prolinebean;
	
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProductlineServlet() {
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
		// response.getWriter().append("Served at: ").append(request.getContextPath());

		if(request.getParameter("productLine")!= null) {
			
			String productLine = request.getParameter("productLine");
			Productline proline = prolinebean.findProductline(productLine);
			request.setAttribute("1proline", proline);
			RequestDispatcher req = request.getRequestDispatcher("ProductlineUpdate.jsp");
			req.forward(request, response);
		}else {
			try {

				List<Productline> lists = prolinebean.getAllProductlines();
				// List<EmployeeTest> lists = empdao.readStaff(currentPage, recordsPerPage);
				request.setAttribute("productlines", lists);
			} catch (EJBException ex) {
			}
			RequestDispatcher dispatcher = request.getRequestDispatcher("productline.jsp");
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
		String line = request.getParameter("productline");
		String text = request.getParameter("textdescription");
		String html = request.getParameter("htmldescription");
		String img = request.getParameter("image");
		PrintWriter out = response.getWriter();
		String[] s = {line, text, html, img};

		try {
			if(ValidateManageLogic.validateManageTrainer(request).equals("UPDATE")) {
				// call session bean updateEmployee method
				//prodao.updateProduct(s);
				prolinebean.updateProductline(s);
				
			} else if(ValidateManageLogic.validateManageTrainer(request).equals("DELETE")) {
				// call session bean deleteEmployee method
				//prodao.deleteProduct(pcode);
				prolinebean.deleteProductline(line);
				
				// if ADD button is clicked
			} else{
				// call session bean addEmployee method
				//prodao.addProduct(s);
				prolinebean.addProductline(s);
				
			}
			// this line is to redirect to notify record has been updated and redirect to
			// another page
			ValidateManageLogic.navigateJSProductLines(out);
		} catch (EJBException ex) {
		}
	}

}
