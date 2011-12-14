package vote;

import vote.VoteOption;
import java.util.*;
import java.sql.*;
import java.io.*;

import java.util.*;
import java.beans.beancontext.*;

public class VotePoll{



    /* Main poll data */
    int    id;
    int idqg;
    String title;
    int    max_answers;
    String description;
    String idquestionaire;
    String enabled;
    String anonymous;
    String expired;
    
    private int    loaded;
    private Vector<VoteOption> options;
    private String status;
    private int    total;
    
    private static int max_options = 20;
    
    
    
    //Default constructor
    public VotePoll() {
setDefaults();
checkIntegrity();
    }
    //Load last active poll
    public VotePoll(Connection conn) {
if(loadPoll(0, conn)) {
   loaded = 1;
} /* else {
   status = "Cannot load poll";
} */
    }
    //Load specified poll
    public VotePoll(int value, Connection conn) {
if(value>0 && loadPoll(value, conn)) {
   loaded = 1;
} /* else {
   status = "Cannot load poll";
} */
    }

    public VotePoll(String t) {
setDefaults();
title = t;
checkIntegrity();
    }

    public VotePoll(String t, int m) {
setDefaults();
title = t;
max_answers = m;
checkIntegrity();
    }

    public VotePoll(String t, int m, String d) {
setDefaults();
title = t;
max_answers = m;
description = d;
checkIntegrity();
    }

    public VotePoll(String t, int m, String d, String e) {
setDefaults();
title = t;
max_answers = m;
description = d;
enabled     = e;
checkIntegrity();
    }

    public VotePoll(String t, int m, String d, String e, String a) {
title = t;
max_answers = m;
description = d;
enabled     = e;
anonymous   = a;
expired     = "N";
total       = 0;
options     = new Vector<VoteOption>();
checkIntegrity();
    }


    public VotePoll(String t, int m, String d, String e, String a, String x) {
title = t;
max_answers = m;
description = d;
enabled     = e;
anonymous   = a;
expired     = x;
total       = 0;
options     = new Vector<VoteOption>();
checkIntegrity();
    }
    public VotePoll(String t, int m, String d, String e, String a, String x, int i) {
    title = t;
   // idqg=i;
    max_answers = m;
    description = d;
    enabled     = e;
    anonymous   = a;
    expired     = x;
    total       = 0;
    options     = new Vector<VoteOption>();
    checkIntegrity();
        }

    public VotePoll(String t, int m, String d, String e, String a, String x, int i,String di) {
        title = t;
        //idqg=i;
        max_answers = m;
        description = d;
        idquestionaire=di;
        enabled     = e;
        anonymous   = a;
        expired     = x;
        total       = 0;
        options     = new Vector<VoteOption>();
        checkIntegrity();
            }
    private void setDefaults() {
title = "";
max_answers = 1;
description = "";
//diko = "";
idquestionaire="";
enabled     = "N";
anonymous   = "Y";
expired     = "N";    
total       = 0;
options     = new Vector<VoteOption>();

    }

    /* Main poll data access */
    public int    getLoaded()      { return loaded; }
    public int    getId()          { return id; }
    public int    getIdqg()          { return idqg; }
    public String getTitle()       { return title; }
    public int    getMaxanswers()  { return max_answers; }
    public String getDescription() { return description; }
    //public String getdiko() { return diko; }
    public String getidquestionaire() { return idquestionaire; }
    public String getEnabled()     { return enabled; }
    public String getAnonymous()   { return anonymous; }
    public String getExpired()     { return expired; }
    public String getStatus()      { return status; }
    public Vector getOpt()         { return options; }
    public int    getTotal()       { return total; }
    
    /* Setting Main poll data */
    public void setId (int value)             { id = value;          checkIntegrity(); }
    public void setIdqg (int value)             { idqg = value;          checkIntegrity(); }
    public void setMaxanswers (int value)     { max_answers = value; checkIntegrity(); }
    public void setEnabled (String value)     { enabled = value;     checkIntegrity(); }
    public void setAnonymous (String value)   { anonymous = value;   checkIntegrity(); }
    public void setExpired (String value)     { expired = value;     checkIntegrity(); }
    public void setOptions(Vector<VoteOption> value) { options = value;  checkIntegrity(); }
    public void setTitle (String value)       { title = value; checkIntegrity(); }
    public void setDescription (String value) { description = value; checkIntegrity(); }
    //public void setdiko (String value) { diko = value; checkIntegrity(); }
    public void setidquestionaire (String value) { idquestionaire = value; checkIntegrity(); }
    
