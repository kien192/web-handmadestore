<%@ page import="java.util.List" %>
<%@ page import="model.service.ProductService" %>
<%@ page import="model.service.ImageService" %>
<%@ page import="model.dao.CategoryDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.bean.*" %>

<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 12/7/2023
  Time: 3:26 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"> <!--icon-->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="<%=request.getContextPath()%>/views/ProductList/productList.css" type="text/css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/views/bootstrap-css/bootstrap.min.css">
    <title>Cửa Hàng Handmade</title>
</head>
<% String filter = request.getAttribute("filter") == null ? "" : (String) request.getAttribute("filter");
    if (filter.equals("ascPrice")) filter = "Giá tăng dần";
    else if (filter.equals("descPrice")) filter = "Giá giảm dần";
    else filter = "Mặc định";
%>
<%List<Category> nameCategory = CategoryDAO.getAll();%>
<body>
<div class="sticky-top">
    <%@include file="../MenuBar/menu.jsp" %>
</div>
<div class="content d-flex flex-row p-3">
    <div class="category col-3">
        <div class="title fw-bold fs-5">
            <p>Danh Mục</p>
        </div>
        <ul class="category_list text-center">
            <%for (Category c : nameCategory) { %>
            <li id="<%=c.getId()%>" class="item_category py-2">
                <a id="a<%=c.getId()%>"
                   href="<%=request.getContextPath()%>/product?category=<%=c.getId()%>"><%=c.getName()%>
                    <i class="fa-solid fa-caret-down"></i></a>
            </li>
            <%}%>
        </ul>
    </div>
    <%-- Phần chính trong danh sách sản phẩm (Sắp xếp, hiêển thị, số trang, chuyển tiếp ,...v..v)   --%>
    <div class="productList">

        <%--Hiển thị theo việc sắp xếp. --%>
        <div class="sort ms-5 d-flex">
            <span>Sắp xếp: </span>
            <ul class="menu_sort">
                <li class="list_sort dropdown">
                    <span id="sortTitle"><%=filter%></span>
                    <ul class="sort_submenu list-group dropdown-menu">
                        <li><a class="sort_item dropdown-item" href="<%=request.getContextPath()%>/product">Mặc định</a>
                        </li>
                        <%
                            String category = request.getParameter("category");
                            if (category == null) {
                        %>
                        <li><a class="sort_item dropdown-item" href="?filter=descPrice">Giá giảm dần</a></li>
                        <li><a class="sort_item dropdown-item" href="?filter=ascPrice">Giá tăng dần</a></li>
                        <%} else {%>
                        <li><a class="sort_item dropdown-item" href="?category=<%=category%>&filter=descPrice">Giá giảm
                            dần</a></li>
                        <li><a class="sort_item dropdown-item" href="?category=<%=category%>&filter=ascPrice">Giá tăng
                            dần</a></li>
                        <%}%>

                    </ul>
                </li>
            </ul>
        </div>

        <%-- Hiển thị sản phẩm theo category.   --%>

        <ul id="allProduct" class="products m-2 me-5 ms-3 d-flex flex-wrap">

            <%if (allProduct == null) {%>
            <p>Không có dữ liệu</p>
            <%} else {%>
            <%for (Product p : allProduct) {%>
            <%String pathImage = ImageService.getInstance().pathImageOnly(p.getId());%>


            <li class="product_li">
                <div class="item_product  me-4">
                    <a class="image" href="product-detail?id=<%=p.getId()%>">
                        <img src="<%=request.getContextPath()%>/<%=pathImage%>">
                    </a>


                    <a href="product-detail?id=<%=p.getId()%>"><p class="pt-4 px-3"><%=p.getName() %>
                    </p>
                    </a>

                    <p><%=p.getSellingPrice()%>
                    </p>



                    <button class="add-to-cart">
                            <a href="add-cart?id=<%=p.getId()%>">
                            <span>Thêm vào giỏ hàng </span>
                            </a>
                        </button>


                    <%--                    <div class="add-to-cart"><span>Thêm vào giỏ hàng</span></div>--%>
                </div>
            </li>

            <%}%>
            <%}%>
        </ul>
        <%--    Số Trang--%>
        <div class="pagination mx-5">
            <%int currentPage = (int) request.getAttribute("currentPage");%>
            <%int totalPage = (int) request.getAttribute("totalPage");%>
            <%
                if (currentPage > 1) {
                    String filters = request.getParameter("filter");
                    String categorys = request.getParameter("category");
                    if (filters == null) {
                        if (categorys == null) {
            %>
            <a class="fs-5" href="./product?page=<%=(currentPage - 1)%>">Trước</a>
            <%} else {%>
            <a class="fs-5" href="./product?category=<%=categorys%>&page=<%=(currentPage - 1)%>">Trước</a>
            <%
                }
            } else {
                if (categorys == null) {
            %>
            <a class="fs-5" href="./product?filter=<%=filters%>&page=<%=(currentPage - 1)%>">Trước</a>
            <%} else {%>
            <a class="fs-5" href="./product?category=<%=categorys%>&filter=<%=filters%>&page=<%=(currentPage - 1)%>">Trước</a>
            <%}%>
            <%}%>
            <%}%>
            <% for (int i = 1; i <= totalPage; i++) {
                if (i == currentPage) { %>
            <strong class="fs-5"><%=i%>
            </strong>
            <%
            } else {
                String filters = request.getParameter("filter");
                String categorys = request.getParameter("category");
                if (filters == null) {
                    if (categorys == null) {
            %>
            <a class="fs-5" href="./product?page=<%=i%>"><%=i%>
                    <%}else{%>
                <a class="fs-5" href="./product?category=<%=categorys%>&page=<%=i%>"><%=i%>
                </a>
                    <%}%>
                    <%} else {
                    if(categorys == null){
            %>
                <a class="fs-5" href="./product?filter=<%=filters%>&page=<%=i%>"><%=i%>
                </a>
                    <%}else{%>
                <a class="fs-5" href="./product?category=<%=categorys%>&filter=<%=filters%>&page=<%=i%>"><%=i%>
                </a>
                    <%}%>
                    <%}%>
                    <%}%>
                    <%}%>
                    <%
                if (currentPage < totalPage) {
                    String filters = request.getParameter("filter");
                    String categorys = request.getParameter("category");
                    if (filters == null) {
                        if(categorys == null){
            %>
                <a class="fs-5" href="./product?page=<%=(currentPage + 1)%>"> Tiếp</a>
                    <%}else{%>
                <a class="fs-5" href="./product?category=<%=categorys%>&page=<%=(currentPage + 1)%>"> Tiếp</a>
                    <%}%>
                    <%} else {
                        if(categorys == null){
            %>
                <a class="fs-5" href="./product?filter=<%=filters%>&page=<%=(currentPage + 1)%>"> Tiếp</a>
                    <%}else{%>
                <a class="fs-5"
                   href="./product?category=<%=categorys%>&filter=<%=filters%>&page=<%=(currentPage + 1)%>"> Tiếp</a>
                    <%}%>
                    <%}%>

                    <%}%>

        </div>
    </div>
