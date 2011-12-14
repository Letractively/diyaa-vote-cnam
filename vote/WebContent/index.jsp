<%@ page language="java" contentType="text/html; charset=windows-1256"
    pageEncoding="windows-1256"%>
    <%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>

<%
Class.forName("com.mysql.jdbc.Driver"); 
java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbsurvey","root",""); 
Statement st= con.createStatement(); 
ResultSet rs=st.executeQuery("select * from questiongroup");




int cpt=0;	

while(rs.next()){

cpt++;
	
String a =rs.getString(1);

String b=rs.getString(2);

out.println("<h3>"+cpt+"-<a href=\"view-qg.jsp?ex="+a+"\">"+b+"</a></h3>"); 
	
}

%>









