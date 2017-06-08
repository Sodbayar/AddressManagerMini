`<%@ page contentType="text/html;charset=utf-8"
import="java.sql.*, com.bean.*, javax.naming.*" %>
<%
request.setCharacterEncoding("utf-8");
String idx = request.getParameter("idx");
String tableDB = request.getParameter("table");
try {
AmmoDB db = new AmmoDB();
db.setTableDB(tableDB);
db.deleteRecord(Integer.parseInt(idx));

db.close();
}catch(SQLException e) {
out.print(e);
return;
}catch(NamingException e) {
out.print(e);
return;
}

//만일, 저장이 안되면, 아래 코드 주석처리하여 오류 확인할 것.
response.sendRedirect("user_list.jsp?table=" + tableDB);
%>