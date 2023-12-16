<%@ page import="java.util.List" %>
<%@ page import="model.bean.Product" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.bean.Category" %>
<%@ page import="model.service.CategoryService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%List<Product> products = (List<Product>) request.getAttribute("products");%>
<%products = (products == null) ? new ArrayList<>() : products;%>
<%List<Category> categories = (List<Category>) request.getAttribute("categories");%>
<%categories = (categories == null) ? new ArrayList<>() : categories;%>
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
        <select class="mx-4 p-2" id="optionFunction">
            <%for (Category c : categories) {%>
            <option value=""><a href="#"><%=c.getName()%>
            </a></option>
            <%}%>
        </select>
        <div class="ms-auto d-flex">
            <div class="box_1 mx-4 p-2" id="addProduct">
                <a href="add_product.jsp"><i class="fa-solid fa-plus me-2" style="color: white;"></i>Tạo sản phẩm
                    mới</a>
            </div>
            <div class="delete_all d-flex p-2" id="deleteAll">
                <i class="fa-solid fa-trash me-2 m-auto" style="color: white;"></i>
                <span>Xóa tất cả</span>
            </div>
            <div class="box_1 mx-4 p-2" id="discount">
                <a href="discount_management.jsp">
                    <i class="fa-solid fa-pen  me-2 m-auto" style="color: white;"></i>Quản lý khuyến mãi giảm giá
                </a>
            </div>
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
                    <th class="px-3" scope="col">Mã sản phẩm</th>
                    <th scope="col">Tên sản phẩm</th>
                    <th class="px-5" scope="col">Số lượng có sẵn</th>
                    <th class="px-5" scope="col">Số lượng đã bán</th>
                    <th class="px-5" scope="col">Giá nhập vào</th>
                    <th class="px-5" scope="col">Giá bán ra</th>
                    <th class="px-5" scope="col">Giảm giá được áp dụng</th>
                    <th class="px-5" scope="col">Giá sản phẩm</th>
                    <th class="px-5" scope="col">Mô tả chi tiết</th>
                    <th class="px-5" scope="col">Chức năng</th>
                </tr>
                </thead>
                <tbody>
                <%for (Product p : products) {%>
                <tr class="item sp_1">
                    <td class="px-4"><%=p.getId()%>
                    </td>
                    <td class="px-4"><%=p.getName()%>
                    </td>
                    <td class="px-4"><%=p.getQuantity()%>
                    </td>
                    <td class="px-4"><%=p.getSoldout()%>
                    </td>
                    <td class="px-4"><%=p.getCostPrice()%>
                    </td>
                    <td class="px-4"><%=p.getSellingPrice()%>
                    </td>
                    <td class="px-4">Tên khuyến mãi</td>
                    <td class="px-4">Tính giá cuôi cùng</td>
                    <td class="px-4">Link mô tả</td>
                    <td class="px-4">
                        <button><i class="fa-solid fa-pen" style="color: #425e8f;"></i></button>
                        <button><i class="fa-solid fa-trash-can" style="color: #5c7093;"></i></button>
                    </td>
                </tr>
                <%}%>
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

    .container-fluid .function a {
        text-decoration: none;
        color: white;
    }

    .container-fluid .function .box_1 {
        background: deepskyblue;
        border-radius: 5px;
    }

    .container-fluid .function .box_1:hover {
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