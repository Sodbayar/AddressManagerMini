<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<%
	String url = "user_list.jsp?group=";
	String firstTable = request.getParameter("group");
	String searchTable = request.getParameter("search");
	
	
	if (firstTable == null)
			firstTable = "My Contacts";
	if (searchTable != null)
		response.sendRedirect(url+firstTable + "&search=" + searchTable);
	else 
		response.sendRedirect(url+firstTable);
%>