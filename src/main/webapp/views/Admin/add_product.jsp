<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"> <!--icon-->
    <title>Thêm sản phẩm</title>
</head>
<%
    boolean isAdmin = ((request.getSession().getAttribute("isAdmin") == null) ? false : ((boolean) request.getSession().getAttribute("isAdmin")));
    if (isAdmin) {
%>
<body>
<form action="<%=request.getContextPath()%>/addproduct" method="post">
    <div class="row my-4">
        <div class="col-md-6 mb-2">
            <div class="form-floating w-75 mx-5 my-2 p-2 ">
                <input type="text" class="form-control" id="productName" placeholder="Thiệp sinh nhật">
                <label for="productName">Tên sản phẩm</label>
            </div>
            <div class="form-floating w-75 mx-5 my-2 p-2">
                <input type="text" class="form-control" id="quantity" placeholder="Số lượng">
                <label for="quantity">Số lượng</label>
            </div>
            <div class="form-floating w-75 mx-5 my-2 p-2">
                <input type="text" class="form-control" id="costPrice" placeholder="Giá nhập vào">
                <label for="costPrice">Giá nhập vào</label>
            </div>
            <div class="form-floating w-75 mx-5 my-2 p-2">
                <input type="text" class="form-control" id="sellingPrice" placeholder="Giá bán">
                <label for="sellingPrice">Giá bán</label>
            </div>
        </div>
        <div class="col-md-6 mb-5">
            <div class="form-floating w-75 mx-5 my-2 p-2 align-content-start">
                <select class="form-select" id="category" aria-label="Chọn danh mục liên quan">
                    <option value="1" selected>Danh mục 1</option>
                    <option value="2">Danh mục 2</option>
                    <option value="3">Danh mục 3</option>
                </select>
                <label for="category">Chọn danh mục liên quan</label>
            </div>
            <div class="form-floating w-75 mx-5 my-2 p-2">
                <select class="form-select" id="discount" aria-label="Giảm giá áp dụng">
                    <option value="1" selected>Giảm giá Giáng Sinh</option>
                    <option value="2">Tết Nguyên Đán</option>
                </select>
                <label for="discount">Chọn giảm giá áp dụng</label>
            </div>
        </div>
    </div>
    <div class="row my-4 mx-5 border rounded-3">
        <label for="description" class="form-label">Mô tả sản phẩm</label>
        <textarea class="form-control mx-auto w-70" style="height: 300px" id="description" rows="3"></textarea>
    </div>

    <div class="row my-4 mx-5 border rounded-3">
        <!--    input Images-->
        <div class="row">
            <p class="fw-bold">Chọn một hoặc nhiều ảnh cho sản phẩm</p>
        </div>
        <div class="row align-items-center" style="height: 100px;">
            <div class="col-2 text-center ">
                <a href=""><i class="fa-solid fa-upload fs-1" style="color: black"></i></a>
            </div>
            <!--        image -->
            <div class="col-2 text-center mx-2">
                <img src="#" alt="image product">
            </div>
        </div>
    </div>
    <div class="row mb-2 me-5 mb-2">
        <div class="d-flex justify-content-end m-0" id="submit">
            <button type="submit" value="cancel" class="btn btn-outline-warning m-3">Hủy bỏ</button>
            <button type="submit" value="addproduct" class="btn btn-outline-success m-3">Hoàn tất thêm sản phẩm mới
            </button>
        </div>
    </div>
</form>
</body>
<%} else {%>
<body></body>
<%}%>
</html>