<%@page import="java.util.List"%>
<%@page import="domain.Employee"%>
<%@page import="domain.Office"%>
<%@page import="domain.Customer"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style>
body {
	font-family: Arial, Helvetica, sans-serif;
}

* {
	box-sizing: border-box;
}
/* Button used to open the contact form - fixed at the bottom of the page */
.open-button {
	background-color: #555;
	color: white;
	padding: 16px 20px;
	border: none;
	cursor: pointer;
	opacity: 0.8;
	position: fixed;
	bottom: 23px;
	right: 28px;
	width: 280px;
}
/* The popup form - hidden by default */
.form-popup {
	overflow-x: hidden;
	overflow-y: auto;
	height: 400px;
	display: none;
	position: fixed;
	top: 60%;
	left: 50%;
	-webkit-transform: translate(-50%, -50%);
	transform: translate(-50%, -50%);
}
/* Add styles to the form container */
.form-container {
	max-width: 500px;
	padding: 10px;
	background-color: white;
}
/* Full-width input fields */
.form-container input[type=text], .form-container input[type=password] {
	width: 100%;
	padding: 15px;
	margin: 5px 0 22px 0;
	border: none;
	background: #f1f1f1;
}
/* When the inputs get focus, do something */
.form-container input[type=text]:focus, .form-container input[type=password]:focus
	{
	background-color: #ddd;
	outline: none;
}
/* Set a style for the submit button */
.form-container .btn {
	background-color: #4CAF50;
	color: white;
	padding: 16px 20px;
	border: none;
	cursor: pointer;
	width: 100%;
	margin-bottom: 10px;
	opacity: 0.8;
}
/* Add a red background color to the cancel button */
.form-container .cancel {
	background-color: red;
}
/* Add some hover effects to buttons */
.form-container .btn:hover, .open-button:hover {
	opacity: 1;
}
</style>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css">
</head>
<body>
	<%
		//get various lists ready
		List<Customer> Customers = (List<Customer>) request.getAttribute("customers");
		List<Employee> Employees = (List<Employee>) request.getAttribute("employees");
		//System.out.println("customer.jsp 1: " + Customers.get(0).getEmployee().getFirstname());
	%>
	<div class="row col-md-6">
		<table class="table table-striped table-bordered table-sm">
			<tr>
				<th>Customer number</th>
				<th>Customer name</th>
				<th>Contact first name</th>
				<th>Contact last name</th>
				<th>Phone</th>
				<th>Address line 1</th>
				<th>Address line 2</th>
				<th>City</th>
				<th>State</th>
				<th>Postal code</th>
				<th>Country</th>
				<th>Sales employee number</th>
				<th>Credit limit</th>
			</tr>
			<%
			//System.out.println("customer.jsp 2: " + Customers.get(0).getEmployee().getFirstname());
			//System.out.println("customer.jsp 3: " + Customers.get(1).getEmployee().getFirstname());
			for(int i = 0; i<Customers.size(); i++){
				Employee e = Customers.get(i).getEmployee();
				if(e != null){
					System.out.println(e.getFirstname() + " " + i);
				}else{
					System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + i);
				}
			}
				for (Customer t : Customers) {
					out.println("<tr>");
					out.println("<td>" + t.getCustomernumber() + "</td>");
					out.println("<td>" + t.getCustomername() + "</td>");
					out.println("<td>" + t.getContactfirstname() + "</td>");
					out.println("<td>" + t.getContactlastname() + "</td>");
					out.println("<td>" + t.getPhone() + "</td>");
					out.println("<td>" + t.getAddressline1() + "</td>");
					if(!(t.getAddressline2() == null)){
						out.println("<td>" + t.getAddressline2() + "</td>");
					}else{
						out.println("<td>" +"-" +  "</td>");
					}
					out.println("<td>" + t.getCity() + "</td>");
					
					if(!(t.getState() == null)){
						out.println("<td>" + t.getState() + "</td>");
					}else{
						out.println("<td>" +"-" +  "</td>");
					}
					out.println("<td>" + t.getPostalcode() + "</td>");
					out.println("<td>" + t.getCountry() + "</td>");
					if(!(t.getEmployee() == null)){
						out.println("<td>" + t.getEmployee().getFirstname() + " " + t.getEmployee().getLastname() + "</td>");
					}else{
						out.println("<td>" +"-" +  "</td>");
					}
					out.println("<td>" + t.getCreditlimit() + "</td>");
					out.println(
							"<td><a href=\"CustomerServlet?customerNumber=" + t.getCustomernumber() + "\">Update</a></td>");
					out.println(
							"<td><a href=\"CustomerServlet?customerNumber=" + t.getCustomernumber() + "\">Delete</a></td>");
					out.println("</tr>");
				}
			%>
		</table>

	</div>
	<button class="open-button" onclick="openForm()">Open Form</button>
	<div class="form-popup" id="myForm">
		<form action="CustomerServlet" class="form-container" method="post">
			<h1>Add Customer</h1>
			<fieldset>
				<legend>Add Customer Details:</legend>
				Customer number: <input type="text" name="customernumber" /> <br>
				Customer name: <input type="text" name="customername" /> <br>
				Contact first name: <input type="text" name="contactfirstname" /> <br>
				Conctact last name:<input type="text" name="contactlastname" /> <br>
				Phone <input type="text" name="phone" /> <br> Address line 1 <input
					type="text" name="addressline1" /> <br> Address line 2<input
					type="text" name="addressline2" /> <br> City<input
					type="text" name="city" /> <br> State<input type="text"
					name="state" /> <br> Postal code<input type="text"
					name="postalcode" /> <br> Country<input type="text"
					name="country" /> <br> Sales Employee number:
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
				 %><br>

				Credit limit<input type="text" name="creditlimit" /> <br>



			</fieldset>
			<button type="submit" class="btn">Submit Customer</button>
			<button type="button" class="btn cancel" onclick="closeForm()">Close</button>
			<button type="reset" class="btn">Reset</button>
		</form>
	</div>
	<script>
		function openForm() {
			document.getElementById("myForm").style.display = "block";
		}
		function closeForm() {
			document.getElementById("myForm").style.display = "none";
		}
	</script>
</body>
</html>
