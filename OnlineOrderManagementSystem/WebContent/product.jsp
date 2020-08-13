<%@page import="java.util.*"%>
<%@page import="domain.Product"%>
<%@page import="domain.Productline"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Products List</title>
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
			<tr><th colspan='9'> Product Information </th></tr>
			<tr>
				<th>Code</th>
				<th>Name</th>
				<th>Line</th>
				<th>Scale</th>
				<th>Vendor</th>
				<th>Description</th>
				<th>Quantity in Stock</th>
				<th>Buy Price</th>
				<th>MSRP</th>
			</tr>
			<%
				//List<ProductT> products = (List<ProductT>) request.getAttribute("products");
				List<Product> pros = (List<Product>) request.getAttribute("pros");
				List<Productline> prolines = (List<Productline>) request.getAttribute("prolines");
				for (Product t : pros) {
					out.println("<tr>");
					out.println("<td>" + t.getProductcode() + "</td>");
					out.println("<td>" + t.getProductname() + "</td>");
					out.println("<td>" + t.getProductlineBean().getProductline() + "</td>");
					out.println("<td>" + t.getProductscale() + "</td>");
					out.println("<td>" + t.getProductvendor() + "</td>");
					out.println("<td>" + t.getProductdescription() + "</td>");
					out.println("<td>" + t.getQuantityinstock() + "</td>");
					out.println("<td>" + t.getBuyprice() + "</td>");
					out.println("<td>" + t.getMsrp() + "</td>");
					out.println("<td><a href=\"ProductServlet?productCode=" + t.getProductcode() + "\">Update</a></td>");
					out.println("<td><a href=\"ProductServlet?productCode=" + t.getProductcode() + "\">Delete</a></td>");
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
		<form action="ProductServlet" class="form-container" method="post">
			<h1>Add Product</h1>
			<fieldset>
				<legend>Add Product Details:</legend>
				Code: <input type="text" name="productcode" /> <br> 
				Name: <input type="text" name="productname" /> <br> 
				Line:  
				
				<%
				out.println("<select id=\"productlines\" name=\"productline\">");			
					
				Collections.sort(prolines, new Comparator<Productline>(){
						
					@Override
					public int compare(Productline a, Productline b){
				
						String lineA = a.getProductline().replaceAll("[^A-Za-z]", "");
						char[] arrA = lineA.toCharArray();
						
						String lineB =  b.getProductline().replaceAll("[^A-Za-z]", "");
						char[] arrB = lineB.toCharArray();
							
						for(int i = 0; i<Math.min(arrA.length, arrB.length); i++){
							int charA = Character.getNumericValue(arrA[i]);
							int charB = Character.getNumericValue(arrB[i]);
							if(charA<charB){							
								return -1;
							}else if (charA>charB){
								return 1;
							}
						}
							return -Integer.compare(arrA.length, arrB.length);
						}
						
					});
				
				for(Productline proline: prolines){
					out.println("<option value=\""+ proline.getProductline() + "\">" + proline.getProductline() + "</option>");
				}		
					out.println("</select>");
				%>
				<br>
				Scale: <input type="text" name="productscale" /> <br>
				Vendor: <input type="text" name="productvendor" /> <br>
				Description: <input type="text" name="productdescription" /> <br>  
				Quantity in Stock: <input type="text" name="quantityinstock" /> <br> 
				Buy Price: <input type="text" name="buyprice" /> <br> 
				MSRP: <input type="text" name="msrp" />				
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