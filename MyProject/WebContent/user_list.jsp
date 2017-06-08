<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<title>Project</title>

<%
Class.forName("com.mysql.jdbc.Driver");

String DB_URL = "jdbc:mysql://localhost:3306/mydb?useSSL=false";
String DB_TABLE = request.getParameter("table");
if (DB_TABLE == null) {
	DB_TABLE = "memr";	
}
String DB_USER = "root";
String DB_PASS = "1234";
String SEARCH = request.getParameter("search");
String SEARCH_QRY = "";
if (SEARCH == null)
		SEARCH_QRY = "";
else
		SEARCH_QRY = " where (pwd like '%" + SEARCH + "%' or name like '%" + SEARCH + "%')";
Connection con = null;
Statement stmt = null;
ResultSet rs = null;

try {
	con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
	stmt = con.createStatement();

	DatabaseMetaData md = con.getMetaData();
	rs = md.getTables("mydb", "public", "%" ,new String[] {"TABLE"} );/****wooohoooo**********/
	
%>

<script>

</script>

<table border="1" style="border-collapse:collapse">
<tr style="background-color:#dddddd">
	<th>Groups</th>
</tr>
<%
	while(rs.next()) {
%><tr>
<td><a href='index.jsp?table=<%=rs.getString(3)%>'><%= rs.getString(3) /*ⓖ*/%></a></td>
</tr>
<%
} //end-of-while
%></table>

<%
	/* rs.close();
	stmt.close();
	con.close(); */
} catch(SQLException e) {
	out.print("errpp:" + e.toString());
}
%>


<% 
	try {
	
	String query = "SELECT * FROM memr";// + DB_TABLE;// + SEARCH_QRY;
	
	
	rs = stmt.executeQuery(query);
%>


<table border="1" style="border-collapse:collapse">
<tr style="background-color:#dddddd">
<th>번호</th>
<th>ID</th>
<th>성명</th>
<th>암호</th>
<th>비고 </th>
<form action="index.jsp?table=<%=DB_TABLE%>" method="post">
<th><input type="text"  name="search"/></th>
<th><input type="submit" placeholder="검색" name="search" /></th>
</form>
</tr>
<%
	while(rs.next()) {
%><tr>
<td><%= rs.getInt("idx") /*ⓖ*/%></td>
<td><%=rs.getString(2)%></td>
<td><%= rs.getString("name")%></td>
<td><%=rs.getString("pwd")%></td>

<TD>
<A href="user_delete_do.jsp?idx=<%=rs.getInt("idx")%>&table=<%=DB_TABLE%>">Delete</A>
<input type="button" value="Fix" onClick="location.href='user_modify.jsp?idx=<%=rs.getInt("idx")%>&table=<%=DB_TABLE%>'">
</TD>
</tr>
<%
}
%></table>
<A href="create_table.jsp">+ Group</A>
<%
	rs.close();
	stmt.close();
	con.close();
} catch(SQLException e) {
	out.print("errpp:" + e.toString());
}
%>
<A href="user_save.jsp?table=<%=DB_TABLE%>">회원 추가</A>


