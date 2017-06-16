<%@page import="sun.security.pkcs11.Secmod.DbMode"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.bean.*, java.sql.*, javax.naming.NamingException"%>

<%
	request.setCharacterEncoding("UTF-8");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = null;
	Statement stmt = null;
	ResultSet rs = null;
	String idx = request.getParameter("idx");
	String groupDB = request.getParameter("group");
	String location = "user_modify_do.jsp?group=" + groupDB + "&idx=" + idx;
	try {
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb?useSSL=false", "root", "1234");
		stmt = con.createStatement();
		rs = stmt.executeQuery("SELECT grp from groups");
		AmmoDB db = new AmmoDB();
		if (idx == null) {
			idx = "1";
			location = "user_save_do.jsp?";
		}
		Ammo a = db.getRecord(Integer.parseInt(idx));
		String pic = "http://localhost:8006/MyProject/upload/" + a.getPhoto();
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
<script>

window.onload = function() {
	document.getElementById("photo").value = <%=pic %>;
}

</script>

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
						rs.beforeFirst();
					%>
				</ul>
		</div>

	</section>


	<form name="input" action="<%=location%>&pic=<%=a.getPhoto() %>" method="post" enctype="multipart/form-data">
		<table border="1">
			<tr>
				<th>Group</th>
				<td><%-- <input type="text" name="grp" value="<%=a.getGroup()%>"> --%>
					<select name="grp">
					<%while(rs.next()) { %>
						<option value="<%=rs.getString("grp")%>"><%=rs.getString("grp")%></option>
					<%} %>
					</select>
				</td>
			</tr>
			<tr>
				<th>Name:</th>
				<td><input type="text" name="name" value="<%=a.getName()%>"></td>
			</tr>
			<tr>
				<th>Photo:</th><%=pic%>
				<td><img src="<%=pic %>" width="50px" height="50px"><input type="file" name="photo" id="photo"></td>
			</tr>
			<tr>
				<th>Phone:</th>
				<td><input type="text" name="phone" value="<%=a.getPhone()%>"></td>
			</tr>
			<tr>
				<th>Email:</th>
				<td><input type="text" name="email" value="<%=a.getEmail()%>"></td>
			</tr>
			<tr>
				<th>Position:</th>
				<td><input type="text" name="pos" value="<%=a.getPosition()%>"></td>
			</tr>
			<tr>
				<th>Department Name:</th>
				<td><input type="text" name="dep" value="<%=a.getDepartment()%>"></td>
			</tr>
			<tr>
				<th>Title:</th>
				<td><input type="text" name="title" value="<%=a.getTitle()%>"></td>
			</tr>
			<tr>
				<th>Birth-date:</th>
				<td><input type="text" name="bday" value="<%=a.getBday()%>"></td>
			</tr>
			<tr>
				<th>Address:</th>
				<td><input type="text" name="addr" value="<%=a.getAddress()%>"></td>
			</tr>
			<tr>
				<th>Homepage:</th>
				<td><input type="text" name="hpage" value="<%=a.getHomepage()%>"></td>
			</tr>
			<tr>
				<th>SNS ID:</th>
				<td><input type="text" name="sns" value="<%=a.getSns()%>"></td>
			</tr>
			<tr>
				<th>Memo:</th>
				<td><input type="text" name="memo" rows="4" cols="26" value="<%=a.getMemo()%>"
						style="opacity: 0.8"></input></td>
			</tr>
		</table>
		<input type="button" value="Cancel" onClick="history.back()" id="sbmt" style="width:70px; margin: 13px 75px"> 
		<input type="submit" value="Submit" style="width: 70px; margin:13px 90px">
	</form>


</body>
</html>
<%
db.close();
} catch (SQLException e) {
	out.print("err:" + e.toString());
}
%>