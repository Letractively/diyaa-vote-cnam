<%@ page errorPage="error-poll.jsp" %>
<%@ page import="vote.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<jsp:useBean id="vote" class="vote.VotePoll" scope="request"/>
<jsp:setProperty name="vote" property="*"/> 
<%@ include file="language.jsp" %>
<%

boolean captcha = false;
boolean loaded = false;
String message = "";
String 	a = "", /* form trigger */
	b = "", /* poll ID */
	d = "", /* captcha check */
	opts = ""; /* options */
int idQuestion = 0;
Connection conn;

VoteDB db = new VoteDB();
if(db.init(getServletContext().getRealPath("code/database.txt"))) {
    conn = db.getConnection();
    
    try {
	a = new String(request.getParameter("go"));
    } catch(Exception e) {
	a = "";
    }    
    
    try {
	b = new String(request.getParameter("idQuestion"));
	idQuestion = Integer.parseInt(b);
    } catch(Exception e) {
        b = "";
    }

    //captcha enabled?
    if(captcha) {
        try {
            d = new String(request.getParameter("captcha_text"));
            if(session.getAttribute( "captcha" ).toString().compareToIgnoreCase(d)==0) {
                d = "captcha passed";
            } else {
                d = "";
            }
        } catch(Exception e) {
            d = "";
        }
    } else {
        d = "captcha is disabled";
    }

    if(a.length()>0 && b.length()>0 && d.length()>0 && idQuestion>0 && conn!=null && request.getParameterValues("opt")!=null) {
	vote = new VotePoll(idQuestion,conn);
	if(vote.vote(request.getParameterValues("opt"),conn,request.getRemoteHost(),request.getRemoteHost())) {
	    //Forward to see results
%>
<jsp:forward page="view-poll.jsp"> 
<jsp:param name="idQuestion" value="<%= idQuestion %>" />
</jsp:forward>
<%
	    System.exit(0);
	} else {
	    message = "<span class='error'>" + trans.s("vote.error","Vote error") + ": " + vote.getStatus() + "</span>";
	}
    } else {
	if(a.length()>0) {
	    message = "<span class='error'>" + trans.s("common.fill.form","Fill out the form") + "</span>";
	}
    }

    if(b.length()>0 && conn!=null && idQuestion>0) {
	//Specified
        vote = new VotePoll(idQuestion,conn);
    
	int ma = vote.getMaxanswers();
	String control = (ma>1?"checkbox":"radio");
    
	if(vote.getLoaded()>0) {
	    /* Sample option output */
	    Vector opt = vote.getOpt();
    	    VoteOption op;
	    for(int i=0;i<opt.size();i++) {
		op = (VoteOption)opt.elementAt(i);
		opts = opts + (i>0?"<br>":"") + "<input type='" + control + "' name='opt' id='opt' value='" + op.getOptionid() + "'> " + op.getOptiontext();
	    }
	    loaded = true;
	} else {
	    message = vote.getStatus();
	}
    } else {
	message = trans.s("common.incorrect.poll","Incorrect Poll ID");
    }
}
%>
