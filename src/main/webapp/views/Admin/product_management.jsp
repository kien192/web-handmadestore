<%@ page import="java.util.List" %>
<%@ page import="model.bean.Product" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.bean.Category" %>
<%@ page import="model.service.CategoryService" %>
<%@ page import="model.service.DiscountService" %>
<%@ page import="model.service.ProductService" %>
<%@ page import="model.bean.Discount" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%List<Product> products = (List<Product>) request.getAttribute("products");%>
<%products = (products == null) ? new ArrayList<>() : products;%>
<%List<Category> categories = (List<Category>) request.getAttribute("categories");%>
<%categories = (categories == null) ? new ArrayList<>() : categories;%>
<%String selectedCategory = (String) request.getAttribute("selectedCategory");%>
<% String childFramePath = (String) request.getAttribute("childFramePath");%>
<% String isShowChildFrame = (String) request.getAttribute("isShowChildFrame");%>
<% String childFrameTitle = (String) request.getAttribute("childFrameTitle");%>
<%System.out.println("rec: " + childFramePath + "  -  " + isShowChildFrame + "  -  " + childFrameTitle);%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"> <!--icon-->
    <title></title>
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

        option {
            background-color: #afe2ea;
        }

        option.op-bg {
            font-weight: bold;
        }

        #infor_center {
            background-color: rgba(0, 0, 0, .75);
            width: 100%;
            height: 100%;
            position: absolute;
            overflow: auto;
            display: none;
            z-index: 9999;
            top: 0;
            left: 0;
        }

        .modal-wrapper {
            padding: 10px;
            width: 70%;
            background-color: white;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        #infor_center_content {
            max-height: 600px;
            max-width: 100%;
            overflow: auto;
            word-wrap: break-word;
            white-space: pre-wrap;
        }
    </style>
