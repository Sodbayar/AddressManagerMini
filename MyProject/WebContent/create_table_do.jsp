<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="com.bean.*"%>
<% String table = request.getParameter("grpname"); %>
<% AmmoDB db = new AmmoDB();
	db.createTable(table);
	
	response.sendRedirect("user_list.jsp");
%>