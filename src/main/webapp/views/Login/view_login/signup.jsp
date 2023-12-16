<%@ page import="model.service.ImageService" %><%--
  Created by IntelliJ IDEA.
  User: Kien Nguyen
  Date: 11/26/2023
  Time: 5:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html>
<head>
    <title>SIGN UP FORM</title>


    <!-- Boxicons Css-->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Tahoma, Arial, sans-serif;


        }

        body {
            background-image: url("<%=request.getContextPath()+"/"+ImageService.getBackgroundImagePath()%>");
            backdrop-filter: blur(3px);

        }

        .container {
            height: 100vh;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;

        }

        .main-logo {
            height: 36px;
            margin-bottom: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;

        }

        img.logo {
            border-radius: 50%;
            height: 125px;
            position: absolute;

        }


        .form {
            background: #afe2ea;
            max-width: 430px;
            width: 100%;
            padding: 30px;
            border-radius: 6px;

        }


        header {
            font-size: 30px;
            font-weight: 600;
            text-align: center;


        }


        /*form {*/
        /*    margin-top: 20px;*/

        /*}*/
        form .infor {
            display: flex;
            justify-content: space-around;
            align-items: center;


        }

        .infor-sub:first-child {
            margin-right: 5px;
        }

        .form .field {
            height: 40px;
            width: 100%;
            margin-top: 20px;
            position: relative;
            border-radius: 6px;
        }


        .mail-icon, .key-icon {
            padding: 12px;
            font-size: 15px;
            background-color: #eae5e5;
            border-top-left-radius: 6px;
            border-bottom-left-radius: 6px;
            box-sizing: border-box;
            border: 1px solid #CACACA;
            color: #6494ce;

        }


        .field input, .field button {
            width: 100%;
            height: 100%;
            border: none;
            font-size: 15px;
            font-weight: 400;
            border-radius: 6px;
        }

        .field input {
            border: 1px solid #CACACA;
            padding: 0 52px;
            outline: none;

        }

        .field input:focus {
            border-bottom: 2px solid rgba(0, 0, 0, 0.55);
        }

        .infor-sub input {
            padding: 0 10px;
        }

        .mail-icon, .key-icon {
            position: absolute;
            top: 50%;
            /*left: 10px;*/
            left: 0px;
            transform: translateY(-50%);
        }

        .eye-icon {
            font-size: 18px;
            color: #8b8b8b;
            position: absolute;
            top: 50%;
            right: 10px;
            transform: translateY(-50%);
            cursor: pointer;
            padding: 5px;
        }

        .field button {
            background-color: #0171d3;
            color: #fff;
            cursor: pointer;
        }

        .field button:hover {
            background-color: #183153;

        }


        .form-link {
            text-align: center;
            margin-top: 10px;
        }

        .form-link span, .form-link a {
            font-size: 14px;
            font-weight: 400;
            color: #232836;
        }


        .form a {
            text-decoration: none;
            color: #0171d3;
        }

        .form-content a:hover {
            text-decoration: underline;
        }

        .warning {
            color: red;
            font-style: italic;
        }


    </style>
</head>
<body>

<%
    String error = request.getAttribute("error") == null ? "" : (String) request.getAttribute("error");
    String password = request.getParameter("pass") == null ? "" : request.getParameter("password");
    String verify = request.getParameter("verify") == null ? "" : request.getParameter("password");
%>
<section class="container forms">

    <!--SIGN UP-->

    <div class="form signup">
        <div class="main-logo">
            <img src="<%=request.getContextPath()+"/"+ImageService.getLogoImagePath()%>" alt="" class="logo">
        </div>

        <div class="form-content">
            <header>Đăng Ký</header>
            <!--    </div>-->
            <form method="post" action="<%=request.getContextPath()%>/login.jsp">
                <div class="infor">
                    <div class="field input-field infor-sub">
                        <input type="text" placeholder="Tên hiển thị*" class="input" name="name" id="name">

                    </div>

                    <div class="field input-field infor-sub">
                        <input type="tel" placeholder="Số điện thoại*" class="input" name="tel" id="tel">

                    </div>

                </div>
                <div class="field input-field">
                    <input type="email" placeholder="Nhập email*" class="input" name="email">
                    <i class='bx bx-envelope mail-icon'></i>
                </div>


                <div class="field input-field">
                    <input type="password" value="<%=password%>" placeholder="Nhập mật khẩu*" class="password"
                           name="pass"
                           id="pass">
                    <i class='bx bx-key key-icon'></i>
                    <i class='bx bx-hide eye-icon'></i>
                </div>


                <div class="field input-field">

                    <input type="password" placeholder="Xác thực mật khẩu*" class="password" name="verify" id="verify">
                    <i class='bx bx-key key-icon'></i>
                    <i class='bx bx-hide eye-icon'></i>

                </div>
                <p class="warning"><%=error%>
                </p>

                <div class="field button-field">
                    <button type="submit" value="Register">Đăng Ký</button>
                </div>

            </form>

            <div class="form-link">
                <span>Bạn đã có tài khoản? <a href="login.jsp" class="login-link">Đăng Nhập</a></span>
            </div>


        </div>


    </div>
</section>


</body>
</html>
