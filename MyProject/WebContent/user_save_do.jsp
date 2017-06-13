<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*, com.bean.*, javax.naming.*"%>

<%
request.setCharacterEncoding("UTF-8");
String grp = request.getParameter("grp").trim(); if (grp == null || grp.length() == 0 || grp.equals(" ")) grp = "My Contacts";
String name = request.getParameter("name").trim();
String phone = request.getParameter("phone").trim();
String email = request.getParameter("email").trim();
String pos = request.getParameter("pos").trim();
String dep = request.getParameter("dep").trim();
String title = request.getParameter("title").trim();
String bday = request.getParameter("bday").trim();
String addr = request.getParameter("addr").trim();
String hpage = request.getParameter("hpage").trim();
String sns = request.getParameter("sns").trim();
String memo = request.getParameter("memo").trim();


Ammo a = new Ammo();
a.setGroup(grp);
a.setName(name);
a.setPhone(phone);
a.setEmail(email);
a.setPosition(pos);
a.setDepartment(dep);
a.setTitle(title);
a.setBday(bday);
a.setAddress(addr);
a.setHomepage(hpage);
a.setSns(sns);

try {
	AmmoDB db = new AmmoDB();
	db.insertRecord(a);
	db.close();
} catch (NamingException e) {
	out.print(e);
	return;
} catch (SQLException e) {
	out.print(e);
	return;
}

/*****************************/
response.sendRedirect("user_list.jsp?group=" + grp);
%>
