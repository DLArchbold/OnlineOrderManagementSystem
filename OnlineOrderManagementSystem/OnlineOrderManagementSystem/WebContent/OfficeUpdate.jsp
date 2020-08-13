<%@page import="domain.Office"%>
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
	Office office = (Office) request.getAttribute("1office");
	%>
	<form action="OfficesServlet" method="post">
		<table>
			<tr>
				<td>Office code</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"officecode\" readonly value=" + office.getOfficecode());
					%>
				</td>
			</tr>
			<tr>
				<td>City</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"city\" value=" + office.getCity());
					%>
				</td>
			</tr>
			<tr>
				<td>Phone</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"phone\" value=" + office.getPhone());
					%>
				</td>
			</tr>
			<tr>
				<td>Address Line 1</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"addressline1\" value=" + office.getAddressline1());
					%>
				</td>
			</tr>
			<tr>
				<td>Address Line 2</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"addressline2\" value=" + office.getAddressline2());
					%>
				</td>
			</tr>
			<tr>
				<td>State</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"state\" value=" + office.getState());
					%>
				</td>
			</tr>
			<tr>
				<td>Country</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"country\" value=" + office.getCountry());
					%>
				</td>
			</tr>
			<tr>
				<td>Postal code</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"postalcode\" value=" + office.getPostalcode());
					%>
				</td>
			</tr>
			<tr>
				<td>Territory</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"territory\" value=" + office.getTerritory());
					%>
				</td>
			</tr>
		</table>
		<input type="submit" name="UPDATE" value="UPDATE" /> <input
			type="submit" name="DELETE" value="DELETE" />
	</form>
</body>
</html>