<%@ page import="model.service.ImageService" %>
<%@ page import="model.bean.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String framePath = ((String) request.getAttribute("framePath") == null) ?
        request.getContextPath() + "/views/Admin/dashboard.jsp"
        : (request.getContextPath() + (String) request.getAttribute("framePath"));%>

<%User u = (User) session.getAttribute("auth");%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>ADMIN DASHBOARD</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/views/Admin/css/main.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Lato&display=swap" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Alumni+Sans+Inline+One&display=swap" rel="stylesheet">
    <style>
        li {
            list-style-type: none;
        }

        p, ul, li {
            margin: 0;
            padding: 0;
        }

        nav ul.menu {
            overflow: auto;
        }

        nav ul.menu li.item {
            float: left;
            padding: 20px 10px;
            cursor: pointer;
            font-size: 20px;
        }

        nav ul.menu li.item ul.sub_menu {
            position: absolute;
            overflow: auto;
            display: none;
            right: 0;
        }

        nav ul.menu li.item:hover ul.sub_menu {
            width: auto;
            display: block;
            border-radius: 3px;
            margin-top: 10px;
        }

        nav ul.menu li.item ul.sub_menu li {
            display: block;
            background-color: #afe2ea;
            padding: 5px 10px;
        }

        nav ul.menu li.item ul.sub_menu li a {
            color: white;
            text-decoration: none;
        }

        nav ul.menu li.item ul.sub_menu li a:hover {
            color: black;
        }
    </style>
</head>
<body>
<div class="navigation content-to-embed">
    <ul class="ps-0 ">
        <li class="nav-item">
            <a href="<%=request.getContextPath()%>/admin?func=dashboard" target="content"
               class="nav-link">
                <span class="icon"><i class="bi bi-house-door"></i></span>
                <span class="title">Quản lý chung</span>
            </a>
        </li>
        <li class="nav-item ">
            <a href="<%=request.getContextPath()%>/admin?func=product_management"
               target="content">
                <span class="icon"><i class="bi bi-shop"></i></span>
                <span class="title">Quản lý sản phẩm</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="<%=request.getContextPath()%>/admin?func=order_management"
               target="content">
                <span class="icon"><i class="bi bi-minecart"></i></span>
                <span class="title">Quản lý đơn hàng</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="<%=request.getContextPath()%>/admin?func=customer_management"
               target="content" class="nav-link">
                <span class="icon"><i class="bi bi-people-fill"></i></span>
                <span class="title">Quản lý khách hàng </span>
            </a>
        </li>
        <li class="nav-item">
            <a href="<%=request.getContextPath()%>/admin?func=settings">
                <span class="icon"><i class="bi bi-gear"></i></span>
                <span class="title">Cài đặt</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="<%=request.getContextPath()%>/login">
                <span class="icon"><i class="bi bi-box-arrow-right"></i></span>
                <span class="title">Thoát</span>
            </a>
        </li>
    </ul>
</div>
<div class="header sticky-top ">
    <div class="top-bar">
        <div class="branch-tit">
            <a href="#">
                <img src="<%=request.getContextPath()+"/"+ImageService.getLogoImagePath()%>" alt="" class="me-2">
                <span class="title">HEADQUARTERS</span>
            </a>
        </div>
        <section>
            <nav>
                <ul class="menu">
                    <li class="item">
                        <span style="color: white"><%= u.getName()%></span>
                        <i class="fa-solid fa-user" style="color: white; margin: 0 5px"></i>
                        <ul class="sub_menu border border-primary">
                            <li><a href="<%=request.getContextPath()%>/login">Đăng xuất</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
        </section>
    </div>
</div>

<div class="main">
    <iframe src="<%=framePath%>" frameborder="0" name="content" class="content" id="frame" width="100%" height="1100px"
            scrolling="no"></iframe>
</div>
</body>
</html>