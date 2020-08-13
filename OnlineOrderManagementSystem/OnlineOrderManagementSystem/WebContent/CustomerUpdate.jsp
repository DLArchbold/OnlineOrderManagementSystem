<%@page import="domain.Employee"%>
<%@page import="domain.Customer"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style>
table {
	font-family: arial, sans-serif;
	border-collapse: collapse;
	width: 100%;
}

td, th {
	border: 1px solid #dddddd;
	text-align: left;
	padding: 8px;
}

tr:nth-child(even) {
	background-color: #dddddd;
}
</style>
</head>
<body>
	<%
		Customer customer= (Customer) request.getAttribute("1customer");
		List<Employee> Employees = (List<Employee>) request.getAttribute("allemployees");
	%>
	<form action="CustomerServlet" method="post">
		<table>
			<tr>
				<td>Customer number</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"customernumber\" readonly value=" + customer.getCustomernumber());
					%>
				</td>
			</tr>
			<tr>
				<td>Customer name</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"customername\" value=" + customer.getCustomername());
					%>
				</td>
			</tr>
			<tr>
				<td>First name</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"contactfirstname\" value=" + customer.getContactfirstname());
					%>
				</td>
			</tr>
			<tr>
				<td>Last name</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"contactlastname\" value=" + customer.getContactlastname());
					%>
				</td>
			</tr>
			<tr>
				<td>Phone</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"phone\" value=" +customer.getPhone());
					%>
				</td>
			</tr>
			<tr>
				<td>Address line 1</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"addressline1\" value=" +customer.getAddressline1());
					%>
				</td>
			</tr>
			<tr>
				<td>Address line 2</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"addressline2\" value=" +customer.getAddressline2());
					%>
				</td>
			</tr>
			<tr>
				<td>City</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"city\" value=" +customer.getCity());
					%>
				</td>
			</tr>
			<tr>
				<td>State</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"state\" value=" +customer.getState());
					%>
				</td>
			</tr>
			<tr>
				<td>Postal code</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"postalcode\" value=" +customer.getPostalcode());
					%>
				</td>
			</tr>
			<tr>
				<td>Country</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"country\" value=" +customer.getCountry());
					%>
				</td>
			</tr>
			<tr>
				<td>Sales Employee number</td>
				<td>
					<%
				 	out.println("<select id=\"salesrepemployeenumber\" name=\"salesrepemployeenumber\">");
				
				 	Collections.sort(Employees, new Comparator<Employee>() {
				
				 		@Override
				 		public int compare(Employee a, Employee b) {
				
				 			String employeeA = a.getFirstname() + a.getLastname();
				 			employeeA = employeeA.replaceAll("[^A-Za-z]", "");
				 			char[] arrA = employeeA.toCharArray();
				
				 			String employeeB = b.getFirstname() + b.getLastname();
				 			employeeB = employeeB.replaceAll("[^A-Za-z]", "");
				 			char[] arrB = employeeB.toCharArray();
				
				 			//return first diff of char from both strings
				 			for (int i = 0; i < Math.min(arrA.length, arrB.length); i++) {
				 				int charA = Character.getNumericValue(arrA[i]);
				 				int charB = Character.getNumericValue(arrB[i]);
				 				if (charA < charB) {
				
				 					return -1;
				 				} else if (charA > charB) {
				
				 					return 1;
				 				}
				 			}
				 			//return shorter of two cities if no diff between two
				 			//up to the length of shorter one
				
				 			return Integer.compare(arrA.length, arrB.length);
				 		}
				
				 	});
				
				 	for (Employee employee: Employees) {
				
				 		out.println("<option value=\"" + employee.getEmployeenumber() + "\">" + employee.getFirstname() + " "+  employee.getLastname() + "-"
				 				+ employee.getEmployeenumber() + "</option>");
				
				 	}
				
				 	out.println("</select>");
				 %>
				</td>
			</tr>
			<tr>
				<td>Credit limit</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"creditlimit\" value=" +customer.getCreditlimit());
					%>
				</td>
			</tr>
			
		</table>
		<input type="submit" name="UPDATE" value="UPDATE" /> <input
			type="submit" name="DELETE" value="DELETE" />
	</form>
</body>
</html>