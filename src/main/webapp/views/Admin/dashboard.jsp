<%@ page import="model.service.ProductService" %>
<%@ page import="model.bean.User" %>
<%@ page import="model.service.UserService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="../css/main.css">
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
    <script
            src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js">
    </script>
</head>
<%
    boolean isAdmin = ((request.getSession().getAttribute("isAdmin") == null) ? false : ((boolean) request.getSession().getAttribute("isAdmin")));
    if (isAdmin) {
%>
<body>
<div class="m-2 title-main">
    <h5 class="p-3">Chào bạn quay trở lại, Admin ơi!</h5>
</div>
<div class="main-content">
    <div class="card-box m-4 d-flex align-middle">
        <div class="card mb-3 me-3" style="max-width: 300px;">
            <div class="row g-0">
                <div class="col-md-4 card-icon">
                    <i class="bi bi-eye"></i>
                    <p class="card-text">2003</p>
                </div>
                <div class="col-md-8">
                    <div class="card-body">
                        <h5 class="card-title">Lượt xem</h5>
                        <p class="card-text">Tổng số lượt ghé thăm trang web</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="card mb-3 me-3 " style="max-width: 300px;">
            <div class="row g-0">
                <div class="col-md-4 card-icon">
                    <i class="bi bi-bag-fill"></i>
                    <p class="card-text"><%=ProductService.getInstance().getNumberAvailProduct()%>
                    </p>
                </div>
                <div class="col-md-8">
                    <div class="card-body">
                        <h5 class="card-title">Sản phẩm</h5>
                        <p class="card-text">Tổng số lượng sản phẩm có sẵn</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="card mb-3 me-3  " style="max-width: 300px;">
            <div class="row g-0">
                <div class="col-md-4 card-icon">
                    <i class="bi bi-truck"></i>
                    <p class="card-text">78</p>
                </div>
                <div class="col-md-8">
                    <div class="card-body">
                        <h5 class="card-title">Đơn hàng</h5>
                        <p class="card-text">Số lượng đơn hàng đang vận chuyển</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="card mb-3   " style="max-width: 300px;">
            <div class="row g-0">
                <div class="col-md-4 card-icon">
                    <i class="bi bi-people-fill"></i>
                    <p class="card-text">571</p>
                </div>
                <div class="col-md-8">
                    <div class="card-body">
                        <h5 class="card-title">Khách hàng</h5>
                        <p class="card-text">Tổng số lượng khách hàng đang có</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--ĐƠN HÀNG-->
<div class="main-content-se row mx-2 mb-2">
    <div class="chart-product row p-3">
        <div class="best-sell-pd  col-sm-5">
            <h5 class="title-f">Top 5 sản phẩm bán chạy</h5>
            <hr class="line-split">
            <table class="table">
                <thead>
                <tr>
                    <th scope="col">STT</th>
                    <th scope="col">Mã sản phẩm</th>
                    <th scope="col">Tên sản phẩm</th>
                    <th scope="col">Số lượng bán</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>1</td>
                    <th scope="row"> TL100
                    </th>
                    <th scope="row"> Thanh long đan len
                    </th>
                    <td>47</td>

                </tr>
                </tbody>
            </table>
        </div>

        <div class="profit col-sm-7">
            <h5 class="title-f">Doanh thu bán hàng năm 2023</h5>
            <hr class="line-split">
            <canvas id="myCharts" style="width:100%;max-width:600px"></canvas>
        </div>
    </div>
    <div class="row">
        <div class="user-header">
            <h5 class="title-f">10 Khách hàng mới</h5>
            <span><a href="../customer_managerment.html">Chi tiết</a></span>
        </div>
        <hr class="line-split">
        <%for (User u : UserService.getInstance().getNewUsersTop(10)) {%>
        <div class="d-flex">
            <div class="d-flex align-items-center mx-3">
                <i class="bi bi-person-circle"></i>
            </div>
            <div class="mx-3"><%=u.getName()%>
            </div>
            <div class="mx-3"><%=u.getEmail()%>
            </div>
            <div class="mx-3"><%=u.getCreateDate()%>
            </div>
        </div>
        <%}%>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="../js/main.js"></script>
<script src="../js/main.js"></script>
<script>
    const xValues = ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6", "Tháng 7", "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12"];
    const yValues = [0.34, 1.24, 3.55, 6.4, 2.25, 4.0, 3.8, 2.3, 2.0, 5.7, 10.1];

    new Chart("myCharts", {
        type: "line",
        data: {
            labels: xValues,
            datasets: [{
                fill: false,
                lineTension: 0,
                backgroundColor: "#ff0000",
                borderColor: "#1a73e8",
                data: yValues
            }]
        },
        options: {
            legend: {display: false},
            scales: {
                yAxes: [{ticks: {min: 0, max: 14}}],
            }
        }
    });

</script>
</body>
<%
    } else {
        response.sendRedirect(request.getContextPath() + "/login");
    }%>
</html>