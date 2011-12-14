<%@ page errorPage="error-poll.jsp" %>
<%@ page import="vote.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<jsp:useBean id="vote" class="vote.VotePoll" scope="request"/>
<jsp:setProperty name="vote" property="*"/>
<%@ include file="language.jsp" %>
<%

String message = "";
String a, b;
int idQuestion = 0;
Connection conn = null;

VoteDB db = new VoteDB();
if(db.init(getServletContext().getRealPath("code/database.txt"))) {
    conn = db.getConnection();
} else {
    message = "<span class='error'>" + trans.s("common.cannot.connect","Cannot connect to DB") + "</span>";
    conn = null;
}

%>