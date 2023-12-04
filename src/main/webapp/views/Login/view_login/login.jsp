<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/views/Login/css/login.css">
<<<<<<< HEAD
<%--    <link href="<%=request.getContextPath()%>/views/bootstrap-css/bootstrap.min.css">--%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"> <!--icon-->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
=======
    <link href="<%=request.getContextPath()%>/views/bootstrap-css/bootstrap.min.css">


>>>>>>> f5d1fb620456fb9e74872cfe01db371973116662
    <title>Đăng Nhập</title>
</head>
<body>
<div class="container">
    <form id="form" action="<%=request.getContextPath()%>/login" method="post">
        <div class="logo">
            <img src="/views/images/logo1.png" width="25%">
        </div>
        <div class="title">
            <h1>Đăng Nhập</h1>
        </div>
        <div class="item email">
            <div class="icon">
                <i class='bx bx-envelope mail-icon' style="color: #6494ce"></i>
            </div>
            <div class="input email">
                <input name="email" type="email" placeholder="Email" class="email">
            </div>
        </div>
        <div class="item password">
            <div class="icon">
                <i class='bx bx-key key-icon' style="color: #6494ce"></i>
            </div>
            <div class="input email">
                <input name="password" type="password" placeholder="Mật Khẩu" class="password">
            </div>

        </div>
        <div class="forgotpassword">
            <span><a href="../view_login/forgotpassword.html">Quên Mật Khẩu?</a></span>
        </div>
        <div class="submit dn">

            <button type="submit">Đăng Nhập</button>
        </div>
<%--        Check error--%>
        <div class="err">
            <%String err = request.getAttribute("errEmail") == null ? "" : request.getAttribute("errEmail").toString();%>
            <p id="errEmail" ><%=err%></p>
        </div>
        <div class="err">
            <% String re = request.getAttribute("result") == null ? "" : request.getAttribute("result").toString(); %>
            <p id="errPass" ><%=re%></p>
        </div>
        <div class="solid"></div>
        <div class="icondn">
            <div class="item-media">
                <a href="#" class="facebook"><i class='bx bxl-facebook facebook-icon'></i></a>
            </div>
            <div class="item-media">
                <a href="#" class="google"><i class='bx bxl-google google-icon'></i></a>
            </div>
        </div>
        <div class="submit dk">
            <button><a  href="signup.html">Đăng Ký</a></button>
        </div>

    </form>
</div>
</body>
<style>
    .container .err{
        text-align: center;
    }
    .container .err p {
        color: red;
    }
</style>
</html>