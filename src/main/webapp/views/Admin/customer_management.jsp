<%@ page import="java.util.List" %>
<%@ page import="model.bean.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%List<User> users = (List<User>) request.getAttribute("users");%>
<% users = (users == null) ? new ArrayList<>() : users;%>
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
                    <th class="px-3" scope="col">Số điện thoại</th>
                    <th class="px-3" scope="col">Địa chỉ email</th>
                    <th class="px-5" scope="col">Ngày tạo tài khoản</th>
                    <th scope="col">Trạng thái</th>
                    <th scope="col"><i class="fa-solid fa-user-pen fs-4"></i></th>
                </tr>
                </thead>
                <tbody>
                <% for (User u : users) {%>
                <tr class="item ctm_1">
                    <td class="px-2"><%=u.getId()%>
                    </td>
                    <td class="px-2"><%=u.getName()%>
                    </td>
                    <td class="px-2"><%=u.getPhoneNumber()%>
                    </td>
                    <td class="px-2"><%=u.getEmail()%>
                    </td>
                    <td class="px-2"><%=u.getCreateDate()%>
                    </td>
                    <td class="px-2"><%=u.getStatus()%>
                    </td>
                    <td class="px-2">
                        <%if (u.getStatus().trim().startsWith("Bình")) {%>
                        <a title="Khóa tải khoản"
                           href="<%=request.getContextPath()%>/admin?func=customer_management&user_id=<%=u.getId()%>"><i
                                class="fa-solid fa-lock fs-4"></i></a>
                        <%} else if (u.getStatus().trim().equalsIgnoreCase("Bị khóa")) {%>
                        <a title="Bỏ khóa tải khoản"
                           href="<%=request.getContextPath()%>/admin?func=customer_management&user_id=<%=u.getId()%>"><i
                                class="fa-solid fa-unlock fs-4"></i></a>
                        <%}%>
                    </td>
                </tr>
                <%}%>
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