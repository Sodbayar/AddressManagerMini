<%@ page contentType="text/html;charset=utf-8"
import="com.bean.*, java.sql.*, javax.naming.NamingException"
import="com.oreilly.servlet.*, com.oreilly.servlet.multipart.*"%>
<%
request.setCharacterEncoding("utf-8");
String group = request.getParameter("grp");
ServletContext context = getServletContext();
String realFolder = context.getRealPath("upload");

int maxsize = 5 * 1024 * 1024;
String grp = "My Contacts";
try {
request.setCharacterEncoding("utf-8");	
MultipartRequest multi = new MultipartRequest(request, "C:\\Users\\Sodbayar\\git\\MyProject\\MyProject\\WebContent\\upload", maxsize, "utf-8", new DefaultFileRenamePolicy());

grp = multi.getParameter("grp"); if (grp == null || grp.length() == 0 || grp.equals(" ")) grp = "My Contacts";
String name = multi.getParameter("name");
String photo = multi.getFilesystemName("photo");
String pic = multi.getParameter("pic"); if (photo == null) photo = pic;
String phone = multi.getParameter("phone");
String email = multi.getParameter("email");
String pos = multi.getParameter("pos");
String dep = multi.getParameter("dep");
String title = multi.getParameter("title");
String bday = multi.getParameter("bday");
String addr = multi.getParameter("addr");
String hpage = multi.getParameter("hpage");
String sns = multi.getParameter("sns");
String memo = multi.getParameter("memo");
String idx = multi.getParameter("idx");

Ammo a = new Ammo();
a.setIndex(Integer.parseInt(idx));
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
a.setMemo(memo);
/*****yu bichih yum be?*********/

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