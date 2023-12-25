<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"> <!--icon-->
    <title>Title</title>
</head>
<%
    boolean isAdmin = ((request.getSession().getAttribute("isAdmin") == null) ? false : ((boolean) request.getSession().getAttribute("isAdmin")));
    if (isAdmin) {
%>
<body class="justify-content-center mx-5" style="margin-top: 15%">
<div class="row">
    <div class="col-6">
        <form>
            <div class="form-group">
                <label>Mã Khách Hàng Của Bạn</label>
                <input type="text" class="form-control">
            </div>
            <div class="form-group">
                <label>Địa chỉ email của bạn</label>
                <input type="email" class="form-control">
            </div>

            <div class="form-group">
                <label>Bạn gặp vấn đề gì?</label>
                <input type="email" class="form-control">
            </div>
            <div class="form-group">
                <label for="exampleFormControlTextarea1">Mô tả vấn đề</label>
                <textarea class="form-control" id="exampleFormControlTextarea1" rows="3"></textarea>
            </div>
            <div class="d-flex justify-content-start">
                <button type="button" class="btn btn-info mt-2">Gửi cho chúng tôi</button>
            </div>
        </form>
    </div>
    <div class="col-6 rounded" style="background-color: #0dcaf0">
        <div class="m-5 fs-5">
            <div class="d-flex mb-3">
                <i class="fa-solid fa-location-dot me-3 mt-1" style="color: #eeeeee"></i>
                <div style="color: #eeeeee"><strong>Địa Chỉ: </strong>Đại Học Nông Lâm TPHCM</div>
            </div>
            <div class="d-flex mb-3">
                <i class="fa-solid fa-phone me-3 mt-1" style="color: #eeeeee"></i>
                <div style="color: #eeeeee"><strong>Số điện thoại: </strong>033.66.77.141</div>
            </div>
            <div class="d-flex mb-3">
                <i class="fa-regular fa-envelope me-3 mt-1" style="color: #eeeeee"></i>
                <div style="color: #eeeeee"><strong>Email: </strong>DH21DTC2023</div>
            </div>
            <div class="d-flex mb-3">
                <i class="fa-solid fa-globe me-3 mt-1" style="color: #eeeeee"></i>
                <div style="color: #eeeeee"><strong>Website: </strong><a>DH21DTC2025.com</a></div>
            </div>
        </div>
    </div>
</div>
</body>
<%
    } else {
        response.sendRedirect(request.getContextPath() + "/login");
    }
%>
</html>