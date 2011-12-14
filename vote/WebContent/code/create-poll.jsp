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
String   a = "", /* form trigger */
	 b = "", /* javascript */
	 c = "", /* first option */
	 d = "", /* captcha check */
	 message = "", t_str = "";
String[] opt;
int max_opts = 0;
int k=0;

try {
    a = new String(request.getParameter("go"));
} catch(Exception e) {
    a = "";
}


  
   

if(request.getParameterValues("opt")!=null) {
    opt = request.getParameterValues("opt");
    VoteOption op;
    for(int i=0;i<opt.length;i++) {
	op = new VoteOption(0,i+1,opt[i],0);
	vote.addOpt(op);
    }
    if(opt.length>0) {
	c = new String(opt[0].getBytes("ISO-8859-1"), "UTF-8");
	b = "<script language='javascript'>\nvar opts = new Array(";
	for(int i=0;i<opt.length;i++) {
	    t_str = new String(opt[i].getBytes("ISO-8859-1"), "UTF-8");
	    b = b + (i>0?",'":"'") + t_str + "'";
	}
	b = b + ");\naddOptions(opts);\n</script>\n";
    }
}

if(a.length()>0) {
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
    if(d.length()>0 && vote.checkValid()) {
	VoteDB db = new VoteDB();
	if(db.init(getServletContext().getRealPath("code/database.txt"))) {
	    Connection conn = db.getConnection();
	    vote.setMaxanswers(request.getParameter("max_answers"));
	    max_opts = vote.getMaxanswers();
    	    if(vote.insertPoll(conn)) {
		message = "<span class='success'>" + trans.s("common.created","Created") + "</span>";
	    } else {
		message = "<span class='error'>" + trans.s("create.cannot.create","Cannot create record");
		message+= "</span>"+vote.getStatus();
    	    }
	} else {
	    message = "<span class='error'>" + trans.s("common.cannot.connect","Cannot connect to DB") + "</span>";
	}
    } else {
	message = "<span class='error'>" + trans.s("common.fill.form","Fill out the form") + "</span>";
    }
}

%>