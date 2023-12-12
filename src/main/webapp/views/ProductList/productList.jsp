<%@ page import="model.bean.Product" %>
<%@ page import="java.util.List" %><%--
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
    <link href="<%=request.getContextPath()%>/views/bootstrap-css/bootstrap.min.css">
    <title>Cửa Hàng Handmade</title>
</head>
<%List<Product> allProduct = (List<Product>) request.getAttribute("allProduct");%>
<body>
    <div>
        <%@include file="../MenuBar/menu.jsp"%>
    </div>
    <div class="category">
        <div>
            <p>Danh Mục</p>
        </div>
        <ul>
            <li>
                <a>Thiệp HandMade Vintage</a>
            </li>
            <li>
                <a>Scrapbook,Album Ảnh</a>
            </li>
            <li>
                <a>Sổ ghi chép, sổ tay</a>
            </li>
            <li>
                <a>Đồ decore trang trí nhà,cafe,Homestay</a>
            </li>
            <li>
                <a>Nguyên vật liệu,phụ kiện dụng cụ</a>
            </li>
        </ul>
    </div>
    <div id="product" class="allProduct">
        <%if(allProduct == null){%>
        <p>Không có dữ liệu</p>
        <%}else{%>
<%--        <%for(Product p : allProduct) {%>--%>
        <div class="product">
            <%--                <p><%=p.getName() %></p>--%>
            <%--                <p><%=p.getSellingPrice()%></p>--%>
            <p>có dữ liệu</p>
        </div>
<%--        <%}%>--%>
        <%}%>
    </div>
</body>
</html>
