<%@page import="domain.Employee"%>
<%@page import="domain.Office"%>
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
		Employee employee = (Employee) request.getAttribute("1employee");
		List<Office>offices = (List<Office>) request.getAttribute("offices");
		List<Employee> employees = (List<Employee>) request.getAttribute("allemployees");
	%>
	<form action="EmployeesServlet" method="post">
		<table>
			<tr>
				<td>Employee number</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"employeenumber\" readonly value=" + employee.getEmployeenumber());
					%>
				</td>
			</tr>
			<tr>
				<td>Last name</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"lastname\" value=" + employee.getLastname());
					%>
				</td>
			</tr>
			<tr>
				<td>First name</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"firstname\" value=" + employee.getFirstname());
					%>
				</td>
			</tr>
			<tr>
				<td>Extension</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"extension\" value=" + employee.getExtension());
					%>
				</td>
			</tr>
			<tr>
				<td>E-mail</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"email\" value=" + employee.getEmail());
					%>
				</td>
			</tr>
			<tr>
				<td>Office code</td>
				<td>
					<%
					out.println("<select id=\"office\" name=\"officecode\">");			
 							
 					Collections.sort(offices, new Comparator<Office>(){
 						
 						@Override
 						public int compare(Office a, Office b){
 				
 							String cityA = a.getCity().replaceAll("[^A-Za-z]", "");
 							char[] arrA = cityA.toCharArray();
 							
 							String cityB =  b.getCity().replaceAll("[^A-Za-z]", "");
 							char[] arrB = cityB.toCharArray();
 							
 							//return first diff of char from both strings
 							for(int i = 0; i<Math.min(arrA.length, arrB.length); i++){
 								int charA = Character.getNumericValue(arrA[i]);
 								int charB = Character.getNumericValue(arrB[i]);
 								if(charA<charB){
 									
 									return -1;
 								}else if (charA>charB){
 									
 									return 1;
 								}
 							}
 							//return shorter of two cities if no diff between two
 							//up to the length of shorter one
 							
 							return -Integer.compare(arrA.length, arrB.length);
 						}
 						
 					});
					
 					for(Office office: offices){
						
						out.println("<option value=\""+ office.getOfficecode()+ "\">" + office.getCity() + "-" + office.getOfficecode()+ "</option>");
						
					}
 									
 									
 					out.println("</select>");
 							
					%> 
				</td>
			</tr>
			<tr>
				<td>Reports to</td>
				<td>
					<%
						//out.println("<input type=\"text\" name=\"reportsto\" value=" + employee.getReportsto());
					out.println("<select id=\"reportsto\" name=\"reportsto\">");			
						
					//Sort list of employees according to lexicographic
					//order of full names
 					Collections.sort(employees, new Comparator<Employee>(){
 						
 						@Override
 						public int compare(Employee a, Employee b){
 							String nameA = a.getFirstname()  + a.getLastname();
 							char[] arrA = nameA.toCharArray();
 							
 							String nameB = b.getFirstname() + b.getLastname();
 							char[] arrB = nameB.toCharArray();
 							
 							//return first diff of char from both strings
 							for(int i = 0; i<Math.min(arrA.length, arrB.length); i++){
 								int charA = Character.getNumericValue(arrA[i]);
 								int charB = Character.getNumericValue(arrB[i]);
 								if(charA<charB){
 									
 									return -1;
 								}else if (charA>charB){
 									
 									return 1;
 								}
 							}
 							//return shorter of two names if no diff between two
 							//up to the length of shorter one
 							
 							return -Integer.compare(nameA.length(), nameB.length());

  						}
 						
 						
 					});
					
 					for(Employee singleEmployee: employees){
						
						out.println("<option value=\""+ singleEmployee.getEmployeenumber()+ "\">" + singleEmployee.getFirstname() + " " + singleEmployee.getLastname() + "-" + singleEmployee.getEmployeenumber()+ "</option>");
						//out.println(singleEmployee.getFirstname() + singleEmployee.getLastname());
						
					}
 									
 									
 					out.println("</select>");
					%>
				</td>
			</tr>
			<tr>
				<td>Job title</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"jobtitle\" value=" + employee.getJobtitle());
					%>
				</td>
			</tr>
		</table>
		<input type="submit" name="UPDATE" value="UPDATE" /> <input
			type="submit" name="DELETE" value="DELETE" />
	</form>
</body>
</html>