`<%@ page contentType="text/html;charset=utf-8"
import="java.sql.*, com.bean.*, javax.naming.*" %>
<%
request.setCharacterEncoding("utf-8");
String idx = request.getParameter("idx");
String groupDB = request.getParameter("group");
try {
AmmoDB db = new AmmoDB();
db.deleteRecord(Integer.parseInt(idx));

db.close();
}catch(SQLException e) {
out.print(e);
return;
}catch(NamingException e) {
out.print(e);
return;
}

response.sendRedirect("user_list.jsp?group=" + groupDB);
%>