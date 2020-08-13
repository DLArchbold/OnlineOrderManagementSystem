<%@page import="domain.Product"%>
<%@page import="domain.Productline"%>
<%@page import="java.util.*"%>
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
		//ProductT pro = (ProductT) request.getAttribute("PRO");
		Product pro = (Product) request.getAttribute("1pro");
		List<Productline> prolines = (List<Productline>) request.getAttribute("prolines");
		List<Product> pros = (List<Product>) request.getAttribute("pros");
	%>
	<form action="ProductServlet" method="post">
		<table>
			<tr>
				<td>Product Code</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"productcode\" readonly value="+ "\""+ pro.getProductcode()+ "\"" + " maxlength=\"9\">");
					%>
				</td>
			</tr>
			<tr>
				<td>Product Name</td>
				<td>
					<%out.println("<input type=\"text\" name=\"productname\" value=" + "\""+  pro.getProductname()+ "\"" + " maxlength=\"43\">");
						
					%>
				</td>
			</tr>
			<tr>
				<td>Product Line</td>
				<td>
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
				</td>
			</tr>
			<tr>
				<td>Product Scale</td>
				<td>
					<%out.println("<input type=\"text\" name=\"productscale\" value=" + "\""+ pro.getProductscale()+ "\"" + " maxlength=\"5\">");
						
					%>
				</td>
			</tr>
			<tr>
				<td>Product Vendor</td>
				<td>
					<%out.println("<input type=\"text\" name=\"productvendor\" value=" + "\""+   pro.getProductvendor()+ "\"" + " maxlength=\"25\">");
						
					%>
				</td>
			</tr>
			<tr>
				<td>Product Description</td>
				<td>
					<%out.println("<input type=\"text\" name=\"productdescription\" value=" + "\""+  pro.getProductdescription()+ "\"" + " maxlength=\"495\">");
						
					%>
				</td>
			</tr>
			<tr>
				<td>Quantity in Stock</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"quantityinstock\" value="+ "\"" + pro.getQuantityinstock()+ "\">");
					%>
				</td>
			</tr>
			<tr>
				<td>Buy Price</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"buyprice\" value="+ "\"" + pro.getBuyprice()+ "\">");
					%>
				</td>
			</tr>
			<tr>
				<td>MSRP</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"msrp\" value=" + "\""+ pro.getMsrp()+ "\">");
					%>
				</td>
			</tr>
		</table>
		<input type="submit" name="UPDATE" value="UPDATE" /> 
		<input type="submit" name="DELETE" value="DELETE" />
	</form>
</body>
</html>