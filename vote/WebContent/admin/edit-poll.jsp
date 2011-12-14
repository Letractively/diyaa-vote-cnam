<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="code/edit-poll.jsp" %>
<?xml version="1.0" encoding="utf-8"?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<%= trans.s("common.charset","UTF-8") %>" />
<title><%= trans.s("edit.poll","Edit Poll") %></title>
<script type="text/javascript" src="edit-poll.js"></script>
<link rel="stylesheet" type="text/css" href="../style.css">
</head>
<body>
<% if(idQuestion>0) { %>
<%= message %>
<form method="post" action="edit-poll.jsp">
<input type="hidden" name="idQuestion" value="<%= idQuestion %>">
<table border="0" cellspacing="0" cellpadding="0">
<%
Class.forName("com.mysql.jdbc.Driver"); 
java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbsurvey","root",""); 
Statement st= con.createStatement(); 
String query = "Select * from questiongroup "; 

ResultSet rs = st.executeQuery(query); 

%> 
<tr><td>Select Questionnaire : <select name="idquestionaire" id="idquestionaire"  value="<% message = new String(vote.getidquestionaire().getBytes("ISO-8859-1"), "UTF-8"); out.print( message ); %>" ><%while (rs.next()) {%>
<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
<% }
%>
</select></td></tr>
<tr>
    <td><%= trans.s("common.title","Title") %>: </td>
    <td><input type="text" name="title" value="<%= vote.getTitle() %>" maxlength="255"></td>
</tr>
<tr>
    <td><%= trans.s("common.description","Description") %>: </td>
    <td><input type="text" name="description" value="<%= vote.getDescription() %>" maxlength="255"></td>
</tr>
<tr>
    <td><%= trans.s("common.max.answers","Max.answers") %>: </td>
    <td><select name="max_answers" id="max_answers">
<option value="1">1</option>
</select></td>
</tr>
<tr>
    <td valign="top"><%= trans.s("common.options","Options") %>: </td>
    <td><table border="0" cellspacing="0" cellpadding="0">
    <tr><td class="options">
<input type="hidden" id="cnt"  name="cnt"  value="<%= cnt %>">
<input type="hidden" id="oid"  name="oid"  value="<%= d %>">
<input type="text"   id="opt"  name="opt"  value="<%= c %>" maxlength="255">
<input type="button" name="drop" value=" &minus; " onclick="dropOpt(this);">
<input type="button" id="addopt" value=" + " onclick="addOpt(this,'',0,0);">
    </td></tr>
    </table>
<%= e %>    
    </td>
</tr>
<tr>
    <td><%= trans.s("common.anonymous","Anonymous(IP track)") %>: </td>
    <td><input type="checkbox" name="anonymous" value="Y" <%= vote.getAnonymous().compareToIgnoreCase("Y")==0?"checked":"" %> ></td>
</tr>
<tr>
    <td colspan="2" align="right"><hr><input type="submit" name="go" value="<%= trans.s("edit.update.poll","Update Poll") %>"></td>
</tr>
</table>
<script language="JavaScript">
var ma = document.getElementById("max_answers");
for(var i=0;i<ma.options.length;i++) {
    if(ma.options[i].value=='<%= max_opts %>') {
	ma.selectedIndex = i;
    }
}
</script>
</form>
<% } else { %>
<%= trans.s("common.incorrect.poll","Incorrect Poll ID") %>
<% } %>
</body>
</html>
