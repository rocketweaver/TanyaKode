<%@page import="java.security.interfaces.RSAKey"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="Config.DBConfig"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Forum</title>
        <link rel="stylesheet" href="css/style.css" />
        <link rel="stylesheet" href="css/mainnavstyle.css" />
    </head>
    <body>
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
                        String uname = request.getParameter("uname");
                        String forumId = request.getParameter("id");

                        DBConfig conf = new DBConfig();
                        Connection conn = null;
                        Statement statement = null;
                        ResultSet st = null;
                    %>
                    <li>
                        <a href=<%="\"question.jsp?username=" + uname + "\""%>>Question</a>
                    </li>
                    <li class="dropdown">
                        <a href="javascript:void(0)" class="dropbtn">
                            <%
                                if (uname == null && uname.equals("")) {
                                    out.println("Guest");
                                } else {
                                    out.println(uname);
                                }
                            %>
                        </a>
                        <div class="dropdown-content">
                            <% if (uname != null && !uname.equals("")) {%>
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
        <%
            try {
                conn = conf.open();
                statement = conn.createStatement();
                String data = "select * from question where id='" + forumId + "'";
                st = statement.executeQuery(data);

                while (st.next()) {
                    String author = st.getString("author");
        %>
        <div class="container" style="min-height: 80vh">
            <section class="forum" style="margin-top: 10vh">
                <h1 class="forum-title">
                    <%=st.getString("title")%>
                </h1>
                <div class="forum-detail">
                    <p class="forum-category">Category: <%=st.getString("category")%></p>
                    <p class="date-and-author"><%=st.getString("created_at")%> by <%=author%></p>
                </div>
                <p class="forum-desc">
                    <%=st.getString("description")%>
                </p>
                
                <%
                    if(author.equals(uname)) {
                %>
                <a class="edit-link" href=<%="\"updateforum.jsp?username=" + uname + ""
                        + "&id="+ forumId +"\""%>>Edit | </a>
                <a class="delete-link" href=<%="\"deleteforum.jsp?username=" + uname + ""
                        + "&id="+ forumId +"\""%>>Delete</a>
                <%
                    }
                    }
                } catch (Exception e) {
                    System.out.println(" Can't connect to database ");
                    System.out.println(e.getMessage());
                }

                if(uname != null) {
                %>
                
                <form action="" method="post">
                    <textarea name="comment" class="form-element comment"></textarea>
                    <input type="submit" class="submit-btn white-color comment-btn" value="Comment">
                </form>
                <%
                    }
                    PreparedStatement ps = null;

                    int updateQuery = 0;

                    String comment = request.getParameter("comment");
                    String author = uname;
                    if(comment != null && comment != "") {
                        try {

                            conn = conf.open();
                            String queryq = "insert into feedback (feedback,author,forum_id,created_at) values(?,?,?,curdate())";
                            ps = conn.prepareStatement(queryq);
                            ps.setString(1, comment);
                            ps.setString(2, author);
                            ps.setString(3, forumId);

                            updateQuery = ps.executeUpdate();
                            response.sendRedirect("forum.jsp?uname=" + uname + "&id=" + forumId);
                        } catch (Exception e) {
                            System.out.println(e);
                        } finally {
                            ps.close();
                        }
                    }
                    
                    try {

                        conn = conf.open();
                        String data = "select * from feedback where forum_id='" + forumId + "'";
                        statement = conn.createStatement();
                        st = statement.executeQuery(data);
                        
                        while(st.next()){
                    %>
                            <div class="comment-bubble">
                                <p class="comment-txt">
                                    <%=st.getString("feedback")%>
                                </p>
                                <p class ="comment-author"><%=st.getString("created_at")%> by <%=st.getString("author")%></p>
                                <%
                                    if(uname.equals(st.getString("author"))) {
                                %>
                                        <a class="delete-comment" 
                                           href=<%="\"deletecomment.jsp?author=" + st.getString("author")
                                            + "&id_comment="+ st.getString("id") +""
                                            + "&id_forum=" + forumId + "\""%>>
                                            <img src="icons/delete_icon.svg" alt="Delete"/>
                                        </a>
                                <%
                                    }
                                %>
                            </div>
                <%
                        }
                    } catch (Exception e) {
                        System.out.println(e);
                    }
                %>
            </section>
        </div>
        <footer class="black-bg container" id="forum-footer">
            <p class="white-color">
                &copy;2023, Group 3 - 2WD1. All rights reserved.
            </p>
        </footer>

        <script src="js/main.js"></script>
        <script src="js/forum.js"></script>
    </body>
</html>