    public void addOpt(VoteOption value) { 
if(options.size()<1) {
   options = new Vector<VoteOption>();
}
options.add(value);
checkIntegrity(); 
    }

    public void setMaxanswers (String value) {
try {
   max_answers = Integer.parseInt(value);
   if(max_answers<1 || max_answers>max_options) max_answers = 1;
} catch(Exception e) {
   max_answers = 1;
}
    }

    /* Utils */
    //Loads poll from the DB
    public boolean loadPoll(int value, Connection conn) {
loaded = 0;
PreparedStatement st;
try {
   if(value>0) {
//Load specified poll
st = conn.prepareStatement("SELECT * FROM question WHERE idQuestion=?");
st.setInt(1, value);
   } else {
//Load last active poll
st = conn.prepareStatement("SELECT * FROM question WHERE enabled='Y' AND expired='N' ORDER BY idQuestion DESC LIMIT 1");
   }
   ResultSet rs = st.executeQuery();
   if(rs.next()) {
id    = rs.getInt("idQuestion");
idquestionaire =rs.getString("idQuestionGroup");
max_answers = rs.getInt("max_answers"); 
enabled   = rs.getString("enabled");
anonymous = rs.getString("anonymous");
expired   = rs.getString("expired");
try {
   title = new String(rs.getString("QuestionTitle").getBytes("ISO-8859-1"), "UTF-8");
   description = new String(rs.getString("QuestionDesc").getBytes("ISO-8859-1"), "UTF-8");
   //diko = new String(rs.getString("diko").getBytes("ISO-8859-1"), "UTF-8");
   idquestionaire = new String(rs.getString("idQuestionGroup").getBytes("ISO-8859-1"), "UTF-8");
} catch(UnsupportedEncodingException e) {
   title = rs.getString("QuestionTitle");
   description = rs.getString("QuestionDesc");
   //diko = rs.getString("diko");
 
   e.printStackTrace();
}
rs.close();
st.close();
//Load options
st = conn.prepareStatement("SELECT * FROM subquestion WHERE idQuestion=? ORDER BY idSubQuestion ASC");
st.setInt(1, id);
rs = st.executeQuery();
options = new Vector<VoteOption>();
total = 0;
String t_str;
while(rs.next()) {
   try {
t_str = new String(rs.getString("SubQuestionTitle").getBytes("ISO-8859-1"), "UTF-8");
   } catch(UnsupportedEncodingException e) {
t_str = rs.getString("SubQuestionTitle");
e.printStackTrace();
       }
   VoteOption op = new VoteOption(id,rs.getInt("idSubQuestion"),t_str,rs.getInt("counter"));
   options.add(op);
   total += rs.getInt("counter");
}
status = "Poll is loaded";
return true;
   } else {
status = "Poll is not found";
   }
   st.close();
} catch (SQLException e) {
   status = "SQLException";
   System.out.println(status);
}
return false;
    }

    //setEnabled: enable/disable Poll
    public boolean setEnabledDB(Connection conn, String value) {
if(!checkValid()) return false;
try {
   PreparedStatement st = conn.prepareStatement("UPDATE question SET enabled=? WHERE idQuestion=?");
   st.setString(1, value);
   st.setInt(2, id);
   int n = st.executeUpdate();
   if(n>0) {
status  = "Poll is updated";
enabled = value;
return true;
   } else {
status = "Cannot update Poll";
   }
   st.close();
} catch (SQLException e) {
   status = "SQLException";
   System.out.println(status);
   e.printStackTrace();
}
return false;
    }
    
    //setExpired: expires/unexpires Poll
    public boolean setExpiredDB(Connection conn, String value) {
if(!checkValid()) return false;
try {
   PreparedStatement st = conn.prepareStatement("UPDATE question SET expired=? WHERE idQuestion=?");
   st.setString(1, value);
   st.setInt(2, id);
   int n = st.executeUpdate();
   if(n>0) {
status  = "Poll is updated";
expired = value;
return true;
   } else {
status = "Cannot update Poll";
   }
   st.close();
} catch (SQLException e) {
   status = "SQLException";
   System.out.println(status);
   e.printStackTrace();
}
return false;
    }
    
