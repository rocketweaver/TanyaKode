<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="Config.DBConfig"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Join our community!</title>
    <link rel="stylesheet" href="css/style.css" />
    <link rel="stylesheet" href="css/mainnavstyle.css" />
    <link rel="stylesheet" href="css/updateprofilestyle.css" />
  </head>
  <body>
    <%
        String uname = request.getParameter("username");
        
        DBConfig conf = new DBConfig();
        
        Connection conn = conf.open();
        Statement statement = null;
        ResultSet rs = null;
        PreparedStatement ps = null;
    %>
    <nav>
      <div class="logo">
        <div class="firstname">
          <h1>Tanya</h1>
        </div>
        <div class="lastname">
          <h1>Kode</h1>
        </div>
      </div>
      <div class="menu">
        <ul>
          <li>
            <a href=<%="\"question.jsp?username=" + uname + "\""%>>Question</a>
          </li>
          <li class="dropdown">
            <a href="javascript:void(0)" class="dropbtn"><%=uname%></a>
            <div class="dropdown-content">
              <a href="#">Profile</a>
              <a href="signin.jsp">Sign out</a>
            </div>
          </li>
          <img
            src="icons/iconmonstr-user-1.svg"
            alt="Profile icon"
            class="profile-icon"
          />
        </ul>
      </div>
    </nav>

    <div class="container">
      <section id="signup" class="sign">
        <div class="sign-form">
            <h1 class="form-title">Update Profile</h1>
            <form action="" method="post">
              <%
                try {
                    statement = conn.createStatement();
                    String data = "select * from user where username='" + uname +"'";

                    rs = statement.executeQuery(data);

                    while(rs.next()) {
              %>
              <label for="username" class="form-element">Username: </label>
              <input
                type="text"
                name="profile"
                id="username"
                class="form-element"
                placeholder=<%=uname%>
                autocomplete="off"
              />
              <span class="error-txt username-error"></span>
              <label for="fullname" class="form-element">Fullname: </label>
              <input
                type="text"
                name="fullname"
                id="fullname"
                class="form-element"
                placeholder=<%=rs.getString("fullname")%>
                autocomplete="off"
              />
              <span class="error-txt fullname-error"></span>
              <label for="password" class="form-element">Password: </label>
              <input
                type="password"
                name="password"
                id="password"
                class="form-element"
              />
              <span class="error-txt password-error"></span>
              <label for="retype-password" class="form-element"
                >Retype password:
              </label>
              <input
                type="password"
                name="retype-password"
                id="retype-password"
                class="form-element"
              />
              <span class="error-txt retype-password-error"></span>
              <%
                    }    
                } catch (Exception e) {
                    System.out.println("Can't connect to database.");
                    System.out.println(e.getMessage());
                } 
              %>
              <input
                class="submit-btn form-element white-color"
                type="submit" value="Submit"
              >
            </form>
        </div>
        <div class="sign-img"></div>
      </section>
    </div>

    <footer class="black-bg container">
      <p class="white-color">
        &copy;2023, Group 3 - 2WD1. All rights reserved.
      </p>
    </footer>
  </body>
</html>
<%
    String profile = request.getParameter("profile");
    String fullname = request.getParameter("fullname");
    String password = request.getParameter("password");
    String retypePassword = request.getParameter("retype-password");

    int updateQuery = 0;
    //untuk mengecek textbox name, city, dan phone tidak kosong
    if (fullname != null && profile != null && password != null && retypePassword != null) {
        if (profile != "" && fullname != "" && password != "" && retypePassword != "") {
            if(retypePassword.equals(password)){
                try {

                    conn = conf.open();
                    String queryq = "update user set username=?,"
                    + "fullname=?,password=? where username='" + uname +"'";
                    ps = conn.prepareStatement(queryq);
                    ps.setString(1, profile);
                    ps.setString(2, fullname);
                    ps.setString(3, password);

                    updateQuery = ps.executeUpdate();
                    if (updateQuery != 0) {
%>
                        <script>
                            alert("Profile updated");
                        </script>
<%
                        response.sendRedirect("signin.jsp");
                    } else {
%>   
                    <script>
                        alert("Update profile failed");
                    </script>
<%
                    }
                    
                    queryq = "update feedback set author=? where author='" + 
                            uname + "'";
                    ps = conn.prepareStatement(queryq);
                    ps.setString(1, profile);
                    updateQuery = ps.executeUpdate();
                } catch (Exception e) {
                    out.println(e.getMessage());
                } finally {
                    ps.close();
                    conn.close();

                }
            } else{
%>
                <script>
                    alert("Password doesn't match with each other");
                </script>
<%
    
            }
        }
    } 
%>
