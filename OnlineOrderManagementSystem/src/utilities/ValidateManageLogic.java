package utilities;

import java.io.PrintWriter;
import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;

public class ValidateManageLogic {
	//Could be placed inside EmployeeController, but that should delegate to this
	public static String validateManageTrainer(HttpServletRequest request) {
		if (request.getParameter("UPDATE") != null && request.getParameter("UPDATE").equals("UPDATE")) {
			return "UPDATE";
		} else if (request.getParameter("DELETE") != null && request.getParameter("DELETE").equals("DELETE")) {
			return "DELETE";
		}
		return "ADD";
		
		
	}

// this method is used to notify a user that a record has been updated and to
// redirect to another page
	public static void navigateJSOffices(PrintWriter out, String validateVal) {
		out.println("<SCRIPT type=\"text/javascript\">");
		out.println("alert(\"Record has been " + validateVal.toLowerCase()+ "d and url will be redirected\")");
		out.println("window.location.assign(\"OfficesServlet\")");
		out.println("</SCRIPT>");
	}
	public static void navigateJSCustomer(PrintWriter out, String validateVal) {
		out.println("<SCRIPT type=\"text/javascript\">");
		out.println("alert(\"Record has been " + validateVal.toLowerCase()+ "d and url will be redirected\")");
		out.println("window.location.assign(\"CustomerServlet\")");
		out.println("</SCRIPT>");
	}
	public static void navigateJSEmployees(PrintWriter out, String validateVal) {
		out.println("<SCRIPT type=\"text/javascript\">");
		out.println("alert(\"Record has been " + validateVal.toLowerCase()+ "d and url will be redirected\")");
		out.println("window.location.assign(\"EmployeesServlet\")");
		out.println("</SCRIPT>");
	}
	public static void navigateJSProducts(PrintWriter out) {
		out.println("<SCRIPT type=\"text/javascript\">");
		out.println("alert(\"Record has been updated and url will be redirected\")");
		out.println("window.location.assign(\"ProductServlet\")");
		out.println("</SCRIPT>");
	}
	
	public static void navigateJSProductLines(PrintWriter out) {
		out.println("<SCRIPT type=\"text/javascript\">");
		out.println("alert(\"Record has been updated and url will be redirected\")");
		out.println("window.location.assign(\"ProductlineServlet\")");
		out.println("</SCRIPT>");
	}

	
}