    //Updates poll in the DB
    public boolean updatePoll(Connection conn) {
if(!checkValid()) return false;
try {
   PreparedStatement st = conn.prepareStatement("UPDATE question SET idQuestionGroup=?,QuestionTitle=?,max_answers=?,QuestionDesc=?,enabled=?,anonymous=?,expired=? WHERE idQuestion=?");
  
   st.setString(1, idquestionaire);
   st.setString(2, title);
   st.setInt(3, max_answers);
   st.setString(4, description);
   st.setString(5, enabled);
   st.setString(6, anonymous);
   st.setString(7, expired);
   st.setInt(8, id);
   int n = st.executeUpdate();
   if(n>0) {
status = "Poll is updated";
VoteOption op;
Vector<VoteOption> np = new Vector<VoteOption>();
String cl = "0";
for(int i=0;i<options.size();i++) {
   op = (VoteOption)options.elementAt(i);
   if(op.getPollid()<1) {
if(op.getOptionid()<1) {
   //Batch new entries
   np.add(op);
} else {
   //Insert
   st = conn.prepareStatement("INSERT INTO subquestion VALUES(?,?,?,0)");
   st.setInt(1, id);
   st.setInt(2, op.getOptionid());
   st.setString(3, op.getOptiontext());
   cl = cl + "," + op.getOptionid();
}
   } else {
if(op.getOptionid()<1) {
   //Batch new entries
   np.add(op);
} else {
   //Update
   st = conn.prepareStatement("UPDATE subquestion SET SubQuestionTitle=? WHERE idQuestion=? AND idSubQuestion=?");
   st.setInt(2, id);
   st.setInt(3, op.getOptionid());
   st.setString(1, op.getOptiontext());
   cl = cl + "," + op.getOptionid();
}
   }
   //Execute update if not batched
   if(op.getOptionid()>0) {
try {
   st.executeUpdate();
} catch(Exception e) {
   e.printStackTrace();
   status = "Error updating option";
}
   }
}
try {
   //Clear deleted options
   st = conn.prepareStatement("DELETE FROM subquestion WHERE idQuestion=? AND idSubQuestion NOT IN (" + cl + ")");
   st.setInt(1, id);
   st.executeUpdate();
} catch(Exception e) {
   status = "Cannot delete obsolete options";
   e.printStackTrace();
}
if(np.size()>0) {
   //Process batched entries
   //Get new option id base
   st = conn.prepareStatement("SELECT MAX(idSubQuestion) AS ob FROM subquestion WHERE idQuestion=?");
   st.setInt(1, id);
   ResultSet rs = st.executeQuery();
   int ob = 1;
   if(rs.next()) {
ob = rs.getInt("ob"); 
   }
   //Insert new entry
   st = conn.prepareStatement("INSERT INTO subquestion VALUES(?,?,?,0)");
   st.setInt(1, id);
   for(int i=0;i<np.size();i++) {
op = (VoteOption)np.elementAt(i);
st.setInt(2, ob+i+1);
st.setString(3, op.getOptiontext());
try {
   st.executeUpdate();
} catch(Exception e) {
   e.printStackTrace();
   status = "Error inserting option";
}
   }
}
return true;
   } else {
status = "Cannot update Poll";
   }
   st.close();
} catch (SQLException e) {
   status = "SQLException";
   System.out.println(status);
   e.printStackTrace();
}
return false;
    }

    //Deletes poll from the DB
    public boolean deletePoll(int value, Connection conn) {
id = value;
return deletePoll(conn);
    }
    
