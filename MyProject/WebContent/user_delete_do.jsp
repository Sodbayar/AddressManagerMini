<%@ page contentType="text/html;charset=utf-8"
	import="java.sql.*, com.bean.*, javax.naming.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	String idx = request.getParameter("idx");
	String groupDB = request.getParameter("group");
	String table = request.getParameter("table");
	AmmoDB db = null;
	try {
		db = new AmmoDB();
		db.deleteRecord(Integer.parseInt(idx), table);
		db.close();
	} catch (SQLException e) {
		out.print(e);
		return;
	} catch (NamingException e) {
		out.print(e);
		return;
	} finally {
		db.close();
	}

	if (table.equals("trash"))
		response.sendRedirect("trash.jsp");
	else
		response.sendRedirect("user_list.jsp?group=" + groupDB);
%>