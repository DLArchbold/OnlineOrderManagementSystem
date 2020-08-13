<%@page import="java.util.List"%>
<%@page import="domain.Productline"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Productlines List</title>
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
<body class="m-3">
	<div class="row col-md-6">
		<table class="table table-striped table-bordered table-sm">
			<tr><th colspan='9'> Product Line Information </th></tr>
			<tr>
				<th>Product Line</th>
				<th>Text Description</th>
				<th>HTML Description</th>
				<th>Image</th>
			</tr>
			<%
				List<Productline> productlines = (List<Productline>) request.getAttribute("productlines");
				for (Productline t : productlines) {
					out.println("<tr>");
					out.println("<td>" + t.getProductline() + "</td>");
					out.println("<td>" + t.getTextdescription() + "</td>");
					out.println("<td>" + t.getHtmldescription() + "</td>");
					out.println("<td>" + t.getImage() + "</td>");
					out.println("<td><a href=\"ProductlineServlet?productLine=" + t.getProductline() + "\">Update</a></td>");
					out.println("<td><a href=\"ProductlineServlet?productLine=" + t.getProductline() + "\">Delete</a></td>");
					out.println("</tr>");
				}
			%>
		</table>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.1.1.slim.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js"></script>
	
	<button class="open-button" onclick="openForm()">Open Form</button>
	<div class="form-popup" id="myForm">
		<form action="ProductlineServlet" class="form-container" method="post">
			<h1>Add Product</h1>
			<fieldset>
				<legend>Add Productline Details:</legend>
				Line: <input type="text" name="productline" /> <br> 
				Text: <input type="text" name="textdescription" /> <br> 
				HTML: <input type="text" name="htmldescription" /> <br> 
				Image: <input type="text" name="image" />		
			</fieldset>
			<button type="submit" class="btn">Submit</button>
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