    public boolean deletePoll(Connection conn) {
if(id>0) {
   try {
PreparedStatement st = conn.prepareStatement("DELETE FROM question WHERE idQuestion=?");
st.setInt(1, id);
st.executeUpdate();
st.close();
status = "Poll is deleted";
return true;
   } catch (SQLException e) {
status = "SQLException";
System.out.println(status);
   }
}
return false;
    }
    
    
 
    
    //Creates poll in the DB
    public boolean insertPoll(Connection conn) {
if(!checkValid()) return false;
try {
   //Insert new poll record
   PreparedStatement st = conn.prepareStatement("INSERT INTO question (idQuestionGroup,QuestionTitle,max_answers,QuestionDesc,enabled,anonymous,expired) VALUES(?,?,?,?,?,?,?)");
   st.setString(1, idquestionaire);
   st.setString(2, title);
   st.setInt(3, max_answers);
   st.setString(4, description);
   st.setString(5, enabled);
   st.setString(6, anonymous);
   st.setString(7, expired);
   st.executeUpdate();
   //Get inserted poll id
   PreparedStatement sst = conn.prepareStatement("SELECT idQuestion FROM question WHERE idQuestionGroup=? AND QuestionTitle=? AND max_answers=? AND QuestionDesc=? AND enabled=? AND anonymous=? AND expired=? ORDER BY idQuestion DESC LIMIT 1");
   sst.setString(1, idquestionaire);
   sst.setString(2, title);
   sst.setInt(3, max_answers);
   sst.setString(4, description);
   sst.setString(5, enabled);
   sst.setString(6, anonymous);
   sst.setString(7, expired);
   ResultSet rs = sst.executeQuery();
   if(rs.next()) {
id  = rs.getInt("idQuestion");
loaded = 1;
rs.close();
st.close();
sst.close();
//Insert poll options
st = conn.prepareStatement("INSERT INTO subquestion VALUES(?,?,?,0)");
st.setInt(1, id);
VoteOption op;
for(int i=0;i<options.size();i++) {
   op = (VoteOption)options.elementAt(i);
   st.setInt(2, i+1);
   st.setString(3, op.getOptiontext());
   st.executeUpdate();
}
status = "Poll is inserted";
return true;
   } else {
status = "Cannot get new poll ID";
   }
   st.close();
} catch (SQLException e) {
   status = "SQLException: "+e.toString();
   System.out.println(status);
   e.printStackTrace();
}
return false;
    }

    //Enforcing integrity check
    private void checkIntegrity() {
if(title.length()>255) title = title.substring(0, 255);
if(options==null) options = new Vector<VoteOption>();
if(options.size()>max_options) options.setSize(max_options);
try {
   if(options.size()>0) {
String s;
VoteOption op;
for(int i=0;i<options.size();i++) {
   op = (VoteOption)options.elementAt(i);
   s = op.getOptiontext();
   if(s.length()<1 || s.length()>255) {
op.setOptiontext(s.substring(0,255));
   }
}
   }
} catch(Exception e) {
   //System.out.printl("Exception");
}
if(max_answers<1 || max_answers>max_options) max_answers = 1;
if(description.length()>255) description = description.substring(0, 255);
//if(diko.length()>255) diko = diko.substring(0, 255);
if(enabled.compareToIgnoreCase("Y")!=0) enabled = "N";
if(expired.compareToIgnoreCase("Y")!=0) expired = "N";
if(anonymous.compareToIgnoreCase("N")!=0) anonymous = "Y";
loaded = 1;
status = "integrity check";
    }
    
    //Validation
    public boolean checkValid() {
if(title.length()<1 || title.length()>255) { 
   status = "Invalid title"; 
   return false; 
}
if(options.size()<1 || options.size()>max_options) { 
   status = "Invalid options"; 
   return false; 
} else {
   String s;
   VoteOption op;
   for(int i=0;i<options.size(); i++) {
op = (VoteOption)options.elementAt(i);
s = op.getOptiontext();
if(s.length()<1 || s.length()>255) {
   status = "Invalid option length";
   return false;
}
   }
}
if(max_answers<1 || max_answers>max_options) { 
   status = "Invalid answers count"; 
   return false; 
}
if(description.length()>255) { 
   status = "Invalid description"; 
   return false; 
}
if(enabled.compareToIgnoreCase("Y")!=0 && enabled.compareToIgnoreCase("N")!=0) { 
   status = "Invalid enable flag"; 
   return false; 
}
if(anonymous.compareToIgnoreCase("N")!=0 && anonymous.compareToIgnoreCase("Y")!=0) { 
   status = "Invalid anonymous flag"; 
   return false; 
}
if(expired.compareToIgnoreCase("Y")!=0 && expired.compareToIgnoreCase("N")!=0) { 
   status = "Invalid expired flag"; 
   return false; 
}
return true;
    }
    
