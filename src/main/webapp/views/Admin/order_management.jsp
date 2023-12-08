<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"> <!--icon-->
    <title>Quản lý đơn hàng</title>
</head>
<body>
    <div class="container-fluid mx-auto mt-2">
        <div class="title m-auto p-2 fw-bold fs-5">
            <span class="ps-2">Quản Lý Đơn Hàng</span>
        </div>
      <div class="customer_list  mt-5 ">
        <div>
            <p class="fw-bold fs-5 pt-3 text-center">Danh sách đơn hàng</p>
        </div>
          <hr>
        <div class="mytables  ">
            <table class="m-auto" id="mytable">
                <thead>
                <tr class="table_order text-center sticky-top">
                    <th class="col-3 px-5 py-3">ID Khách Hàng</th>
                    <th class="col-4">Tên Khách Hàng</th>
                    <th class="col-3">Tổng Hóa Đơn</th>
                    <th class="col-3">Trạng Thái</th>
                </tr>
                </thead>
                <tbody >
                <tr class="item kh_1 text-center">
                    <td>KH1</td>
                    <td>Lê Bá Phụng</td>
                    <td>395.000</td>
                    <td class="dg">Đang Giao</td>
                </tr>
                <tr class="item kh_2 text-center">
                    <td>KH2</td>
                    <td>Nguyễn Trung Kiên</td>
                    <td>1649.000</td>
                    <td class="cxl">Đang Xử Lý</td>

                </tr>
                <tr class="item kh_3 text-center">
                    <td>KH3</td>
                    <td>Nguyễn Trọng Nghĩa</td>
                    <td>2550.000</td>
                    <td class="dht">Thành công</td>
                </tr>
                <tr class="item kh_4 text-center">
                    <td>KH4</td>
                    <td>Phạm Văn Bá</td>
                    <td>1700.000</td>
                    <td class="hd">Đã hủy</td>
                </tr>
                <tr class="item kh_5 text-center">
                    <td>KH5</td>
                    <td>Ngô Văn Tiên</td>
                    <td>2200.000</td>
                    <td class="dht">Thành công</td>
                </tr>
                </tbody>
            </table>
        </div>
      </div>
    </div>
</body>
<style>
    body{
        padding: 0;
        margin: 0;
        font-size: 15px;
        font-family: Tahoma, Arial, sans-serif;

    }
    .container-fluid{

        width: 100%;

    }
    /*menubar*/
    .container-fluid .title{
        background-color: #f5f0ea;
        width: 100%;



    }


/*    Table*/
    .container-fluid .customer_list{
        background: white;
        box-shadow: 0px 0px 3px 3px #CACACA;
        border-radius: 4px;
        box-sizing: border-box;

    }

  hr {
        color:#1a73e8;
        border-width: 3px;
    }
    .container-fluid .table_order{
        background-color: #afe2ea;

    }
    .container-fluid .mytables th,td{
        border: 1px solid grey;
        text-align: center;
    }
    .container-fluid .mytables .item td{
        padding: 2vh;
    }
    .container-fluid.customer_list {
        border-bottom: 5px solid grey;
    }
    .mytables{
        height: 50vh;
        width: 60%;
        margin: auto;
        overflow-y: scroll;
    }
    tr{
        line-height: 25px;
        min-height: 25px;
        height: 70px;
    }
    .container-fluid .customer_list tr td.dht{

        background: #4d8a54;
        color: #ffffff;
    }
    .container-fluid .customer_list tr td.dg{

        background: #0171d3;
        color: #ffffff;
    }
    .container-fluid .customer_list tr td.cxl{
        background: #ffcc00;
        color: #ffffff;
    }
    .container-fluid .customer_list tr td.hd{
        background: #ff0000;
        color: #ffffff;
    }
</style>
</html>