<%@ page import="java.util.regex.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.awt.*"%>
<%@ page import="java.util.Random"%>
<%@ page import="java.awt.Color"%>
<%@ page import="java.awt.image.*"%>
<%@ page import="javax.imageio.*"%>
<%@ page import="java.awt.image.BufferedImage"%><%

 BufferedImage buffer =new BufferedImage(140, 50, BufferedImage.TYPE_INT_RGB);
 Graphics g = buffer.createGraphics();
 g.fillRect(1,1,138,48); 
 Random rr = new Random();
 int x,y,r;
 g.setColor(Color.black);
 for(int i=0;i<119;i++) {
     x = 2+rr.nextInt(136);
     y = 2+rr.nextInt(46);
     r = 1+rr.nextInt(3);
     g.fillOval(x,y,r,r);
 }
 String str = "";
 String s = "";
 int n = 4 + rr.nextInt(3);
 Pattern p = Pattern.compile("[a-zA-Z]");
 Matcher m;
 boolean found = false; 
 for(int i=0;i<n;i++) {
    m = p.matcher(s);
     while (!m.find()) {
	r = 65 + rr.nextInt(63);
	s = s.format("%c", r);
	m = p.matcher(s);
    }
    str = str + s;
    s = "";
 }
 session.setAttribute( "captcha", str );
  
 //TimesRoman Font.PLAIN SansSerif
 g.setFont(new Font("SansSerif", Font.BOLD, 22));
 for(int i=0;i<str.length();i++) {
    s = str.substring(i,i+1);
    x = 4+20*i+rr.nextInt(5);
    y = 20+rr.nextInt(20);
    g.drawString(s, x, y);
 }
 g.setXORMode(Color.white);
 for(int i=0;i<199;i++) {
     x = 2+rr.nextInt(136);
     y = 2+rr.nextInt(46);
     g.drawLine(x,y,x,y);
 }
 response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
 response.setHeader("Pragma", "no-cache");        //HTTP 1.0
 response.setDateHeader("Expires", 0);
 response.setContentType("image/png");
 OutputStream os = response.getOutputStream();
 ImageIO.write(buffer, "png", os);
 os.flush();
 os.close();
 
%>