<%@ page contentType="text/html;charset=utf-8"
import="com.bean.*, java.sql.*, javax.naming.NamingException"%>
<%
request.setCharacterEncoding("utf-8");
String sidx = request.getParameter("idx");
String sid = request.getParameter("id");
String name = request.getParameter("name");
String pwd = request.getParameter("pwd");
String tableDB = request.getParameter("table");

Article art = new Article();
art.setIdx(Integer.parseInt(sidx));
art.setId(sid);
art.setName(name);
art.setPwd(pwd);
/*****yu bichih yum be?*********/
try {
	ArticleDB db = new ArticleDB();
	db.setTableDB(tableDB);
	db.UpdateRecord(art);
	
	db.close();
} catch (SQLException e) {
	out.print(e);
	return;
} catch (NamingException e) {
	out.print(e);
	return;
}

response.sendRedirect("user_list.jsp?table=" + tableDB);

%>