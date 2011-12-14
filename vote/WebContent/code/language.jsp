<%@ page import="vote.*" %>
<jsp:useBean id="trans" class="vote.VoteTranslate" scope="application"/>
<%

boolean lang = false; /* if we have language loaded */

if(trans.init(getServletContext().getRealPath("code/database.txt"))) {
    // Override config setting example
    // lang = trans.setLanguage("ru");
}

%>