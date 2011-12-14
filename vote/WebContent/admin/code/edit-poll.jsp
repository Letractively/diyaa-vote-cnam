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
String a, b, c = "", e = ""; 
int d = 1;
Vector opt;
int idQuestion = 0, max_opts = 0, cnt = 0;
Connection conn;

/*
Legend:
	a,b - temporary vars
	c - first option text
	d - first option id
	e - javascript supplement

*/

VoteDB db = new VoteDB();
if(db.init(getServletContext().getRealPath("code/database.txt"))) {
    conn = db.getConnection();
    try {
	a = new String(request.getParameter("go"));
    } catch(Exception ex) {
	a = "";
    }

    try {
	b = new String(request.getParameter("idQuestion"));
	idQuestion = Integer.parseInt(b); 
    } catch(Exception ex) {
	b = "";
    }

    if(b.length()>0 && conn!=null) {
	try {
	    if(idQuestion>0) {
		vote.setId(idQuestion);
		if(a.length()>0) {
		    //Update Poll
		    if(request.getParameterValues("opt")!=null && request.getParameterValues("oid")!=null && request.getParameterValues("cnt")!=null) {
			vote.setOptions(new Vector());
			String[] opts = request.getParameterValues("opt");
			String[] opti = request.getParameterValues("oid");
			String[] optc = request.getParameterValues("cnt");
			VoteOption op;
			boolean good = true;
			for(int i=0;i<opts.length;i++) {
			    try {
	        		op = new VoteOption(idQuestion,opti[i],opts[i],optc[i]);
			        vote.addOpt(op);
			    } catch(Exception ex) {
				good = false;
				ex.printStackTrace();
			    }
			}
			vote.setMaxanswers(request.getParameter("max_answers"));
	    		if(good && vote.updatePoll(conn)) {
			    message = "<span class='success'>Poll is updated</span>";
			} else {
			    message = "<span class='error'>Cannot update Poll</span>";
			}
		    } else {
			message = "<span class='error'>Incorrect option parameters</span>";
		    }
		} 
		//Load Poll
		vote.loadPoll(idQuestion,conn);
		max_opts = vote.getMaxanswers();
		opt = vote.getOpt();
		if(opt.size()>0) {
		    VoteOption op = (VoteOption)opt.elementAt(0);
		    c = op.getOptiontext();
		    d = op.getOptionid();
		    cnt = op.getCounter();
		    e = "<script language='JavaScript'>\nvar opts = new Array(";
		    String e1 = "", e2 = "", e3 = "";
		    for(int i=0;i<opt.size();i++) {
		        op = (VoteOption)opt.elementAt(i);
		        e1 = e1 + (i>0?",":"") + "'" + op.getOptiontext() + "'";
		        e2 = e2 + (i>0?",":"") + "'" + op.getOptionid() + "'";
		        e3 = e3 + (i>0?",":"") + "'" + op.getCounter() + "'";
		    }
		    e = e + e1;
		    e = e + ");\nvar opt_ids = new Array(" + e2;
		    e = e + ");\nvar opt_cnt = new Array(" + e3;
		    e = e + ");\naddOptions(opts,opt_ids,opt_cnt);\n</script>";
		}
	    } else {
		message = "<span class='error'>Incorrect Poll ID</span>";
	    }
	} catch(Exception ex) {
    	    message = "<span class='error'>Poll Error</span>";
	    ex.printStackTrace();
	}
    }
} else {
    message = "<span class='error'>Cannot connect to DB</span>";
    conn = null;
}

%>