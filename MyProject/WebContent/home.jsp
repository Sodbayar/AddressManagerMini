<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>

<%
Class.forName("com.mysql.jdbc.Driver");

String DB_URL = "jdbc:mysql://localhost:3306/mydb?useSSL=false";
String DB_TABLE = request.getParameter("table");
if (DB_TABLE == null) {
   DB_TABLE = "member";   
}
String DB_USER = "root";
String DB_PASS = "root";
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

<!DOCTYPE html>
<html>
<meta charset="utf-8">
<head>
   <title>index</title>
   <link rel="stylesheet" href="./css/user_list.css">
   <link rel="shortcut icon" type="image/png" href="https://cdn1.iconfinder.com/data/icons/phone-mockups/64/facebook_twitter_laptop_online-128.png"/>

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
         
         %><li><a href='index.jsp?table=<%=rs.getString(3)%>'><%=rs.getString(3) %></a></li>
         
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
   
   String query = "SELECT idx, grp, name, phone, email, pos, dep FROM " + DB_TABLE + SEARCH_QRY;
   
   
   rs = stmt.executeQuery(query);
%>

   <table border="1" style="border-collapse:collapse">
      <caption>현재 선택된 블로그형 게시판 제목</caption>
      <tr>
         <th>Index</th>
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
         <td><%=rs.getInt("idx") %></td>
         <td><%=rs.getString("grp") %></td>
         <td><%=rs.getString("name") %></td>
         <td><%=rs.getString("phone") %></td>
         <td><%=rs.getString("email") %></td>
         <td><%=rs.getString("pos") %></td>
         <td><%=rs.getString("dep") %></td>
         
         <td>
         <A href="user_delete_do.jsp?idx=<%=rs.getInt("idx")%>&table=<%=DB_TABLE%>">Delete</A>
         <input type="button" value="Fix" onClick="location.href='user_modify.jsp?idx=<%=rs.getInt("idx")%>&table=<%=DB_TABLE%>'">
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
<A href="user_save.jsp?table=<%=DB_TABLE%>">회원 추가</A>


</body>
</html>