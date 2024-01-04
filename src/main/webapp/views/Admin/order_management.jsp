<%@ page import="java.util.List" %>
<%@ page import="model.bean.Order" %>
<%@ page import="model.service.OrderService" %>
<%@ page import="model.service.UserService" %>
<%@ page import="model.bean.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%List<Order> orders = OrderService.getInstance().getAll();%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"> <!--icon-->
    <title>Quản lý đơn hàng</title>
    <style>
        #showBox {
            position: fixed;
            top: 30%;
            left: 50%;
            transform: translate(-50%, -50%);
            overflow: auto;
            z-index: 9;
            background-color: #2c3e50;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
        }

        .my-custom-scrollbar {
            position: relative;
            height: 60%;
            overflow: auto;
        }

        .table-wrapper-scroll-y {
            display: block;
        }
    </style>
</head>
<%
    boolean isAdmin = ((request.getSession().getAttribute("isAdmin") == null) ? false : ((boolean) request.getSession().getAttribute("isAdmin")));
    if (isAdmin) {
%>
<body>
<div class="container-fluid mx-auto mt-2">
    <form action="<%=request.getContextPath()%>/admin/order" method="post" id="orderForm">
        <div class="title m-auto p-2 fw-bold fs-5">
            <span class="ps-2">Quản Lý Đơn Hàng</span>
        </div>
        <div class="customer_list  mt-5 ">
            <div>
                <p class="fw-bold fs-5 pt-3 text-center">Danh sách đơn hàng</p>
            </div>
            <hr>
            <div class="table-wrapper-scroll-y my-custom-scrollbar">
                <table class="table table-striped table-hover">
                    <thead>
                    <tr class="text-center sticky-top">
                        <th class="text-nowrap">Mã Đơn Hàng</th>
                        <th class="text-nowrap">Mã Khách Hàng</th>
                        <th class="text-nowrap">Tên Khách Hàng</th>
                        <th class="text-nowrap">Địa Chỉ Giao</th>
                        <th class="text-nowrap">Ngày Đặt Hàng</th>
                        <th class="text-nowrap">Tổng Tiền Hóa Đơn</th>
                        <th class="text-nowrap">Phí Vận Chuyển</th>
                        <th class="text-nowrap">Tổng Hóa Đơn</th>
                        <th class="text-nowrap">Trạng Thái</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        for (Order o : orders) {
                            User customer = UserService.getInstance().getUserById(o.getUserId() + "");
                    %>
                    <tr class="text-center" style=" cursor: pointer;"
                        onclick="submit_showOrderDetails(event,this)"
                        id="<%=o.getId()%>"
                    >
                        <td><%=o.getId()%>
                        </td>
                        <td><%=customer.getId()%>
                        </td>
                        <td class="text-start"><%=customer.getName()%>
                        </td>
                        <td class="text-start"><%=o.getAddress()%>
                        </td>
                        <td><%=o.getOrderDate()%>
                        </td>
                        <td><%=o.getTotalPrice()%>
                        </td>
                        <td><%=o.getShippingFee()%>
                        </td>
                        <td><%=o.getTotalPrice() + o.getShippingFee()%>
                        </td>
                        <td
                                <%!
                                    String backgroundColor = "";
                                    String sttvalue = "";
                                %>
                                <%
                                    if (o.getStatus().equals("Đang giao")) {
                                        backgroundColor = "#0171d3";
                                        sttvalue = "Đang giao";
                                    } else if (o.getStatus().equals("Đang xử lý")) {
                                        backgroundColor = "#ffcc00";
                                        sttvalue = "Đang Xử Lý";
                                    } else if (o.getStatus().equals("Đã hủy")) {
                                        backgroundColor = "#ff0000";
                                        sttvalue = "Đã hủy";
                                    } else if (o.getStatus().equals("Thành công")) {
                                        backgroundColor = "#4d8a54";
                                        sttvalue = "Thành công";
                                    }%>
                                style="background-color: <%=backgroundColor%>; color: #ffffff"
                        ><%=sttvalue%>
                        </td>
                    </tr>
                    <%}%>
                    </tbody>
                </table>
            </div>
        </div>
        <input type="hidden" id="currentOrderId" name="currentOrderId" value="">
        <%--        showbox--%>
        <div id="showBox" class="w-50 bg-secondary p-3 rounded">
            <div class="text-center fw-bold p-3" style="font-size: 30px; color: #0dcaf0">Thông tin đơn hàng</div>

        </div>
    </form>
</div>
<script>
    function submit_showOrderDetails(event, clickedElement) {
        event.preventDefault();
        var orderId = clickedElement.id;
        //set cho hide input
        document.getElementById("currentOrderId").value = orderId;
        document.getElementById("orderForm").submit();
    }
</script>
</body>
<%
    } else {
        response
                .
                sendRedirect
                        (
                                request
                                        .
                                        getContextPath
                                                (
                                                )
                                        +
                                        "/login"
                        )
        ;
    }%>
</html>