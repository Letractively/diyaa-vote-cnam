<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%
String question=request.getParameter("questiongroup");
Class.forName("com.mysql.jdbc.Driver"); 
java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbsurvey","root",""); 
Statement st= con.createStatement(); 
ResultSet rs; 
int i=st.executeUpdate("insert into questiongroup(QGTitle) values('"+question+"')");
%>
<%
String redirectURL = "../index.jsp";
response.sendRedirect(redirectURL);
%>

