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
import javax.servlet.ServletException;
import javax.persistence.EntityManager;
import javax.persistence.Query;

import domain.Customer;
import domain.Employee;
import domain.Office;
import sessionbean.CustomersSessionBeanLocal;
import utilities.ValidateManageLogic;

/**
 * Servlet implementation class CustomerServlet
 */
@WebServlet("/CustomerServlet")
public class CustomerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@EJB
	private CustomersSessionBeanLocal customerBean;
    /**
     * @see HttpServlet#HttpServlet()
     */
	
	
	
    public CustomerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		if(request.getParameter("customerNumber")!= null) {
			//Either update or delete offices
			//Get 1 customer
			String employeeNumber = request.getParameter("customerNumber");
			Customer customer = customerBean.findCustomer(employeeNumber);
			request.setAttribute("1customer", customer);
			//Get all employees
			List<Employee> listOfEmployees = customerBean.getEmployees();
			request.setAttribute("allemployees", listOfEmployees);
			
			RequestDispatcher req = request.getRequestDispatcher("CustomerUpdate.jsp");
			System.out.println("----------------------------in EmployeeUpdate.jsp");
			req.forward(request, response);
			
			
			
		}else {
			//Just view list of  customers
			try {

				//Get list of employees
				List<Employee> employees = customerBean.getEmployees();
				request.setAttribute("employees", employees);
				//Get list of all customers
				List<Customer> lists = customerBean.getAllCustomers();
				request.setAttribute("customers", lists);
				// List<EmployeeTest> lists = empdao.readStaff(currentPage, recordsPerPage);
				//System.out.println(lists.get(0).getEmployee().getFirstname() + " " + lists.get(0).getEmployee().getLastname());
				
			
			} catch (EJBException ex) {
				
				System.out.println(ex.getMessage());
			}

			RequestDispatcher dispatcher = request.getRequestDispatcher("customer.jsp");
			dispatcher.forward(request, response);
			

		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String customernumber = request.getParameter("customernumber");
		String customername= request.getParameter("customername");
		String contactfirstname= request.getParameter("contactfirstname");
		String contactlastname= request.getParameter("contactlastname");
		String phone= request.getParameter("phone");
		String addressline1 = request.getParameter("addressline1");
		String addressline2 = request.getParameter("addressline2");
		String city= request.getParameter("city");
		String state= request.getParameter("state");
		String postalcode = request.getParameter("postalcode");
		String country = request.getParameter("country");
		String salesrepemployeenumber= request.getParameter("salesrepemployeenumber");
		String creditlimit = request.getParameter("creditlimit");
		PrintWriter out = response.getWriter();
		String[] s = { customernumber, customername, contactfirstname,contactlastname, phone, addressline1, addressline2, city, state
				, postalcode,country , salesrepemployeenumber, creditlimit};

		try {
			String validateVal = ValidateManageLogic.validateManageTrainer(request);
			if (validateVal.equals("UPDATE")) {
				// call session bean updateEmployee method
				customerBean.updateCustomer(s);
				// empdao.updateEmployee(s);
			} else if (validateVal.equals("DELETE")) {
				// call session bean deleteEmployee method
				// empdao.deleteEmployee(eid);
				customerBean.deleteCustomer(customernumber);
				// if ADD button is clicked
			} else {
				// call session bean addEmployee method
				customerBean.addCustomer(s);
				// empdao.addEmployee(s);
			}
			// this line is to redirect to notify record has been updated and redirect to
			// another page
			ValidateManageLogic.navigateJSCustomer(out, validateVal);
		} catch (EJBException ex) {
		}
	}

}
