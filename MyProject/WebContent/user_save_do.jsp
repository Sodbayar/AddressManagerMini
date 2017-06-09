<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*, com.bean.*, javax.naming.*"%>

<%
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
String name = request.getParameter("name");
String pwd = request.getParameter("pwd");
String tableDB = request.getParameter("table");


Article art = new Article();
art.setId(id);
art.setName(name);
art.setPwd(pwd);

try {
	ArticleDB db = new ArticleDB();
	db.setTableDB(tableDB);
	db.insertRecord(art);
	db.close();
} catch (NamingException e) {
	out.print(e);
	return;
} catch (SQLException e) {
	out.print(e);
	return;
}

/*****************************/
response.sendRedirect("user_list.jsp?table=" + tableDB);
%>
 --%>