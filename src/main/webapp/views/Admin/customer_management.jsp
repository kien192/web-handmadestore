<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"> <!--icon-->
    <title>Quản Lý Khách Hàng</title>
</head>
<body>
<div class="container-fluid ">
    <div class="title p-2 fw-bold fs-5 mt-2">
        <span>Quản Lý Tài Khoản Khách Hàng</span>
    </div>
    <div class="customer_list mx-auto me-1 mt-5" id="customer">
        <div class="title_customer ">
            <p class="fw-bold fs-5 pt-3 ">Danh sách Tài Khoản Khách Hàng</p>
            <hr>
        </div>
        <div class="mytables ">
            <table class="m-auto" id="mytable">
                <thead>
                <tr class="table_customer sticky-top">
                    <th class="px-4" scope="col ">ID</th>
                    <th class="px-5" scope="col">Họ Và Tên</th>
                    <th class="px-3" scope="col">Ngày Sinh</th>
                    <th class="px-3" scope="col">Giới Tính</th>
                    <th class="px-5" scope="col">Địa Chỉ</th>
                    <th scope="col">Email</th>
                    <th scope="col">Password</th>
                    <th scope="col">Trạng Thái</th>
                    <th scope="col">Chức Năng</th>
                </tr>
                </thead>
                <tbody>
                <tr class="item ctm_1">
                    <td>KH1</td>
                    <td>Lê Bá Phụng</td>
                    <td>12/3/2003</td>
                    <td>Nam</td>
                    <td>25 Phạm Văn Đồng ,Thủ Đức, TP.HCM</td>
                    <td>lungbaphe@gmail.com</td>
                    <td>lebaphung2003</td>
                    <td>Bình Thường</td>
                    <td>
                        <button>Khóa Tài Khoản</button>
                    </td>
                </tr>
                <tr class="item ctm_2">
                    <td>KH2</td>
                    <td>Nguyễn Trung Kiên</td>
                    <td>2/5/2003</td>
                    <td>Nam</td>
                    <td>05 Võ Văn Ngân ,Thủ Đức, TP.HCM</td>
                    <td>trungkien@gmail.com</td>
                    <td>trungkien2003</td>
                    <td>Bình Thường</td>
                    <td>
                        <button>Khóa Tài Khoản</button>
                    </td>
                </tr>
                <tr class="item ctm_3">
                    <td>KH3</td>
                    <td>Nguyễn Trọng Nghĩa</td>
                    <td>25/11/2003</td>
                    <td>Nam</td>
                    <td>An Nhơn,Bình Định</td>
                    <td>trongnghia@gmail.com</td>
                    <td>0123456789</td>
                    <td>Bình Thường</td>
                    <td>
                        <button>Khóa Tài Khoản</button>
                    </td>
                </tr>
                <tr class="item ctm_4">
                    <td>KH4</td>
                    <td>Phạm Văn Bá</td>
                    <td>25/1/2005</td>
                    <td>Nam</td>
                    <td>Bình Chánh,Quảng Bình</td>
                    <td>badao123@gmail.com</td>
                    <td>badao123</td>
                    <td>Bị Khóa</td>
                    <td>
                        <button>Khóa Tài Khoản</button>
                    </td>
                </tr>
                <tr class="item ctm_5">
                    <td>KH5</td>
                    <td>Ngô Văn Tiên</td>
                    <td>2/1/1998</td>
                    <td>Nam</td>
                    <td>Tam Kỳ,Quảng Nam</td>
                    <td>tienngo123@gmail.com</td>
                    <td>tienngo123</td>
                    <td>Bình Thường</td>
                    <td>
                        <button>Khóa Tài Khoản</button>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>


</script>

</body>
<style>

    body {
        padding: 0;
        margin: 0;
        font-size: 15px;
        font-family: Tahoma, Arial, sans-serif;

    }

    .container-fluid {
        width: 100%;
    }

    /*title*/
    .container-fluid .title {
        background-color: #f5f0ea;
        width: 100%;
    }

    .title_customer hr {
        color: #1a73e8;
        border-width: 3px;
    }

    /*    list customer*/
    .container-fluid .customer_list {
        background-color: #ffffff;
        box-shadow: 0px 0px 3px 3px #CACACA;
        border-radius: 4px;
        box-sizing: border-box;
    }

    .container-fluid .customer_list th, td {
        border: 1px solid grey;
        text-align: center;
    }

    .container-fluid .customer_list th {
        background-color: cornflowerblue;
    }

    .container-fluid .customer_list .title_customer {
        text-align: center;
    }

    .container-fluid .customer_list .item button {
        border: none;
        background: white;
    }

    .container-fluid .customer_list .item button:hover {
        background: red;
        color: white;
    }

    .container-fluid .customer_list tbody {
        overflow-y: auto;
        overflow-x: hidden;
    }

    .mytables {
        height: 50vh;
        width: 100%;
        margin: auto;
        overflow-y: scroll;
    }

    tr {
        line-height: 30px;
        min-height: 20px;
        height: 50px;
    }
</style>
</html>