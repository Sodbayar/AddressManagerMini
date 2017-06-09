<%@ page contentType="text/html;charset=utf-8"
import="com.bean.*, java.sql.*, javax.naming.NamingException"%>
<%
request.setCharacterEncoding("utf-8");
String grp = request.getParameter("grp");
String name = request.getParameter("name");
String phone = request.getParameter("phone");
String email = request.getParameter("email");
String pos = request.getParameter("pos");
String dep = request.getParameter("dep");
String title = request.getParameter("title");
String bday = request.getParameter("bday");
String addr = request.getParameter("addr");
String hpage = request.getParameter("hpage");
String sns = request.getParameter("sns");
String memo = request.getParameter("memo");
String idx = request.getParameter("idx");

Ammo a = new Ammo();
a.setIndex(Integer.parseInt(idx));
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
a.setMemo(memo);
/*****yu bichih yum be?*********/
try {
	AmmoDB db = new AmmoDB();
	db.UpdateRecord(a);	
	db.close();
} catch (SQLException e) {
	out.print(e);
	return;
} catch (NamingException e) {
	out.print(e);
	return;
}

response.sendRedirect("user_list.jsp?group=" + grp);

%>