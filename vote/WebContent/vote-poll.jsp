<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="code/vote-poll.jsp" %>
<?xml version="1.0" encoding="utf-8"?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<%= trans.s("common.charset","UTF-8") %>" />
<% if(loaded) { %>
<title><%= trans.s("common.vote","Vote") %></title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
<%= message %>
<form method="post" action="vote-poll.jsp">
<input type="hidden" name="idQuestion" value="<%= idQuestion %>">
<table border="0" cellspacing="0" cellpadding="0">
<tr>
    <td><%= trans.s("common.title","Title") %>: </td>
    <td><%= vote.getTitle() %></td>
</tr>
<tr>
    <td><%= trans.s("common.description","Description") %>: </td>
    <td><%= vote.getDescription() %></td>
</tr>
<tr>
    <td><%= trans.s("common.max.answers","Max.answers") %>: </td>
    <td><%= vote.getMaxanswers() %></td>
</tr>
<tr>
    <td valign="top"><%= trans.s("common.options","Options") %>: </td>
    <td><table border="0" cellspacing="0" cellpadding="0">
    <tr><td><%= opts %></td></tr>
    </table></td>
</tr>
<!-- tr>
    <td><%= trans.s("common.anonymous","Anonymous(IP track)") %>: </td>
    <td><%= vote.getAnonymous().compareToIgnoreCase("Y")==0?"Yes":"No" %></td>
</tr>
<tr>
    <td><%= trans.s("common.enabled","Enabled") %>: </td>
    <td><%= vote.getEnabled().compareToIgnoreCase("Y")==0?"Yes":"No" %></td>
</tr>
<tr>
    <td><%= trans.s("common.expired","Expired") %>: </td>
    <td><%= vote.getExpired().compareToIgnoreCase("Y")==0?"Yes":"No" %></td>
</tr -->
<% if(captcha) { %>
<tr>
    <td><img src="captcha.jsp"></td>
    <td valign="top"><%= trans.s("common.enter.code","Please, enter verification code") %>
	<br><input type="text" name="captcha_text" value=""></td>
</tr>
<% } %>
<tr>
    <td colspan="2"><input type="submit" name="go" value=" <%= trans.s("vote.now","Vote!") %> "></td>
</tr>
</table>
<br>
<a href="view-poll.jsp?idQuestion=<%= vote.getId() %>"><%= trans.s("view.results","View Results") %></a>
</form>
</body>
</html>
<% } else { %>
<title><%= trans.s("common.view","View") %></title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
<%= trans.s("common.cannot.load","Cannot load Poll") %>
<br>
<%= message %>
</body>
</html>
<% } %>
