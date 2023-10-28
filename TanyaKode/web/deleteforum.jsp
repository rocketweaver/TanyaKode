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
        String id = request.getParameter("id");
        String uname = request.getParameter("username");
        
        DBConfig conf = new DBConfig();
        
        try {
            Connection conn = conf.open();
            Statement stForum = conn.createStatement();
            stForum.executeUpdate("delete from question where id = '"+id+"'");
            response.sendRedirect("question.jsp?username=" + uname);
        } catch(Exception e){
            out.println(e.getMessage());
        }
    %>
</body>
</html>
