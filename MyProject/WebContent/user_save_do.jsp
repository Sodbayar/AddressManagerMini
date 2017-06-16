<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*, com.bean.*, javax.naming.*"
	import="com.oreilly.servlet.*, com.oreilly.servlet.multipart.*"%>

<%
int maxsize = 5 * 1024 * 1024;
String grp = "My Contacts";
try {
MultipartRequest multi = new MultipartRequest(request, "C:\\Users\\Sodbayar\\git\\MyProject\\MyProject\\WebContent\\upload", maxsize, "utf-8", new DefaultFileRenamePolicy());
request.setCharacterEncoding("UTF-8");
grp = multi.getParameter("grp").trim(); if (grp == null || grp.length() == 0 || grp.equals(" ")) grp = "My Contacts";
String name = multi.getParameter("name").trim();
String photo = multi.getFilesystemName("photo");
String phone = multi.getParameter("phone").trim();
String email = multi.getParameter("email").trim();
String pos = multi.getParameter("pos").trim();
String dep = multi.getParameter("dep").trim();
String title = multi.getParameter("title").trim();
String bday = multi.getParameter("bday").trim();
String addr = multi.getParameter("addr").trim();
String hpage = multi.getParameter("hpage").trim();
String sns = multi.getParameter("sns").trim();
String memo = multi.getParameter("memo").trim();
Ammo a = new Ammo();
a.setGroup(grp);
a.setName(name);
a.setPhoto(photo);
a.setPhone(phone);
a.setEmail(email);
a.setPosition(pos);
a.setDepartment(dep);
a.setTitle(title);
a.setBday(bday);
a.setAddress(addr);
a.setHomepage(hpage);
a.setSns(sns);
	AmmoDB db = new AmmoDB();
	db.insertRecord(a, false);
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