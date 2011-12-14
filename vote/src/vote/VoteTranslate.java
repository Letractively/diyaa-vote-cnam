package vote;

import java.util.*;
import java.io.*;

public class VoteTranslate implements Serializable {
    String language;
    Properties props;
    Properties trans;
    Set<String> languageKeys;
    String status;
    String cpath;
    boolean loaded;
    
    public boolean init(String sp) {
	loaded = false;
	try {
	    cpath = sp;
    	    props = new Properties();
	    props.load(new FileInputStream(sp));
	    language = props.getProperty("language","en");
	    return loadLanguage();
	} catch(Exception e) {
	    status = "Cannot load properties";
	}
	return false;
    }
	
    public String getLanguage() { return this.language; }
    public String getStatus() { return this.status; }
    public String getCpath() { return this.cpath; }
    
    public boolean setLanguage(String language) { 
	loaded = false;
	this.language = language; 
	props.setProperty("language",language); 
	return loadLanguage();
    }
    
    public boolean setCpath(String cpath) {
	loaded = false;
	this.cpath = cpath;
	return init(cpath);
    }
    
    public String s(String token, String defStr) {
	String res = defStr;
	if(!loaded) return defStr;
	if(languageKeys.contains(token)) {
	    String value;
	    try {
		value = new String(trans.getProperty(token,defStr).getBytes("ISO-8859-1"), "UTF-8");
	    } catch(Exception e) {
		status = "Error getting translated string";
		e.printStackTrace();
		value = trans.getProperty(token,defStr);
	    }
	    return value;
	} else {
	    System.out.println(token+"="+defStr);
	}
	return res;
    }
    
    private boolean loadLanguage() {
	loaded = false;
	languageKeys = new HashSet<String>();
	InputStream inpStream  = null;
    
        try {
	    inpStream = new FileInputStream(cpath.substring(0, cpath.lastIndexOf(File.separatorChar))+"/language/messages_" + language + ".properties");
	    trans = new Properties();
	    trans.load(inpStream);
	    final Enumeration enm = trans.propertyNames();
	    while (enm.hasMoreElements()) {
		languageKeys.add((String)enm.nextElement());
	    }
	    status = "Language loaded";
	    loaded = true;
	} catch(Exception e) {
	    status = "Error loading translation";
	    e.printStackTrace();
	} finally {
	    try {
		if (inpStream != null) {
		    inpStream.close();
		}
	    } catch(Exception e) {
		System.out.println("Cannot close file");
	    }
	}
	return loaded;
    }
    
}