<%@page import="Config.DBConfig"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Join our community!</title>
        <link rel="stylesheet" href="css/style.css" />
    </head>
    <body>
        <header class="container static-header">
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
            <section id="signup" class="sign mt-0">
                <div class="sign-form">
                    <h1 class="form-title">
                        Sign-<span class="primary-color bold">up</span>
                    </h1>
                    <form action="" method="post">
                        <label for="username" class="form-element">Username: </label>
                        <input
                            type="text"
                            name="username"
                            class="form-element"
                            autocomplete="off"
                            />
                        <span class="error-txt username-error"></span>
                        <label for="fullname" class="form-element">Fullname: </label>
                        <input
                            type="text"
                            name="fullname"
                            class="form-element"
                            autocomplete="off"
                            />
                        <span class="error-txt fullname-error"></span>
                        <label for="password" class="form-element">Password: </label>
                        <input
                            type="password"
                            name="password"
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
                        <input type="submit"
                               class="submit-btn form-element white-color"
                               value="Submit"
                               />
                        <a href="signin.jsp" class="signup-link">Already have an account?</a>
                    </form>
                </div>
                <div class="sign-img"></div>
            </section>
        </div>
        <script src="js/signup.js"></script>
    </body>
</html>
<%
    String username = request.getParameter("username");
    String fullname = request.getParameter("fullname");
    String password = request.getParameter("password");
    String retypePassword = request.getParameter("retype-password");

    DBConfig conf = new DBConfig();

    Connection conn = null;
    PreparedStatement ps = null;

    
    int updateQuery = 0;
    //untuk mengecek textbox name, city, dan phone tidak kosong
    if (fullname != null && username != null && password != null && retypePassword != null) {
        if (username != "" && fullname != "" && password != "" && retypePassword != "") {
            if(retypePassword.equals(password)){
                try {

                    conn = conf.open();
                    String queryq = "insert user(username,fullname,password) values(?,?,?)";
                    ps = conn.prepareStatement(queryq);
                    ps.setString(1, username);
                    ps.setString(2, fullname);
                    ps.setString(3, password);

                    updateQuery = ps.executeUpdate();
                    if (updateQuery != 0) {
%>
                        <script>
                            alert("You are now registered");
                        </script>
<%
                        response.sendRedirect("question.jsp?username=" + username);
                    } else {
%>   
                    <script>
                        alert("Please register again");
                    </script>
<%
                    }
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