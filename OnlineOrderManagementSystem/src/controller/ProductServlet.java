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

import domain.Employee;
import domain.Office;
import domain.Product;
import domain.Productline;
import sessionbean.ProductSessionBeanLocal;
//import sessionbean.ProductLineSessionBeanLocal;
import utilities.ValidateManageLogic;

/**
 * Servlet implementation class ProductServlet
 */
@WebServlet("/ProductServlet")
public class ProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@EJB
	private ProductSessionBeanLocal probean;
	
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProductServlet() {
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

		if(request.getParameter("productCode")!= null) {
			String productCode = request.getParameter("productCode");
			Product pro = probean.findProduct(productCode);
			request.setAttribute("1pro", pro);
			
			List<Productline> prolines = probean.getProductlines();
			request.setAttribute("prolines", prolines);
			
			List<Product> Products = probean.getAllProducts();
			request.setAttribute("pros", Products);
			
			RequestDispatcher req = request.getRequestDispatcher("ProductUpdate.jsp");
			req.forward(request, response);
			
		}else {
			try {
				List<Productline> prolines = probean.getProductlines();
				request.setAttribute("prolines", prolines);
				
				List<Product> lists = probean.getAllProducts();
				request.setAttribute("pros", lists);
				
			} catch (EJBException ex) {
			}
			RequestDispatcher dispatcher = request.getRequestDispatcher("product.jsp");
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
		// doGet(request, response);

		String pcode = request.getParameter("productcode");
		String pname = request.getParameter("productname");
		String pline = request.getParameter("productline");
		String pscale = request.getParameter("productscale");
		String pvendor = request.getParameter("productvendor");
		String pdescription = request.getParameter("productdescription");
		String qis = request.getParameter("quantityinstock");
		String bprice = request.getParameter("buyprice");
		String msrp = request.getParameter("msrp");
		PrintWriter out = response.getWriter();
		String[] s = {pcode, pname, pline, pscale, pvendor, pdescription, qis, bprice, msrp};
		
		try {
			if(ValidateManageLogic.validateManageTrainer(request).equals("UPDATE")) {
				// call session bean updateEmployee method
				//prodao.updateProduct(s);
				probean.updateProduct(s);
				
			} else if(ValidateManageLogic.validateManageTrainer(request).equals("DELETE")) {
				// call session bean deleteEmployee method
				//prodao.deleteProduct(pcode);
				probean.deleteProduct(pcode);
				
				// if ADD button is clicked
			} else{
				// call session bean addEmployee method
				//prodao.addProduct(s);
				probean.addProduct(s);
				
			}

			// this line is to redirect to notify record has been updated and redirect to
			// another page
			ValidateManageLogic.navigateJSProducts(out);
		} catch (EJBException ex) {
		}
	}

}
