<%@ page errorPage="error-poll.jsp" %>
<%@ page import="vote.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<jsp:useBean id="vote" class="vote.VotePoll" scope="request"/>
<jsp:setProperty name="vote" property="*"/> 
<%@ include file="language.jsp" %>
<%

//VotePoll vote = new VotePoll();

String nullString = null;
boolean loaded = false;
String message = "";
String b, opts = "";
int idQuestion = 0;
Connection conn;

VoteDB db = new VoteDB();
if(db.init(getServletContext().getRealPath("code/database.txt"))) {
    conn = db.getConnection();
    
    try {
	b = new String(request.getParameter("idQuestion"));
	idQuestion = Integer.parseInt(b);
    } catch(Exception e) {
        b = "";
    }
				    
    if(b.length()>0 && conn!=null && idQuestion>0) {
	//Specified
        vote = new VotePoll(idQuestion,conn);
    } else {
	//Last active
	vote = new VotePoll(conn);
    }
    
    if(vote.getLoaded()>0) {
        /* Sample option output */
	Vector opt = vote.getOpt();
        VoteOption op;
	int total = 0, gtotal;
	for(int i=0;i<opt.size();i++) {
	    op = (VoteOption)opt.elementAt(i);
	    total += op.getCounter();
	}
	gtotal = total;
	if(total<1) gtotal = 1;
	for(int i=0;i<opt.size();i++) {
	    op = (VoteOption)opt.elementAt(i);
	    opts = opts +(i>0?"<br>":"") + op.getOptionid() + ") ";
	    opts = opts + op.getOptiontext() + " - " + op.getCounter() + "(";
	    opts = opts + String.format("%02.2f",100.0*op.getCounter()/gtotal) + "%)";
	}
	opts = opts + "<hr>" + trans.s("view.total.votes","Total votes") + ": " + total;
	loaded = true;
    } else {
	//out.println(vote.getStatus());
    }
}
%>