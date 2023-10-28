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
        <title>Questions</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="css/questionstyle.css" />
        <link rel="stylesheet" href="css/underlinelink.css" />
        <link
            href="https://cdn.jsdelivr.net/npm/remixicon@2.2.0/fonts/remixicon.css"
            rel="stylesheet"
            />
    </head>
    <body>
        <!--BAGIAN NAVIGASI-->
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
                        String username = request.getParameter("username");
                    %>
                    <li>
                        <a href=<%="\"question.jsp?username=" + username + "\""%> 
                           class="underline-hover">Question</a>
                    </li>
                    <li class="dropdown">
                        <a href="javascript:void(0)" class="dropbtn">
                            <%
                                
                                if(username == null || username.equals("")) {
                                    out.println("Guest");
                                } else {
                                    out.println(username);
                                }
                            %>
                        
                        </a>
                        <div class="dropdown-content">
                            <% if(username != null && !username.equals("")) {%>
                                <a href=<%="\"updateprofile.jsp?username=" + username + "\""%>>Profile</a>
                            <% } %>                            
                            
                            <a href="signin.jsp">
                                <% 
                                    if(username != null && !username.equals("")) {
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
        <!--NAVIGASI end-->

        <!--BAGIAN SEARCH BOX-->
        <div class="container h-100">
            <div class="box-search">
                <h1>All Question</h1>
                <div class="search-container">
                    <form action="" method="post">
                        <input type="text" name="search" placeholder="" />
                        <input type="submit" class="search-btn" value="Search">
                    </form>
                </div>
                <!--SEARCH BOX end-->
                <% 
                    String title = request.getParameter("search");
                %>
<!--                BAGIAN CATEGORY
                <div class="category-container">
                    <select name="category" id="category">
                        <option value="category" disabled selected>Category</option>
                        <option value="css">CSS</option>
                        <option value="js">JS</option>
                        <option value="java">Java</option>
                        <option value="others">Others</option>
                    </select>
                </div>
                CATEGORY end-->

                <!--BAGIAN CONTENT-->
                <div>
                    <% if(username != null && !username.equals("")) {%>
                        <button class="ask-btn"><a href=<%="\"ask.jsp?username=" + username + "\""%>>Ask a question</a></button>
                    <% } %>
                </div>
                <% 
                    if(title == null) {
                        try {
                            DBConfig conf = new DBConfig();
                            Connection conn = null;
                            Statement statement = null;
                            ResultSet st = null;

                            conn = conf.open();
                            statement = conn.createStatement();
                            String data = "select * from question";
                            st = statement.executeQuery(data);

                            while (st.next()) {
                                String forumId = st.getString("id");
                %>
                <div class="box-content">
                    <h1>
                        <a href=<%= "\"forum.jsp?uname=" + username + "&id=" + forumId + "\"" %>
                           ><%=st.getString("title")%></a
                        >
                    </h1>
                    <div class="category-and-author">
                        <p>Category: <%=st.getString("category")%></p>
                        <p><%=st.getString("created_at")%> by <%=st.getString("author")%></p>
                    </div>
                </div>                    
                <%
                            }
                        } catch (Exception e) {
                            System.out.println(" Can't connect to database ");
                            System.out.println(e.getMessage());
                        }
                    } else {
                        try {
                            DBConfig conf = new DBConfig();
                            Connection conn = null;
                            Statement statement = null;
                            ResultSet st = null;

                            conn = conf.open();
                            statement = conn.createStatement();
                            String data = "select * from question where title like '%" + title + "%'";
                            st = statement.executeQuery(data);

                            while (st.next()) {
                                String forumId = st.getString("id");
                %>
                <div class="box-content">
                    <h1>
                        <a href=<%= "\"forum.jsp?uname=" + username + "&id=" + forumId + "\"" %>
                           ><%=st.getString("title")%></a
                        >
                    </h1>
                    <div class="category-and-author">
                        <p>Category: <%=st.getString("category")%></p>
                        <p><%=st.getString("created_at")%> by <%=st.getString("author")%></p>
                    </div>
                </div>
                <%      
                            }
                            st.close();
                            statement.close();
                            conn.close();
                        } catch (Exception e) {
                            System.out.println(" Can't connect to database ");
                            System.out.println(e.getMessage());
                        } 
                    }
                %>
                <!--CONTENT end-->
            </div>
        </div>

        <!--BAGIAN FOOTER-->
        <footer>
            <p>&copy;2023, Group 3 - 2WD1. All rights reserved.</p>
        </footer>
        <!--FOOTER end-->
    </body>
</html>

