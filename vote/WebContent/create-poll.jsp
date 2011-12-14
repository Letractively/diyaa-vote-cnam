<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="code/create-poll.jsp" %>
<?xml version="1.0" encoding="utf-8"?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<%= trans.s("common.charset","UTF-8") %>" />
<title><%= trans.s("common.create","Create") %></title>
<script type="text/javascript" src="create-poll.js"></script>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>

<form method="post" action="">
<%= message %>
<table border="0" cellspacing="0" cellpadding="0">
<tr>

<%
Class.forName("com.mysql.jdbc.Driver"); 
java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbsurvey","root",""); 
Statement st= con.createStatement(); 
String query = "Select * from questiongroup "; 

ResultSet rs = st.executeQuery(query); 

%> 
<td>Select Questionnaire : <select name="idquestionaire" id="idquestionaire"  value="<% message = new String(vote.getidquestionaire().getBytes("ISO-8859-1"), "UTF-8"); out.print( message ); %>" ><%while (rs.next()) {%>
<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
<% }
%>
</select></td>

<tr>
    <td><%= trans.s("common.title","Title") %>: </td>
    <td><input type="text" name="title" value="<% message = new String(vote.getTitle().getBytes("ISO-8859-1"), "UTF-8"); out.print( message ); %>" maxlength="255"></td>
</tr>

    <td><%= trans.s("common.description","Description") %>: </td>
    <td><input type="text" name="description" value="<% message = new String(vote.getDescription().getBytes("ISO-8859-1"), "UTF-8"); out.print( message ); %>" maxlength="255"></td>
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
<input type="text" name="opt" id="opt" value="<%= c %>" maxlength="255">
<input type="button" name="drop" value=" &minus; " onclick="dropOpt(this);">
<input type="button" id="addopt" value=" + " onclick="addOpt(this,'');">    
    </td></tr>
    </table>
<%= b %>    
    </td>
</tr>
<tr>
    <td><%= trans.s("common.anonymous","Anonymous(IP track)") %>: </td>
    <td><input type="checkbox" name="anonymous" value="Y" <%= vote.getAnonymous().compareToIgnoreCase("Y")==0?"checked":"" %> ></td>
</tr>
<% if(captcha) { %>
<tr>
    <td><img src="captcha.jsp"></td>
    <td valign="top"><%= trans.s("common.enter.code","Please, enter verification code") %><br><input type="text" name="captcha_text" value=""></td>
</tr>
<% } %>
<tr>
    <td colspan="2" align="right"><hr><input type="submit" name="go" value="<%= trans.s("create.poll","Create Poll") %>"></td>
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
</body>
</html>