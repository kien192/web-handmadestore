<%@ page import="model.bean.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="model.service.ProductService" %>
<%@ page import="model.service.ImageService" %><%--
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
    <link href="<%=request.getContextPath()%>/views/ProductList/productList.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/views/bootstrap-css/bootstrap.min.css">
    <title>Cửa Hàng Handmade</title>
</head>
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
            <li class="item_category py-2">
                <a href="#">Thiệp HandMade Vintage <i class="fa-solid fa-caret-down"></i></a>
            </li>
            <li class="item_category py-2">
                <a href="#">Scrapbook,Album Ảnh <i class="fa-solid fa-caret-down"></i></a>
            </li>
            <li class="item_category py-2">
                <a href="#">Sổ ghi chép, sổ tay <i class="fa-solid fa-caret-down"></i></a>
            </li>
            <li class="item_category py-2">
                <a href="#">Đồ decore trang trí <i class="fa-solid fa-caret-down"></i></a>
            </li>
            <li class="item_category py-2">
                <a href="#">Nguyên liệu,phụ kiện <i class="fa-solid fa-caret-down"></i></a>
            </li>
        </ul>
    </div>
    <div class="productList">
        <div class="sort ms-5 d-flex">
            <span>Sắp xếp: </span>
            <ul class="menu_sort">
               <li class="list_sort dropdown">
                   <span>Mặc định</span>
                   <ul class="sort_submenu list-group dropdown-menu">
                       <li ><a class="sort_item dropdown-item" href="<%=request.getContextPath()%>/product?func=product&filter=descPrice">Giá giảm dần</a></li>
                       <li ><a class="sort_item dropdown-item" href="<%=request.getContextPath()%>/product?func=product&filter=ascPrice">Giá tăng dần</a></li>
                   </ul>
               </li>
            </ul>
        </div>
        <%List<Product> allProduct = (List<Product>) request.getAttribute("productInPage");%>
        <ul id="allProduct" class="products m-2 me-5 ms-3 d-flex flex-wrap">
            <%if (allProduct == null) {%>
            <p>Không có dữ liệu</p>
            <%} else {%>
            <%for (Product p : allProduct) {%>
            <%String pathImage = ImageService.getInstance().pathImageOnly(p.getId());%>
            <li class="product_li">
                <div class="item_product  me-4">
                    <a class="image" href="#"> <img src="<%=request.getContextPath()%>/<%=pathImage%>"> </a>
                    <a href="#"><p class="pt-4 px-3"><%=p.getName() %>
                    </p></a>
                    <p><%=p.getSellingPrice()%>
                    </p>
                    <div class="add-to-cart"><span>Thêm vào giỏ hàng</span></div>
                </div>
            </li>

            <%}%>
            <%}%>
        </ul>
        <%--    Số Trang--%>
        <div class="pagination mx-5">
            <%int currentPage = (int) request.getAttribute("currentPage");%>
            <%int totalPage = (int) request.getAttribute("totalPage");%>
            <%if (currentPage > 1) {%>
            <a class="fs-5" href="./product?page=<%=(currentPage - 1)%>">Trước</a>
            <%}%>
            <% for (int i = 1; i <= totalPage; i++) {
                if (i == currentPage) { %>
            <strong class="fs-5"><%=i%>
            </strong>
            <%} else {%>
            <a class="fs-5" href="./product?page=<%=i%>"><%=i%>
            </a>
            <%}%>
            <%}%>
            <%if (currentPage < totalPage) {%>
            <a class="fs-5" href="./product?page=<%=(currentPage + 1)%>"> Tiếp</a>
            <%}%>

        </div>
    </div>
</div>
<div class="footer">
    <%@include file="./../Footer/footer.jsp" %>
</div>
</body>

</html>
