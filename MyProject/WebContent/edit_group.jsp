<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.bean.*"%>
<%
request.setCharacterEncoding("UTF-8");
String oldName = request.getParameter("group");
%>
<%=oldName %>
<form action="edit_group_do.jsp?oldName=<%=oldName%>" method="post">
<input type="text" name="newName">
</form>