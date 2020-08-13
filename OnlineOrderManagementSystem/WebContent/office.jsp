<%@page import="java.util.List"%>
<%@page import="domain.Office"%>
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
	<div class="row col-md-6">
		<table class="table table-striped table-bordered table-sm">
			<tr>
				<th>Office code</th>
				<th>City</th>
				<th>Phone</th>
				<th>Address Line 1</th>
				<th>Address Line 2</th>
				<th>State</th>
				<th>Country</th>
				<th>Postal code</th>
				<th>Territory</th>
			</tr>
			<%
				List<Office> Offices = (List<Office>) request.getAttribute("offices");
					for (Office t : Offices ) {
						out.println("<tr>");
						out.println("<td>" + t.getOfficecode() + "</td>");
						out.println("<td>" + t.getCity() + "</td>");
						out.println("<td>" + t.getPhone() + "</td>");
						out.println("<td>" + t.getAddressline1() + "</td>");
						out.println("<td>" + t.getAddressline2() + "</td>");
						out.println("<td>" + t.getState()+ "</td>");
						out.println("<td>" + t.getCountry()+ "</td>");
						out.println("<td>" + t.getPostalcode()+ "</td>");
						out.println("<td>" + t.getTerritory()+ "</td>");
						out.println("<td><a href=\"OfficesServlet?officeCode=" + t.getOfficecode() + "\">Update</a></td>");
						out.println("<td><a href=\"OfficesServlet?officeCode=" + t.getOfficecode() + "\">Delete</a></td>");
					out.println("</tr>");
				}
			%>
		</table>
		
	</div>
	<button class="open-button" onclick="openForm()">Open Form</button>
	<div class="form-popup" id="myForm">
		<form action="OfficesServlet" class="form-container" method="post">
			<h1>Add Office</h1>
			<fieldset>
				<legend>Add Office Details:</legend>
				Office code: <input type="text" name="officecode" /> <br> 
				City:<input type="text" name="city" /> <br> 
				Phone: <input type="text" name="phone" /> <br> 
				Address Line 1: <input type="text" name="addressline1" /> <br> 
				Address Line 2: <input type="text" name="addressline2" />	<br> 
				State: <input type="text" name="state" />
				Country: <input type="text" name="country" />
				Postal code: <input type="text" name="postalcode" />
				Territory: <input type="text" name="territory" />
			</fieldset>
			<button type="submit" class="btn">Submit Office</button>
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
