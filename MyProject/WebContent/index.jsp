<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<%
	String url = "user_list.jsp?table=";
	String firstTable = request.getParameter("table");
	String searchTable = request.getParameter("search");
	
	
	if (firstTable == null)
			firstTable = "memr";
	if (searchTable != null)
		response.sendRedirect(url+firstTable + "&search=" + searchTable);
	else 
		response.sendRedirect(url+firstTable);
%>