<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="code/view-poll.jsp" %>
<?xml version="1.0" encoding="utf-8"?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<%= trans.s("common.charset","UTF-8") %>" />
<% if(loaded) { %>
<title><%= trans.s("common.view","View") %></title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
<%= message %>
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
    </table>
    </td>
</tr>


</table>
<br>
<a href="vote-poll.jsp?idQuestion=<%= vote.getId() %>"><%= trans.s("vote.now","Vote!") %></a>
</form>
</body>
</html>
<% } else { %>
<title><%= trans.s("common.view","View") %></title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
<%= trans.s("common.cannot.load","Cannot load Poll") %>
</body>
</html>
<% } %>