</div>
<%--footer--%>
<div class="footer">
    <%@include file="./../Footer/footer.jsp" %>
</div>
</body>
<script>
    let urlParagram = new URLSearchParams(window.location.search);
    let categoryParam = urlParagram.get('category');
    <%for (Category category1 : nameCategory){%>
    let category<%=category1.getId()%> = document.getElementById("<%=category1.getId()%>");
    let acategory<%=category1.getId()%> = document.getElementById("a<%=category1.getId()%>");
    if (categoryParam == <%=category1.getId()%>) {
        category<%=category1.getId()%>.style.background = 'red';
        acategory<%=category1.getId()%>.style.color = 'white';
    }
    <%}%>

</script>
<style>
    /*!*Sort*!*/
    /*.menu_sort {*/
    /*    padding: 0;*/
    /*    margin: 0;*/
    /*    margin-left: 5px;*/
    /*    border: 1px solid grey;*/
    /*}*/

    /*.list_sort {*/
    /*    width: 23vh;*/
    /*    text-align: center;*/
    /*}*/

    /*.menu_sort li .sort_submenu {*/
    /*    padding: 0;*/
    /*    left: 0;*/
    /*    top: 100%;*/
    /*    border-radius: 0;*/
    /*}*/

    /*.menu_sort li .sort li {*/
    /*    border-bottom: 1px solid grey;*/
    /*}*/

    /*.sort_submenu {*/
    /*    display: none;*/
    /*}*/

    /*.menu_sort:hover .sort_submenu {*/
    /*    display: block;*/
    /*}*/

    /*.sort_submenu .sort_item:hover {*/
    /*    background: red;*/
    /*    color: white;*/
    /*}*/

</style>

</html>
