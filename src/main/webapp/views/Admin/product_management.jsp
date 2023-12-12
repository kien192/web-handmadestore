<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"> <!--icon-->
    <title></title>
</head>
<body>
<div class="container-fluid mx-auto mt-2">
    <div class="title m-auto p-2 fw-bold fs-5">
        <span class="ps-2">Quản Lý Sản Phẩm</span>
    </div>
    <div class="function d-flex m-4 fs-6">
        <select class="me-4 p-2" id="optionFunction">
            <option value="">Tìm kiếm loại sản phẩm</option>
            <option value="thiep">Thiệp HandMade Vintage</option>
            <option value="anh">Scrapbook,Album Ảnh</option>
            <option value="so">Sổ ghi chép, sổ tay</option>
            <option value="...">Đồ decore trang trí nhà,cafe,Homestay</option>
            <option value="...">Nguyên vật liệu,phụ kiện dụng cụ</option>
        </select>
        <div class="add_product me-4 p-2" id="addProduct">
            <a href="add_product.jsp"><i class="fa-solid fa-plus me-2" style="color: white;"></i>Tạo sản phẩm
                mới</a>
        </div>
        <div class="delete_all d-flex p-2" id="deleteAll">
            <i class="fa-solid fa-trash me-2 m-auto" style="color: white;"></i>
            <span>Xóa tất cả</span>
        </div>
    </div>
    <div class="solid"></div>
    <div class="product_list m-auto" id="product">
        <div class="title_product  ">
            <p class="fw-bold fs-5 pt-3  ">Danh sách sản phẩm</p>
        </div>
        <hr>
        <div class="mytables">
            <table class="m-auto" id="mytable">
                <thead>
                <tr class="table_order sticky-top">
                    <th class=" px-5" scope="col">#</th>
                    <th class="px-3" scope="col">Mã sản phẩm</th>
                    <th scope="col">Tên sản phẩm</th>
                    <th class="px-3" scope="col">Số lượng</th>
                    <th class="px-3" scope="col">Tình trạng</th>
                    <th class="px-3" scope="col">Giá nguyên liệu</th>
                    <th class="px-3" scope="col">Giá bán</th>
                    <th class="px-3" scope="col">Chức năng</th>
                </tr>
                </thead>
                <tbody>
                <tr class="item sp_1">
                    <td class="px-5"><input type="checkbox"></td>
                    <td>THM1</td>
                    <td>Thiệp Valentine ý nghĩa</td>
                    <td>150</td>
                    <td>Còn hàng</td>
                    <td>50.000</td>
                    <td>70.000</td>
                    <td>
                        <button><i class="fa-solid fa-pen" style="color: #425e8f;"></i></button>
                        <button><i class="fa-solid fa-trash-can" style="color: #5c7093;"></i></button>
                    </td>
                </tr>
                <tr class="item sp_2">
                    <td class="px-5"><input type="checkbox"></td>
                    <td>SCRB1</td>
                    <td>Scrapbook album ảnh handmade Beauty & the White</td>
                    <td>125</td>
                    <td>Còn hàng</td>
                    <td>600.000</td>
                    <td>649.000</td>
                    <td>
                        <button><i class="fa-solid fa-pen" style="color: #425e8f;"></i></button>
                        <button><i class="fa-solid fa-trash-can" style="color: #5c7093;"></i></button>
                    </td>
                </tr>
                <tr class="item sp_3">
                    <td class="px-5"><input type="checkbox"></td>
                    <td>ST1</td>
                    <td>Sổ da cao cấp mã khóa</td>
                    <td>29</td>
                    <td>Còn hàng</td>
                    <td>670.000</td>
                    <td>750.000</td>
                    <td>
                        <button><i class="fa-solid fa-pen" style="color: #425e8f;"></i></button>
                        <button><i class="fa-solid fa-trash-can" style="color: #5c7093;"></i></button>
                    </td>
                </tr>
                <tr class="item sp_4">
                    <td class="px-5"><input type="checkbox"></td>
                    <td>DC1</td>
                    <td>Đèn bão trang trí Vintage</td>
                    <td>170</td>
                    <td>Còn hàng</td>
                    <td>170.000</td>
                    <td>192.000</td>
                    <td>
                        <button><i class="fa-solid fa-pen" style="color: #425e8f;"></i></button>
                        <button><i class="fa-solid fa-trash-can" style="color: #5c7093;"></i></button>
                    </td>
                </tr>
                <tr class="item sp_5">
                    <td class="px-5"><input type="checkbox"></td>
                    <td>NL1</td>
                    <td>Bó hoa khô mini</td>
                    <td>250</td>
                    <td>Còn hàng</td>
                    <td>20.000</td>
                    <td>50.000</td>
                    <td>
                        <button><i class="fa-solid fa-pen" style="color: #425e8f;"></i></button>
                        <button><i class="fa-solid fa-trash-can" style="color: #5c7093;"></i></button>
                    </td>
                </tr>
                <tr class="item sp_5">
                    <td class="px-5"><input type="checkbox"></td>
                    <td>NL1</td>
                    <td>Bó hoa khô mini</td>
                    <td>250</td>
                    <td>Còn hàng</td>
                    <td>20.000</td>
                    <td>50.000</td>
                    <td>
                        <button><i class="fa-solid fa-pen" style="color: #425e8f;"></i></button>
                        <button><i class="fa-solid fa-trash-can" style="color: #5c7093;"></i></button>
                    </td>
                </tr>
                <tr class="item sp_5">
                    <td class="px-5"><input type="checkbox"></td>
                    <td>THM5</td>
                    <td>Thiệp handmade Vintage Film</td>
                    <td>250</td>
                    <td>Còn hàng</td>
                    <td>30.000</td>
                    <td>39.000</td>
                    <td>
                        <button><i class="fa-solid fa-pen" style="color: #425e8f;"></i></button>
                        <button><i class="fa-solid fa-trash-can" style="color: #5c7093;"></i></button>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
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

    /*menubar*/
    .container-fluid .title {
        background-color: #f5f0ea;
        width: 100%;


    }

    .container-fluid .product_list {
        background-color: #ffffff;
        box-shadow: 0px 0px 3px 3px #CACACA;
        border-radius: 4px;
        box-sizing: border-box;

    }

    .product_list hr {
        color: #1a73e8;
        border-width: 3px;
    }

    .title_product p {
        text-align: center;
    }

    .container-fluid .function .add_product a {
        text-decoration: none;
        color: white;
    }

    .container-fluid .function .add_product {
        background: deepskyblue;
        border-radius: 5px;
    }

    .container-fluid .function .add_product:hover {
        background: #4d9da9;
    }

    .container-fluid .function .delete_all {
        background: #aba8a8;
        color: white;
        border-radius: 5px;
        cursor: pointer;
    }

    .container-fluid .function .delete_all:hover {
        background: #ff0000;
    }

    /*table*/
    .container-fluid.product_list {
        background: white;
    }

    .container-fluid .product_list th, td {
        border: 1px solid grey;
        text-align: center;
    }

    .container-fluid .product_list th {
        background-color: #afe2ea;
    }

    .container-fluid .product_list .item button:active {
        background: #afe2ea;
        border: 1px solid white;
    }

    .container-fluid .product_list tbody {
        overflow-y: auto;
        overflow-x: hidden;
    }

    .container-fluid.product_list .title_product {
        text-align: center;
    }

    .container-fluid .product_list {
        border-bottom: 5px solid grey;
    }

    .mytables {
        height: 50vh;
        width: 90%;
        margin: auto;
        overflow-y: scroll;
    }

    tr {
        line-height: 25px;
        min-height: 25px;
        height: 50px;
    }

</style>
</html>