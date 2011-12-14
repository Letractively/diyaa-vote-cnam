<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="code/view-polls.jsp" %>
<?xml version="1.0" encoding="utf-8"?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<%= trans.s("common.charset","UTF-8") %>" />
<title><%= trans.s("common.view","View") %></title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
<%= message %>
<table border="0" cellspacing="0" cellpadding="0"> 
<%
if(conn!=null) {
    Statement st = conn.createStatement();
    ResultSet rs = st.executeQuery("SELECT * FROM question ORDER BY idQuestion DESC");
    while (rs.next()) {
	if(rs.getString("enabled").compareToIgnoreCase("Y")==0) {
%><tr>
    <td>
[<%= rs.getInt("idQuestion") %>]
[<a href="view-poll.jsp?idQuestion=<%= rs.getInt("idQuestion") %>" target=""><%= trans.s("common.view","View") %></a>]
<% if(rs.getString("expired").compareToIgnoreCase("N")==0) { %>
[<a href="vote-poll.jsp?idQuestion=<%= rs.getInt("idQuestion") %>" target=""><%= trans.s("common.vote","Vote") %></a>]
<% } else { %>
[<%= trans.s("common.expired","Expired") %>]
<% } %>
    </td>
    <td><b><%= trans.s("common.title","Title") %>:</b> </td>
        <td><%= new String(rs.getString("QuestionTitle").getBytes("ISO-8859-1"),"UTF-8") %></td>
  
</tr>

<tr>
    <td colspan="3"><hr></td>
</tr>
<%
	}
    }
    rs.close();
    st.close();
}
%>
</table>
</body>
</html>
