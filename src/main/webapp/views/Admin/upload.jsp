<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<body>
<%--<form method="post" action="./upload" enctype="multipart/form-data">--%>
<%--<form method="post" action="/upload" enctype="multipart/form-data">--%>
<form method="post" action="<%=request.getContextPath()%>/upload" enctype="multipart/form-data">
    <h1>Upload</h1>
    <input type="file" name="images" placeholder="Chọn File Ảnh ít hơn 5MB" multiple>
    <button type="submit">OK</button>
</form>
</body>
<%
    } else {
        response.sendRedirect(request.getContextPath() + "/login");
    }%>
</html>