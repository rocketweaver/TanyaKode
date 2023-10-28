<%@page import="Config.DBConfig"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ask your question!</title>
        <link rel="stylesheet" href="css/askstyle.css" />
        <link
            href="https://cdn.jsdelivr.net/npm/remixicon@2.2.0/fonts/remixicon.css"
            rel="stylesheet"
            />
    </head>
    <body>
        <!-- BAGIAN NAVIGASI -->
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
                    <%
                        String uname = request.getParameter("username");
                    %>
                    <li>
                        <a href=<%="\"question.jsp?username=" + uname + "\""%> 
                           class="underline-hover">Question</a>
                    </li>
                    <li class="dropdown">
                        <a href="javascript:void(0)" class="dropbtn"><%=uname%></a>
                        <div class="dropdown-content">
                            <% if (uname != null) {%>
                                <a href=<%="\"updateprofile.jsp?username=" + uname + "\""%>>Profile</a>
                            <% } %>                            

                            <a href="signin.jsp">
                                <%
                                    if (uname != null && !uname.equals("")) {
                                        out.println("Sign out");
                                    } else {
                                        out.println("Sign in");
                                    }
                                %>
                            </a>
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
        <!-- NAVIGASI end -->

        <!-- BAGIAN KONTEN -->
        <div class="container">
            <div class="box-content">
                <h1 class="title">Ask your question here</h1>
                <label><b>Title</b></label>
                <form action="" method="post">
                    <input type="text" name="title" id="title" class="form-element" autocomplete="off"/>
                    <span class="error-txt title-error"></span>

                    <label><b>Category</b></label>
                    <select name="category" id="category" class="form-element">
                        <option value="none" selected disabled>Select category</option>
                        <option value="CSS">CSS</option>
                        <option value="JS">JS</option>
                        <option value="Java">Java</option>
                        <option value="Others">Others</option>
                    </select>
                    <span class="error-txt category-error"></span>

                    <label><b>Description</b></label>
                    <textarea
                        type="text"
                        name="description"
                        id="desc"
                        class="form-element"
                        ></textarea>
                    <span class="error-txt desc-error"></span>

                    <input type="submit" class="submit-btn" value="Submit">
                </form>
            </div>
        </div>
        <!-- KONTEN end -->

        <!-- BAGIAN FOOTER -->
        <footer>
            <p>&copy;2023, Group 3 - 2WD1. All rights reserved.</p>
        </footer>
    </body>
</html>
<%
    String title = request.getParameter("title");
    String category = request.getParameter("category");
    String description = request.getParameter("description");
    String author = uname;

    DBConfig conf = new DBConfig();

    Connection conn = null;
    PreparedStatement ps = null;

    int updateQuery = 0;
    //untuk mengecek textbox name, city, dan phone tidak kosong
    if (title != null && category != null && description != null) {
        if (title != "" && category != "" && description != "") {
            try {

                conn = conf.open();
                String queryq = "INSERT INTO question(title,category,description,author,created_at) "
                + "values(?,?,?,?,curdate())";
                ps = conn.prepareStatement(queryq);
                ps.setString(1, title);
                ps.setString(2, category);
                ps.setString(3, description);
                ps.setString(4, uname);
                
                updateQuery = ps.executeUpdate();
                if (updateQuery != 0) {
%>
                    <script>
                        alert("You are now registered");
                    </script>
<%
                    response.sendRedirect("question.jsp?username=" + uname);
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
        }
    }
%>
