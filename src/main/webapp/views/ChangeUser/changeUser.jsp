<%@ page import="model.service.ImageService" %><%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 1/19/2024
  Time: 10:06 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/views/MainPage/css/mainpage.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"> <!--icon-->
    <title>Thay Đổi Thông Tin</title>
</head>
<body>
   <div class="container_change">
       <form>
           <div class="logo">
               <img src="<%=request.getContextPath()+"/"+ImageService.getLogoImagePath()%>" width="25%">
           </div>
            <div class="title_change"><h1>Thay Đổi Thông Tin Tài Khoản</h1></div>
           <
       </form>
   </div>
</body>
</html>
