<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>

<%
Class.forName("com.mysql.jdbc.Driver");

String DB_URL = "jdbc:mysql://localhost:3306/mydb?useSSL=false";
String DB_GROUP = request.getParameter("group");
if (DB_GROUP == null) {
   DB_GROUP = "work";   
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
   String query = "SELECT DISTINCT grp from memr";
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
         <a href="#" id="home">Home</a>
         <a href="#" id="click">현재 선택된 블로그형 게시판 제목</a>
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
         <a href="#">All Groups</p>
         <ul class="sec-ul">
         
         <% 
         while(rs.next()) { 
         
         %><li><a href='index.jsp?group=<%=rs.getString("grp")%>'><%=rs.getString("grp") %></a></li>
         
         <%
         } //end-of-while
         %> 
         </ul>
      </div>
      <%
      }catch(SQLException e) {
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
      <caption>현재 선택된 블로그형 게시판 제목</caption>
      <tr>
         <th>Group</th>
         <th>Name: </th>
         <th>Phone: </th>
         <th>Email: </th>
         <th>Position: </th>
         <th>Department Name: </th>
         <th>&nbsp</th>
      </tr>
      <%
      while (rs.next()) {
      %>
      <tr>
         <td><%=DB_GROUP %></td>
         <td><a href="#"><%=rs.getString("name") %></a></td>
         <td><%=rs.getString("phone") %></td>
         <td><%=rs.getString("email") %></td>
         <td><%=rs.getString("pos") %></td>
         <td><%=rs.getString("dep") %></td>
         
         <td>
         <a class="fa fa-trash" href='user_delete_do.jsp?idx=<%=rs.getInt("idx")%>&group=<%=DB_GROUP%>'/> &nbsp&nbsp&nbsp
         <a class="fa fa-cogs" href='user_modify.jsp?idx=<%=rs.getInt("idx")%>&table=<%=DB_GROUP%>'/>
         </td>
         
      </tr>
      <%} %>
   </table>
<A href="create_table.jsp">+ Group</A>
<%
   rs.close();
   stmt.close();
   con.close();
} catch(SQLException e) {
   out.print("err:" + e.toString());
}
%>
<A href="user_save.jsp?table=<%=DB_GROUP%>">회원 추가</A>


</body>
</html>