<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% String tableDB = request.getParameter("table"); %>
<!DOCTYPE html>
<html>
<body>
<FORM action="user_save_do.jsp?table=<%=tableDB%>" method="post">
ID : <INPUT type="text" name="id" maxlength="8" size="8"><BR>
성명 : <INPUT type="text" name="name" maxlength="12" size="12"><BR>
암호 : <INPUT type="password" name="pwd"><BR>
<INPUT type="submit" value=" 저 장 ">
</FORM>
</body>
</html>