    //Update Poll state
    public String updateState(Connection conn, String a) {
String message = "";
if(a.compareToIgnoreCase("expire")==0) {
   setExpiredDB(conn,"Y");
   message = "Expired";
} else if(a.compareToIgnoreCase("unexpire")==0) {
   setExpiredDB(conn,"N"); 
   message = "Cleared expired";
} else if(a.compareToIgnoreCase("enable")==0) {
   setEnabledDB(conn,"Y"); 
   message = "Enabled";
} else if(a.compareToIgnoreCase("disable")==0) {
   setEnabledDB(conn,"N"); 
   message = "Disabled";
} else if(a.compareToIgnoreCase("delete")==0) {
   deletePoll(conn); 
   message = "Deleted";
} else {
   message = "Unknown action";
}
return message;
    }
    
    //Vote
    //Input votes array, DB connection, remote host OR username
    public boolean vote(String[] votes, Connection conn, String remoteHost, String siteUser) {
int[] rv = new int[votes.length];
//check if we have valid number of options
if(votes.length<1 || votes.length>max_answers) {
   status = "Incorrect option count";
   return false;
}
try {
   PreparedStatement sst, ust;
   //check if the poll is not expired or disabled
   sst = conn.prepareStatement("SELECT * FROM question WHERE idQuestion=?");
   sst.setInt(1, id);
   ResultSet rs = sst.executeQuery();
   if(rs.next()) {
//check if expired
if(rs.getString("expired").compareToIgnoreCase("Y")==0) {
   status = "Poll is expired";
   rs.close();
   sst.close();
   return false;
}
//check if disabled
if(rs.getString("enabled").compareToIgnoreCase("N")==0) {
   status = "Poll is disabled";
   rs.close();
   sst.close();
   return false;
}
   } else {
status = "Poll is not found";
return false;
   }    
   //check if allready voted
   if(anonymous.compareToIgnoreCase("Y")==0) {
//Process anonymous voting
sst = conn.prepareStatement("SELECT ip AS user FROM surveyiplocks WHERE idQuestion=? AND ip=?");
ust = conn.prepareStatement("INSERT INTO surveyiplocks VALUES(?,?)");
//Validate
if(remoteHost.length()<8 || remoteHost.length()>32) {
       status = "Incorrect IP identification";
       return false;
}
   } else {
//Process user voting
sst = conn.prepareStatement("SELECT username AS user FROM surveyuserlocks WHERE idQuestion=? AND username=?");
ust = conn.prepareStatement("INSERT INTO surveyuserlocks VALUES(?,?)");
//Validate
if(siteUser.length()<1 || siteUser.length()>32) {
       status = "Incorrect User identification";
       return false;
}
remoteHost = siteUser;
   }
   //Run check
   sst.setInt(1, id);
   sst.setString(2, remoteHost);
   rs = sst.executeQuery();
   if(rs.next()) {
status = "User " + rs.getString("user") + " already voted";
rs.close();
sst.close();
return false;
   }
   //Register vote
   ust.setInt(1, id);
   ust.setString(2, remoteHost);
   if(ust.executeUpdate()>0) {
status = "User " + remoteHost + " voted";
   } else {
status = "Cannot record vote";
return false;
   }
   //load option id's
   for(int i=0;i<votes.length;i++) {
rv[i] = Integer.parseInt(votes[i]);
if(rv[i]<1) throw(new NumberFormatException("Option ID cannot be less then 1"));
   }
   //increase vote counter
   sst = conn.prepareStatement("UPDATE subquestion SET counter=counter+1 WHERE idQuestion=? AND idSubQuestion=?");
   sst.setInt(1, id);
   for(int i=0;i<votes.length;i++) {
sst.setInt(2, rv[i]);
sst.executeUpdate();
   }
   sst.close();
   return true;
} catch(SQLException e) {
   status = "Database Error";
   e.printStackTrace();
} catch(NumberFormatException e) {
   status = "Incorrect Input";
   e.printStackTrace();
} catch(Exception e) {
   status = "Unknown Error";
   e.printStackTrace();
}
return false;
    }
    
}