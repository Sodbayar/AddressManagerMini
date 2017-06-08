<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.bean.*, java.sql.*, javax.naming.NamingException" %>

<%
String idx = request.getParameter("idx");
String tableDB = request.getParameter("table");
try {
	ArticleDB db = new ArticleDB();
	db.setTableDB(tableDB);
	Article art = db.getRecord(Integer.parseInt(idx));
%>
<%=tableDB %>
<html>
<body>
<FORM action="user_modify_do.jsp?table=<%=tableDB%>" method="post">
Number : <INPUT type="text" name="idx" readOnly value="<%=idx %>"><BR>
ID : <INPUT type="text" name="id" maxlength="8" size="8"
value="<%=art.getId()%>"><BR>
성명 : <INPUT type="text" name="name" maxlength="12" size="12"
value="<%=art.getName()%>"><BR>
암호 : <INPUT type="password" name="pwd" value="<%=art.getPwd()%>"><BR>
<INPUT type="submit" value=" 수 정 ">
</FORM>
</body>
</html>

<%
db.close();
} catch (SQLException e) {
	out.print(e);
	return;
} catch (NamingException e) {
	out.print(e);
	return;
}
%>