</head>
<%
    boolean isAdmin = ((request.getSession().getAttribute("isAdmin") == null) ? false : ((boolean) request.getSession().getAttribute("isAdmin")));
    if (isAdmin) {
%>
<body>
<div class="container-fluid mx-auto mt-2">
    <div class="title m-auto p-2 fw-bold fs-5">
        <span class="ps-2">Quản Lý Sản Phẩm</span>
    </div>
    <div class="function d-flex m-4 fs-6">
        <select class="mx-4 p-2" id="optionFunction" onchange="location=this.value;">

            <option value="<%=request.getContextPath()%>/admin/product?func=product_management&category_id=all"
                    <%if (selectedCategory == null || selectedCategory.equals("all")) {%>
                    selected
                    <%}%>
            >Tất cả sản phẩm
            </option>

            <option class="op-bg"
                    value="<%=request.getContextPath()%>/admin/product?func=product_management&category_id=isSaleTrue"
                    <%if (selectedCategory != null && selectedCategory.equals("isSaleTrue")) {%>
                    selected
                    <%}%>
            >Sản phẩm đang kinh doanh
            </option>

            <option class="op-bg"
                    value="<%=request.getContextPath()%>/admin/product?func=product_management&category_id=isSaleFalse"
                    <%if (selectedCategory != null && selectedCategory.equals("isSaleFalse")) {%>
                    selected
                    <%}%>
            >Sản phẩm ngừng kinh doanh
            </option>
            <option class="op-bg"
                    value="<%=request.getContextPath()%>/admin/product?func=product_management&category_id=hasDiscountTrue"
                    <%if (selectedCategory != null && selectedCategory.equals("hasDiscountTrue")) {%>
                    selected
                    <%}%>
            >Sản phẩm đang áp dụng giảm giá
            </option>
            </option>
            <option class="op-bg"
                    value="<%=request.getContextPath()%>/admin/product?func=product_management&category_id=hasDiscountFalse"
                    <%if (selectedCategory != null && selectedCategory.equals("hasDiscountFalse")) {%>
                    selected
                    <%}%>
            >Sản phẩm không áp dụng giảm giá nào
            </option>

            <option class="op-bg"
                    value="<%=request.getContextPath()%>/admin/product?func=product_management&category_id=nullQuantity"
                    <%if (selectedCategory != null && selectedCategory.equals("nullQuantity")) {%>
                    selected
                    <%}%>
            >Sản phẩm hết hàng
            </option>

            <%for (Category c : categories) {%>
            <option value="<%=request.getContextPath()%>/admin/product?func=product_management&category_id=<%=c.getId()%>"
                    <%if (selectedCategory != null && selectedCategory.equals(c.getId())) {%>
                    selected
                    <%}%>
            ><%=c.getName()%>
            </option>
            <%}%>
        </select>
        <div class=" ms-auto d-flex">
            <div class="box_1 mx-4 p-2" id="addProduct">
                <a
                        href="<%=request.getContextPath()%>/admin/product?func=product_management&category_id=<%=selectedCategory%>&func_2=showAddProductFrame"
                        style="cursor: pointer"><i class="fa-solid fa-plus me-2"
                                                   style="color: white;"></i>
                    Thêm sản phẩm mới</a>
            </div>
            <div class="box_1 mx-4 p-2" id="discount">
                <a
                        href="<%=request.getContextPath()%>/admin/product?func=product_management&category_id=<%=selectedCategory%>&func_2=showDiscountManagementFrame"
                        style="cursor: pointer"><i class="fa-solid fa-pen  me-2 m-auto" style="color: white;"></i>Quản
                    lý
                    khuyến mãi giảm
                    giá
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
                    <th class="px-5" scope="col">Mô tả chi tiết</th>
                    <th class="px-5" scope="col">Số lượng có sẵn</th>
                    <th class="px-5" scope="col">Số lượng đã bán</th>
                    <th class="px-5" scope="col">Giá nhập vào</th>
                    <th class="px-5" scope="col">Giá bán ra</th>
                    <th class="px-5" scope="col">Giảm giá được áp dụng</th>
                    <th class="px-5" scope="col">Giá sản phẩm hiện tại</th>
                    <th class="px-3" scope="col">Trạng thái kinh doanh sản phẩm</th>
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
                    <td class="px-4"><%=p.getDescription().substring(0, 10) + "..."%>
                    </td>
                    <td class="px-4"><%=p.getQuantity()%>
                    </td>
                    <td class="px-4"><%=p.getSoldout()%>
                    </td>
                    <td class="px-4"><%=p.getCostPrice()%>
                    </td>
                    <td class="px-4"><%=p.getSellingPrice()%>
                    </td>
                    <td class="px-4">
                        <%Discount d = DiscountService.getInstance().getDiscountById(p.getDiscountId());%>
                        <%=(d == null) ? "" : d.getName()%>
                    </td>
                    <td class="px-4"><%=ProductService.getInstance().productPriceIncludeDiscount(p)%>
                    <td class="px-2">
                        <%if (p.getIsSale() == 0) {%>
                        <%--0: false--%>
                        <a title="Nhấp vào để: Tiếp tục kinh doanh sản phẩm này"
                           href="<%=request.getContextPath()%>/admin/product?func=product_management&category_id=<%=selectedCategory%>&switch_product_isSale=<%=p.getId()%>">
                            <i class="fa-solid fa-xmark fs-4" style="color: red"></i>
                        </a>
                        <%} else {%>
                        <%--1: true--%>
                        <a title="Nhấp vào để: Ngừng kinh doanh sản phẩm này"
                           href="<%=request.getContextPath()%>/admin/product?func=product_management&category_id=<%=selectedCategory%>&switch_product_isSale=<%=p.getId()%>">
                            <i class="fa-solid fa-check fs-4"></i>
                        </a>
                        <%}%>
                    </td>
                    <td class="px-4">
                        <%--                        Delete product--%>
                        <a href="<%=request.getContextPath()%>/admin/product?func=product_management&edit_product_id=<%=p.getId()%>"
                           class="px-2"><i
                                class="fa-solid fa-pen fs-4" style="color: #5c7093;"></i></a>
                        <a
                                href="<%=request.getContextPath()%>/admin/product?func=product_management&category_id=<%=selectedCategory%>&func_2=showConfirmBox&delete_product_id=<%=p.getId()%>"
                                class="px-2"><i
                                class="fa-solid fa-trash-can fs-4" style="color: #5c7093;"></i></a>
                    </td>
                </tr>
                <%}%>
                </tbody>
            </table>
        </div>
    </div>
</div>
<div id="infor_center"
        <%if (isShowChildFrame != null && isShowChildFrame.equals("show")) {%>
     style="display: block;"
        <%} else {%>
     style="display: none"
        <%}%>
>
    <div class="modal-wrapper mt-auto">
        <div class="alert alert-primary alert-dismissible">
            <a
                    href="<%=request.getContextPath()%>/admin/product?category_id=<%=selectedCategory%>"
                    class="btn-close"
            ></a>
            <h5 id="infor_center_title"><%=childFrameTitle%>
            </h5>
        </div>
        <iframe src="<%=request.getContextPath()%>/<%=childFramePath%>" frameborder="0" name="content"
                class="content" id="frame" width="100%" height="1000px"
                scrolling="yes"></iframe>
    </div>
</div>
</body>
<%} else {%>
<body></body>
<%}%>
</html>