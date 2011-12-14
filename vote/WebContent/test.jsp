<%@ page import="java.sql.*,java.util.*,java.net.*" %>
<%

Properties props;
Connection conn;
String url;

props = new Properties();
Class.forName("com.mysql.jdbc.Driver");
url = "jdbc:mysql://127.0.0.1/dbsurvey";
props.setProperty("user","vote");
props.setProperty("password","vote001");
conn = DriverManager.getConnection(url, props);

if(conn!=null) {
    out.println("Connected");
} else {
    out.println("Failure");
}

%>