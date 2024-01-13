<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String title = (String) request.getAttribute("title");%>
<%String message = (String) request.getAttribute("message");%>
<%String ok_link = (String) request.getAttribute("ok_link");%>
<%String cancel_link = (String) request.getAttribute("cancel_link");%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"> <!--icon-->
    <title>Thêm sản phẩm</title>
</head>
<%
    boolean isAdmin = ((request.getSession().getAttribute("isAdmin") == null) ? false : ((boolean) request.getSession().getAttribute("isAdmin")));
    if (isAdmin) {
%>
<body style="background-color: rgba(0, 0, 0, .75);">
<div class="container rounded p-2" style="background-color: #eeeeee; margin-top: 15%">
    <h1>Hello bb</h1>
</div>
</body>
<%
    } else {
        response.sendRedirect(request.getContextPath() + "/login");
    }%>
</html>