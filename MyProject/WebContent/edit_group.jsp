<%@page import="sun.security.pkcs11.Secmod.DbMode"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.bean.*, java.sql.*, javax.naming.NamingException"%>

<%
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
			<a href="#" id="home">Home</a> <a href="#" id="click">현재 선택된 블로그형
				게시판 제목</a>
		</div>
	</header>

	<section>
		<div>
			<a href="#">All Groups
				</p>
				<ul class="sec-ul">

					<%
						while (rs.next()) {
					%><li><a href='index.jsp?group=<%=rs.getString("grp")%>'><%=rs.getString("grp")%></a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="fa fa-pencil-square-o" aria-hidden="true"></a></li>

					<%
						} //end-of-while
					%>
				</ul>
		</div>

	</section>


	<form name="input" action="edit_group_do.jsp?oldName=<%=oldName %>" method="post">
		<table border="1">
			
			<tr>
				<th>Name:</th>
				<td><input type="text" name="newName" value="<%=oldName%>"></td>
				<td><a href="delete_group.jsp?group=<%=oldName %>" class="fa fa-trash-o" aria-hidden="true"></a></td>
			</tr>
			
		</table>
		<input type="button" value="Cancel" onClick="history.back()" id="sbmt" style="width:70px; margin: 13px 75px"> 
		<input type="submit" value="Change" style="width: 70px; margin:13px 75px">
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