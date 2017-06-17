<%@ page contentType="text/html;charset=utf-8"
	import="java.sql.*, com.bean.*, javax.naming.*, java.io.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	String idx = request.getParameter("idx");
	String groupDB = request.getParameter("group");
	String table = request.getParameter("table");
	AmmoDB db = null;
	try {
		db = new AmmoDB();
		/*****Deleting the file************/
		Ammo a = db.getRecord(Integer.parseInt(idx), table);
		String fileName = a.getPhoto();
		ServletContext context = getServletContext();
		String realFolder = context.getRealPath("upload");
		File f = new File(realFolder + "\\" + fileName);
		out.print(realFolder + "\\" + fileName);
		f.delete();
		/*****Deleting photo's info from SQL table*****/
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

	/* if (table.equals("trash"))
		response.sendRedirect("trash.jsp");
	else
		response.sendRedirect("user_list.jsp?group=" + groupDB); */
%>