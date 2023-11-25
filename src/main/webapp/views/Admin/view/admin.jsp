<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
</head>
<body>


<div class="navigation content-to-embed">
    <ul class="ps-0 ">

        <li class="nav-item"><a href="dashboard.html" target="content"
                                onclick="changeIframeSrc('dashboard.html')"
              class="nav-link">
            <span class="icon"><i class="bi bi-house-door"></i></span>
            <span class="title">Quản lý chung</span>
        </a>
        </li>
        <li class="nav-item ">
            <a href="../product_management.html" target="content"
               onclick="changeIframeSrc('../product_management.html')" class="nav-link">
            <span class="icon"><i class="bi bi-shop"></i></span>
            <span class="title">Quản lý sản phẩm</span>
        </a>
        </li>
        <li class="nav-item">
            <a href="../order_managerment.html" target="content"
               onclick="changeIframeSrc('../order_managerment.html')"  class="nav-link">
            <span class="icon"><i class="bi bi-minecart"></i></span>
            <span class="title">Quản lý đơn hàng</span>
        </a>
        </li>

        <li class="nav-item"><a href="../customer_managerment.html"
                                onclick="changeIframeSrc('../customer_managerment.html')"
                                target="content" class="nav-link">
            <span class="icon"><i class="bi bi-people-fill"></i></span>
            <span class="title">Quản lý khách hàng </span>
        </a>
        </li>
        <li class="nav-item" data-href="setting.html"><a href="#">
            <span class="icon"><i class="bi bi-gear"></i></span>
            <span class="title">Cài đặt</span>
        </a>
        </li>
        <li class="nav-item"><a href="../../Login/view_login/login.jsp">
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
            <img src="../../images/logo1.png" alt="" class="me-2">
            <span class="title">HEADQUARTERS</span>
        </a>
        </div>


        <div class="toggle">

            <i class="bi bi-list"></i>

        </div>


        <div class="search">
            <input type="text" placeholder="Tìm kiếm .. ">
            <button><i class="bi bi-search"></i></button>


        </div>

        <div class="user m-2">

            <img src="../../images/Pblues_admin.jpg" class="" alt="">
            <button><i class="bi bi-caret-down-fill"></i></button>
        </div>


    </div>
</div>

<div class="main">
<iframe src="dashboard.html" frameborder="0" name="content" class="content"
        id="frame" width="100%" height="1100px" scrolling="no"
></iframe>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="../js/main.js"></script>

<script>
function  resizeName(obj) {
    obj.style.height = obj.contentWindow.document.body.scrollHeight + 'px';
}
function changeIframeSrc(newSrc) {
    var iframe = document.getElementById('myIframe');
    iframe.src = newSrc;
    return false; // Ngăn chặn chuyển hướng theo href
}


</script>

</body>
</html>