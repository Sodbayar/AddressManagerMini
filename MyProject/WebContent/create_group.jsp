<%@page import="sun.security.pkcs11.Secmod.DbMode" session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.bean.*, java.sql.*, javax.naming.NamingException"%>

<%
	HttpSession session = request.getSession(false);
	if (session == null || session.getAttribute("login.name") == null) {
		response.sendRedirect("login.jsp");
		return;
	}
	request.setCharacterEncoding("UTF-8");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = null;
	Statement stmt = null;
	ResultSet rs = null;
	String oldName = request.getParameter("group");
	try {
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb?useSSL=false", "root", "1234");
		stmt = con.createStatement();
		rs = stmt.executeQuery("SELECT grp from groups ORDER BY grp");
%>

<html>
<meta charset="utf-8">
<head>
<title>index</title>
<link rel="stylesheet" href="./css/user_list.css">
<link rel="shortcut icon" type="image/png"
	href="https://cdn1.iconfinder.com/data/icons/phone-mockups/64/facebook_twitter_laptop_online-128.png" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

</head>

<body>
	<header>
		<div>
			<a href="index.jsp" id="home">Home</a> 
			<a href="#" id="click">현재 선택된 블로그형: Edit</a>
			<a href="logout.jsp">Logout</a>
		</div>
	</header>

	<section>
		<div>
			<a href="#">All Groups</a>
            <a href="create_group.jsp"><i class="fa fa-plus" aria-hidden="true"></i></a>
				<ul class="sec-ul">

					<%
						while (rs.next()) {
					%><li><a href='index.jsp?group=<%=rs.getString("grp")%>'><%=rs.getString("grp")%></a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="edit_group.jsp?group=<%=rs.getString("grp") %>" class="fa fa-pencil-square-o" aria-hidden="true"></a></li>

					<%
						} //end-of-while
					%>
				</ul>
		</div>

	</section>


	<form name="input" action="create_group_do.jsp" method="post">
		<table border="1">
			
			<tr>
				<th>Group Name:</th>
				<td><input type="text" name="grpname"></td>
			</tr>
			
		</table>
		<input type="button" value="Cancel" onClick="history.back()" id="sbmt" style="width:70px; margin: 13px 75px"> 
		<input type="submit" value="Create" style="width: 70px; margin:13px 75px">
	</form>


</body>
</html>
<%
} catch (SQLException e) {
	out.print("err:" + e.toString());
} finally {
	rs.close();
	con.close();
	stmt.close();
}
%>