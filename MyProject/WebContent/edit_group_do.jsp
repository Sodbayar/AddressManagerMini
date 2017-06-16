<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*, com.bean.*, javax.naming.*"%>

<%
request.setCharacterEncoding("UTF-8");
String oldName = request.getParameter("oldName");
String newName = request.getParameter("newName");
%>

<%
try {
	AmmoDB db = new AmmoDB();
	db.editGroup(newName, oldName);
	db.close();
} catch (NamingException e) {
	out.print(e);
	return;
} catch (SQLException e) {
	out.print(e);
	return;
}
response.sendRedirect("user_list.jsp?group=" + newName);
%>