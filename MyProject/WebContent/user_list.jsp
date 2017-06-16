<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>

<%
Class.forName("com.mysql.jdbc.Driver");
String DB_URL = "jdbc:mysql://localhost:3306/mydb?useSSL=false";
String DB_GROUP = request.getParameter("group");
if (DB_GROUP == null) {
   DB_GROUP = "My Contacts";   
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
/* 
   DatabaseMetaData md = con.getMetaData();
   rs = md.getTables("mydb", "public", "%" ,new String[] {"TABLE"} ); */ 
   String query = "SELECT grp from groups ORDER BY grp";
   rs = stmt.executeQuery(query);
%>

<!DOCTYPE html>
<html>
<meta charset="utf-8">
<head>
   <title>index</title>
   <link rel="stylesheet" href="./css/user_list.css">
   <link rel="shortcut icon" type="image/png" href="https://cdn1.iconfinder.com/data/icons/phone-mockups/64/facebook_twitter_laptop_online-128.png"/>
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

</head>

<body>
   <header>
      <div>
         <a href="index.jsp" id="home">Home</a>
         <a href="#" id="click">현재 선택된 그룹: <%=DB_GROUP %></a>
         <nav>
            <ul>
               <div class="head-ul">
                  <li>
                     ID: <input type="text" name="adminid">
                     Password: <input type="password" name="adminpass">
                  </li>   
                  <li>
                     <input type="submit" name="login" value="Log In" id="submitbutton">
                  </li>
                  <li>
                     <a href="#">게시판 관리</a>
                  </li>      
               </div>   
            </ul>
            
         </nav>
      </div>
   </header>
   
   <section>
      <div>
         <a href="#">Groups</a>
         <a href="create_group.jsp"><i class="fa fa-plus" aria-hidden="true"></i></a>
         <ul class="sec-ul">
         
         <% 
         while(rs.next()) { 
         
         %><li><a href='index.jsp?group=<%=rs.getString("grp")%>'><%=rs.getString("grp") %></a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href='edit_group.jsp?group=<%=rs.getString("grp") %>' class="fa fa-pencil-square-o" aria-hidden="true"></a></li>
         
         <%
         } //end-of-while
         %> 
         <li><a href="trash.jsp"><i class="fa fa-trash-o" aria-hidden="true">&nbspTrash</i></a></li>
         </ul>
      </div>
      <%
      } catch(SQLException e) {
         out.print("errpp:" + e.toString());
      }
      %>
   </section>

<% 
   try {
   
   String query = "SELECT idx, name, phone, email, pos, dep FROM memr where grp='"+DB_GROUP+"'";    //+ SEARCH_QRY;
   
   
   rs = stmt.executeQuery(query);
%>

   <table border="1" style="border-collapse:collapse">
      <tr>
         <th>Name: </th>
         <th>Phone: </th>
         <th>Email: </th>
         <th>Position: </th>
         <th>Department Name: </th>
         <th>Total: 11</th>
      </tr>
      <%
      while (rs.next()) {
      %>
      <tr>
         <td><a href="user_view.jsp?idx=<%=rs.getInt("idx")%>&group=<%=DB_GROUP%>"><%=rs.getString("name") %></a></td>
         <td><%=rs.getString("phone") %></td>
         <td><%=rs.getString("email") %></td>
         <td><%=rs.getString("pos") %></td>
         <td><%=rs.getString("dep") %></td>
         
         <td>
         <a class="fa fa-trash" href="user_delete.jsp?idx=<%=rs.getInt("idx")%>&group=<%=DB_GROUP%>&table=memr"/> &nbsp&nbsp&nbsp
         <a class="fa fa-cogs" href='user_modify.jsp?idx=<%=rs.getInt("idx")%>&group=<%=DB_GROUP%>'/>
         </td>
      </tr>
      <%} %>
   </table>
<%
   rs.close();
   stmt.close();
   con.close();
} catch(SQLException e) {
   out.print("err:" + e.toString());
}
%>
<A href="user_modify.jsp?group=<%=DB_GROUP%>">회원 추가</A>


</body>
</html>