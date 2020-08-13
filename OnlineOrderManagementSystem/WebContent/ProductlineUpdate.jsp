<%@page import="domain.Productline"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Update Product</title>
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
		Productline pro = (Productline) request.getAttribute("1proline");
	%>
	<form action="ProductlineServlet" method="post">
		<table>
			<tr>
				<td>Product Line</td>
				<td>
					<%
						
						out.println("<input type=\"text\" name=\"productline\" readonly value="+ "\"" +pro.getProductline()+"\""+ " maxlength=\"16\">");
					%>
				</td>
			</tr>
			<tr>
				<td>Text Description</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"textdescription\" value=" + "\""+ pro.getTextdescription()+ "\"" + " maxlength=\"735\">");
					%>
				</td>
			</tr>
			<tr>
				<td>HTML Description</td>
				<td>
					<%	
						out.println("<input type=\"text\" name=\"htmldescription\" value=\""+ pro.getHtmldescription()+ "\">");
					%>
				</td>
			</tr>
			<tr>
				<td>Image</td>
				<td>
					<%out.println("<input type=\"text\" name=\"image\" value=\""+ pro.getImage()+ "\">");
						
					%>
				</td>
			</tr>
		</table>
		<input type="submit" name="UPDATE" value="UPDATE" /> 
		<input type="submit" name="DELETE" value="DELETE" />
	</form>
</body>
</html>