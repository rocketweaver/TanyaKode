<%@page import="java.sql.Statement"%>
<%@page import="Config.DBConfig"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http - equiv="Content - Type" content="text/html; charset=UTF-8">
<title>Delete Forum</title>
</head>
<body>
    <%
        String idComment = request.getParameter("id_comment");
        String idForum = request.getParameter("id_forum");
        String author = request.getParameter("author");
        
        DBConfig conf = new DBConfig();
        
        try {
            Connection conn = conf.open();
            Statement st = conn.createStatement();
            st.executeUpdate("delete from feedback where id = '"+idComment+"' and "
                            + "author='" + author + "'");
            response.sendRedirect("forum.jsp?uname=" + author+"&id=" + idForum);
        } catch(Exception e){
            out.println(e.getMessage());
        }
    %>
</body>
</html>
