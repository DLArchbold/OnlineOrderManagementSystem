<%@page import="java.util.List"%>
<%@page import="domain.Employee"%>
<%@page import="domain.Office"%>
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
		List<Employee> Employees = (List<Employee>) request.getAttribute("employees");
		List<Office> offices = (List<Office>) request.getAttribute("offices");
	%>
	<div class="row col-md-6">
		<table class="table table-striped table-bordered table-sm">
			<tr>
				<th>Employee number</th>
				<th>Last name</th>
				<th>First name</th>
				<th>Extension</th>
				<th>E-mail</th>
				<th>Office code</th>
				<th>Reports to</th>
				<th>Job title</th>
			</tr>
			<%
				for (Employee t : Employees) {
					out.println("<tr>");
					out.println("<td>" + t.getEmployeenumber() + "</td>");
					out.println("<td>" + t.getLastname() + "</td>");
					out.println("<td>" + t.getFirstname() + "</td>");
					out.println("<td>" + t.getExtension() + "</td>");
					out.println("<td>" + t.getEmail() + "</td>");
					out.println("<td>" + t.getOffice().getOfficecode() + "</td>");
					out.println("<td>" + t.getReportsto() + "</td>");
					out.println("<td>" + t.getJobtitle() + "</td>");
					out.println("<td><a href=\"EmployeesServlet?employeeNumber=" + t.getEmployeenumber()
							+ "\">Update</a></td>");
					out.println("<td><a href=\"EmployeesServlet?employeeNumber=" + t.getEmployeenumber()
							+ "\">Delete</a></td>");
					out.println("</tr>");
				}
			%>
		</table>

	</div>
	<button class="open-button" onclick="openForm()">Open Form</button>
	<div class="form-popup" id="myForm">
		<form action="EmployeesServlet" class="form-container" method="post">
			<h1>Add Office</h1>
			<fieldset>
				<legend>Add Employee Details:</legend>
				Employee number: <input type="text" name="employeenumber" /> <br>
				Last name: <input type="text" name="lastname" /> <br> First
				name: <input type="text" name="firstname" /> <br> Extension: <input
					type="text" name="extension" /> <br> E-mail: <input
					type="text" name="email" /> <br> Office code:
				<%
 	out.println("<select id=\"office\" name=\"officecode\">");

 	Collections.sort(offices, new Comparator<Office>() {

 		@Override
 		public int compare(Office a, Office b) {

 			String cityA = a.getCity().replaceAll("[^A-Za-z]", "");
 			char[] arrA = cityA.toCharArray();

 			String cityB = b.getCity().replaceAll("[^A-Za-z]", "");
 			char[] arrB = cityB.toCharArray();

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

 			return -Integer.compare(arrA.length, arrB.length);
 		}

 	});

 	for (Office office : offices) {

 		out.println("<option value=\"" + office.getOfficecode() + "\">" + office.getCity() + "-"
 				+ office.getOfficecode() + "</option>");

 	}

 	out.println("</select>");
 %>
				<br> Reports to:
				<%
					//out.println("<input type=\"text\" name=\"reportsto\" value=" + employee.getReportsto());
					out.println("<select id=\"reportsto\" name=\"reportsto\">");

					//Sort list of employees according to lexicographic
					//order of full names
					Collections.sort(Employees, new Comparator<Employee>() {

						@Override
						public int compare(Employee a, Employee b) {
							String nameA = a.getFirstname() + a.getLastname();
							char[] arrA = nameA.toCharArray();

							String nameB = b.getFirstname() + b.getLastname();
							char[] arrB = nameB.toCharArray();

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
							//return shorter of two names if no diff between two
							//up to the length of shorter one

							return -Integer.compare(nameA.length(), nameB.length());

						}

					});

					for (Employee singleEmployee : Employees) {

						out.println("<option value=\"" + singleEmployee.getEmployeenumber() + "\">"
								+ singleEmployee.getFirstname() + " " + singleEmployee.getLastname() + "-"
								+ singleEmployee.getEmployeenumber() + "</option>");
						//out.println(singleEmployee.getFirstname() + singleEmployee.getLastname());

					}

					out.println("</select>");
				%><br> Job title: <input type="text" name="jobtitle" /><br>
			</fieldset>
			<button type="submit" class="btn">Submit Employee</button>
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
