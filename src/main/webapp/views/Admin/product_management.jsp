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
<%
    String selectedCategory = (String) request.getAttribute("selectedCategory");
    selectedCategory = (selectedCategory == null) ? "all" : selectedCategory;
%>
<% String childFramePath = (String) request.getAttribute("childFramePath");%>
<% String isShowChildFrame = (String) request.getAttribute("isShowChildFrame");%>
<% String childFrameTitle = (String) request.getAttribute("childFrameTitle");%>
<% Product edit_product = (Product) request.getAttribute("edit_product");%>
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

        .my-custom-scrollbar {
            position: relative;
            height: 60%;
            overflow: auto;
        }

        .table-wrapper-scroll-y {
            display: block;
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

        #edit_product {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            overflow: auto;
            display: none;
            z-index: 1030;
            background-color: #2c3e50; /* Adjust the background color as needed */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5); /* Optional: Add a box shadow for a subtle effect */
        }
    </style>
</head>
<%
    boolean isAdmin = ((request.getSession().getAttribute("isAdmin") == null) ? false : ((boolean) request.getSession().getAttribute("isAdmin")));
    if (isAdmin) {
%>
<body>
<%--edit--%>
<%if (edit_product != null) {%>
<form action="<%=request.getContextPath()%>/admin/product">
    <div id="edit_product" class="w-50 bg-secondary p-3 rounded"
         style="display: block">
        <div class="text-center fw-bold p-3" style="font-size: 30px; color: #0dcaf0">Chỉnh sửa thông tin sản phẩm có
            mã: <%=edit_product.getId()%>
        </div>

        <div class="err">
            <% String re = request.getAttribute("result") == null ? "" : request.getAttribute("result").toString(); %>
            <p id="errPass" class="text-center" style="color: red"><%=re%>
            </p>
        </div>
        <div class="row my-4">
            <div class="col-md-6 mb-2">
                <div class="form-floating w-100 mx-5 my-2 p-2 ">
                    <input type="text" class="form-control" name="last_edit_product_id"
                           value="<%=edit_product.getId()%>" style="display: none">
                    <input type="text" class="form-control" id="productName" name="productName"
                           value="<%=edit_product.getName()%>">
                    <label for="productName">Tên sản phẩm (Lưu ý: Không nên chứa ký tự '#')</label>
                </div>
                <div class="form-floating w-100 mx-5 my-2 p-2">
                    <input type="number" class="form-control" id="quantity" name="quantity"
                           value="<%=edit_product.getQuantity()%>">
                    <label for="quantity">Số lượng</label>
                </div>
                <div class="form-floating w-100 mx-5 my-2 p-2">
                    <input type="number" class="form-control" id="costPrice" name="costPrice"
                           value="<%=edit_product.getCostPrice()%>">
                    <label for="costPrice">Giá nhập vào</label>
                </div>
                <div class="form-floating w-100 mx-5 my-2 p-2">
                    <input type="number" class="form-control" id="sellingPrice" name="sellingPrice"
                           value="<%=edit_product.getSellingPrice()%>">
                    <label for="sellingPrice">Giá bán</label>
                </div>
            </div>
            <%--        Choice category and create new category--%>
            <div class="col-md-6 mb-5">
                <div class="mt-4">
                    <div class="m-0 border alert alert-dismissible d-flex align-items-center  mx-5 my-2 p-2">
                        <div class="me-4">
                            <input class="form-check-input fs-5" style="cursor: pointer" type="radio"
                                   name="choiceCategory" id="case1"
                                <%if (edit_product.getCategoryId()>0){%>
                                   checked
                                <%}%>
                                   value="choiceAvailableCategory"
                                   onclick="showAvailableCategory()">
                            <label class="form-check-label" style="cursor: pointer" for="case1">
                                Chọn danh mục có sẵn
                            </label>
                        </div>
                        <div>
                            <input class="form-check-input fs-5" style="cursor: pointer" type="radio"
                                   name="choiceCategory"
                                   id="case2"
                                <%if (edit_product.getCategoryId()<=0){%>
                                   checked
                                <%}%>
                                   value="choiceNewCategory"
                                   onclick="showInputToNewCategory()"
                            >
                            <label class="form-check-label" style="cursor: pointer" for="case2">
                                Tạo danh mục mới
                            </label>
                        </div>
                    </div>
                    <div class="form-floating  mx-5 my-2 p-2 align-content-start"
                            <%if (edit_product.getCategoryId() > 0) {%>
                         style="display: block"
                            <%} else {%>
                         style="display: none"
                            <%}%>
                         id="showAvailableCategory">
                        <select class="form-select" id="availableCategory" name="availableCategory"
                                aria-label="Chọn danh mục liên quan">
                            <%for (Category category : categories) {%>
                            <option value="<%=category.getId()%>"
                                    <% if (edit_product.getCategoryId() == category.getId()) {%>
                                    selected
                                    <%}%>
                            >
                                <%=category.getName()%>
                            </option>
                            <%}%>
                        </select>
                        <label>Chọn danh mục liên quan</label>
                    </div>
                    <div class="form-floating  mx-5 my-2 p-2 align-content-start"
                            <%if (edit_product.getCategoryId() > 0) {%>
                         style="display: none"
                            <%} else {%>
                         style="display: block"
                            <%}%>
                         id="showInputToNewCategory">
                        <input type="text" class="form-control" id="newCategory" name="newCategory">
                        <label for="newCategory">Nhập tên danh mục mới</label>
                    </div>
                    <div class="form-floating  mx-5 my-2 p-2">
                        <select class="form-select" id="discountId" aria-label="Giảm giá áp dụng" name="discount">
                            <option value="" selected></option>
                            <%for (Discount d : DiscountService.getInstance().getAll()) {%>
                            <option value="<%=d.getId()%>"
                                    <%if (edit_product.getDiscountId() == d.getId()) {%>
                                    selected
                                    <%}%>
                            >
                                <%=d.getName()%> - giảm <%=d.getPercentageOff() * 100%>%
                            </option>
                            <%}%>
                        </select>
                        <label for="discountId">Chọn giảm giá áp dụng</label>
                    </div>
                </div>
            </div>
        </div>
        <div class="row my-4 mx-5 border rounded-3">
            <label for="description" class="form-label">Mô tả sản phẩm</label>
            <textarea class="form-control mx-auto w-70"
                      style="height: 200px; white-space: nowrap; overflow: auto; resize: none;"
                      id="description" name="description"
                      rows="3"><%=edit_product.getDescription()%></textarea>
        </div>
        <div class="d-flex justify-content-end m-0">
            <button type="button" onclick="hideEditProduct()" class="btn btn-outline-warning m-3 fs-5 fw-bold"
                    style="color: #eeeeee">Thoát
            </button>
            <button type="submit"
                    class="btn btn-outline-success m-3 fs-5 fw-bold"
                    style="color: #eeeeee"
                    title="Hoàn tất nếu bạn chắc chắn đã điền đầy đủ thông tin">Hoàn tất chỉnh sửa
            </button>
        </div>
    </div>
</form>
<script>
    function showAvailableCategory() {
        document.getElementById("showInputToNewCategory").style.display = "none";
        document.getElementById("showAvailableCategory").style.display = "block";
    }

    function showInputToNewCategory() {
        document.getElementById("showAvailableCategory").style.display = "none";
        document.getElementById("showInputToNewCategory").style.display = "block";
    }

    function hideEditProduct() {
        document.getElementById("edit_product").style.display = "none";
    }
</script>
<%}%>
<%--main--%>
<div class="container-fluid mx-auto mt-2">
    <div class="title m-auto p-2 fw-bold fs-5">
        <span class="ps-2">Quản Lý Sản Phẩm</span>
    </div>
    <div class="function d-flex m-4 fs-6">
        <div class="mx-4 p-2 d-flex">
            <select class="me-2" id="optionFunction" onchange="location=this.value;">
                </option>
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
                        <%if (selectedCategory != null && selectedCategory.equals(c.getId() + "")) {%>
                        selected
                        <%}%>
                ><%=c.getName()%>
                </option>
                <%}%>
                <option
                    <%if (request.getAttribute("nameFilter") != null) {%>
                        selected
                    <%}%>
                        disabled
                >
            </select>
            <form action="<%=request.getContextPath()%>/admin/product">
                <div class="input-group">
                    <input type="text" class="form-control 1" placeholder="Nhập từ khóa"
                           title="Nhập ký tự # ở đầu để tìm theo mã sản phẩm"
                           name="nameFilter"
                           value="<%=request.getAttribute("nameFilter")==null?"":request.getAttribute("nameFilter")%>">
                    <input type="text" name="func" value="product_management" style="display: none">
                    <div class="input-group-append">
                        <button
                                class="btn btn-outline-secondary" type="submit">Tìm
                        </button>
                    </div>
                </div>
            </form>
        </div>
        <div class=" ms-auto d-flex">
            <a
                    href="<%=request.getContextPath()%>/admin/product?func=product_management&category_id=<%=selectedCategory%>&func_2=showCategoriesFrame"
                    style="cursor: pointer">
                <div class="box_1 mx-4 p-2" id="category">
                    <i class="fa-regular fa-square-minus me-2"
                       style="color: white;"></i>
                    Quản lý danh mục
                </div>
            </a>
            <a
                    href="<%=request.getContextPath()%>/admin/product?func=product_management&category_id=<%=selectedCategory%>&func_2=showAddProductFrame"
                    style="cursor: pointer">
                <div class="box_1 mx-4 p-2" id="addProduct">
                    <i class="fa-solid fa-plus me-2"
                       style="color: white;"></i>
                    Thêm sản phẩm mới
                </div>
            </a>

            <a
                    href="<%=request.getContextPath()%>/admin/product?func=product_management&category_id=<%=selectedCategory%>&func_2=showDiscountManagementFrame"
                    style="cursor: pointer">
                <div class="box_1 mx-4 p-2" id="discount">
                    <i class="fa-solid fa-pen  me-2 m-auto" style="color: white;"></i>Quản lý khuyến mãi giảm giá
                </div>
            </a>
        </div>
    </div>

    <div class="solid"></div>
    <div class="product_list m-auto" id="product">
        <div class="title_product  ">
            <p class="fw-bold fs-5 pt-3  ">Danh sách sản phẩm</p>
        </div>
        <hr>
        <div class="table-wrapper-scroll-y my-custom-scrollbar">
            <table class="table">
                <thead>
                <tr class="table_order sticky-top">
                    <th class="px-3" scope="col">Mã sản phẩm</th>
                    <th scope="col">Tên sản phẩm</th>
                    <th class="px-5" scope="col">Mô tả</th>
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
                    <td class="px-4">
                        <%if (p.getDescription().length() > 9) {%>
                        <%=p.getDescription().substring(0, 10) + "..."%>
                        <%} else {%>
                        <%=p.getDescription() + "..."%>
                        <%}%>
                    </td>
                    <td class="px-4"><%=p.getQuantity()%>
                    </td>
                    <td class="px-4"><%=p.getSoldout()%>
                    </td>
                    <td class="px-4"><%=p.getCostPrice()%>
                    </td>
                    <td class="px-4"><%=p.getSellingPrice()%>
                    </td>
                    <%!double finalSellingPrice;%>
                    <%finalSellingPrice = ProductService.getInstance().productPriceIncludeDiscount(p);%>
                    <td class="px-4">

                        <%Discount d = DiscountService.getInstance().getDiscountById(p.getDiscountId() + "");%>
                        <%if (finalSellingPrice == p.getSellingPrice()) {%>
                        <del style="text-decoration-color: red;">
                            <%=(d == null) ? "" : d.getName() + " - giảm " + (d.getPercentageOff() * 100) + "%"%>
                        </del>
                        <%} else {%>
                        <%=(d == null) ? "" : d.getName() + " - giảm " + (d.getPercentageOff() * 100) + "%"%>
                        <%}%>
                    </td>
                    <td class="px-4"><%=finalSellingPrice%>
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
                                href="<%=request.getContextPath()%>/admin/product?func=product_management&func_2=showConfirmBox&delete_product_id=<%=p.getId()%>&category_id=<%=selectedCategory%>"
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
<%
    } else {
        response.sendRedirect(request.getContextPath() + "/login");
    }%>
</html>