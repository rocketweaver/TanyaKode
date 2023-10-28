<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="Config.DBConfig"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Welcome back!</title>
        <link rel="stylesheet" href="css/style.css" />
    </head>
    <body>
        <header class="container static-header" style="position: static">
            <nav>
                <h1 class="logo black-color">
                    Tanya<span class="primary-color bold">Kode</span>
                </h1>
                <ul class="nav-list">
                    <li class="nav-item">
                        <a
                            href="index.jsp"
                            rel="noopener noreferrer"
                            class="nav-link underline-hover black-color"
                            >Home</a
                        >
                    </li>
                    <li class="nav-item">
                        <a
                            href="signin.jsp"
                            rel="noopener noreferrer"
                            class="nav-link btn-primary signin-link"
                            >Signin</a
                        >
                    </li>
                </ul>
            </nav>
        </header>

        <div class="pb-8 container">
            <section class="sign">
                <div class="sign-form">
                    <h1 class="form-title">
                        Sign-<span class="primary-color bold">in</span>
                    </h1>
                    <form action="" method="post">
                        <label for="username" class="form-element">Username: </label>
                        <input
                            type="text"
                            name="username"
                            id="username"
                            class="form-element"
                            autocomplete="off"
                            />
                        <span class="error-txt username-error"></span>
                        <label for="password" class="form-element">Password: </label>
                        <input
                            type="password"
                            name="password"
                            id="password"
                            class="form-element"
                            />
                        <span class="error-txt password-error"></span>
                        <input type="submit"
                               class="submit-btn form-element white-color"
                               value="Submit"
                               >
                        <a href="signup.jsp" class="signup-link"
                           >Doesn't have any account?</a
                        >
                    </form>
                </div>
                <div class="sign-img"></div>
            </section>
        </div>

        <script src="js/main.js"></script>
        <script src="js/signin.js"></script>
    </body>
</html>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String fullname = null;
    
    try {
        DBConfig conf = new DBConfig();
        Connection conn = null;
        Statement statement = null;
        ResultSet rs = null;

        conn = conf.open();
        statement = conn.createStatement();
        String data = "select * from user where username = '" + username + "' AND password='" + password + "'";
        rs = statement.executeQuery(data);
        
        while(rs.next()) {
            fullname = rs.getString("fullname");
        }
        
        if(fullname.equals("") || fullname == null) {
%>
            <script>
                alert("Invalid username or password");
            </script>   
<%
        } else {
            response.sendRedirect("question.jsp?username=" + username);
        }
    } catch (Exception e) {
        System.out.println(e);
    }
%>
