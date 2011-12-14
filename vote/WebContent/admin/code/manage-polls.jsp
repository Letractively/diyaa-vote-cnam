<%@ page errorPage="../error-poll.jsp" %>
<%@ page import="vote.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<jsp:useBean id="vote" class="vote.VotePoll" scope="request"/>
<jsp:setProperty name="vote" property="*"/>
<%@ include file="../../code/language.jsp" %>
<%

String message = "";
String a, b;
int idQuestion = 0;
Connection conn = null;

VoteDB db = new VoteDB();
if(db.init(getServletContext().getRealPath("code/database.txt"))) {
    conn = db.getConnection();

    try {
	a = new String(request.getParameter("a"));
    } catch(Exception e) {
	a = "";
    }

    try {
	b = new String(request.getParameter("idQuestion"));
	idQuestion = Integer.parseInt(b); 
    } catch(Exception e) {
	b = "";
    }

    if(a.length()>0 && b.length()>0 && conn!=null) {
	try {
	    if(idQuestion>0) {
		vote = new VotePoll(idQuestion,conn);
		if(vote.getLoaded()==1) {
	    	    message = "<span class='success'>" + vote.updateState(conn,a) + "</span>";
		} else {
		    message = "<span class='error'>Cannot load Poll</span>";
		}
	    } else {
		message = "<span class='error'>Incorrect Poll ID</span>";
	    }
	} catch(Exception e) {
    	    message = "<span class='error'>Incorrect Poll ID</span>";
	}
    }
} else {
    message = "<span class='error'>Cannot connect to DB</span>";
    conn = null;
}

%>