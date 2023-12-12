<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"> <!--icon-->
    <title>Thêm sản phẩm</title>
</head>
<body>
<div class="container-fluid ">
    <div class="title m-auto p-2 fw-bold fs-5 mt-2">
        <span>Thêm Sản Phẩm</span>
    </div>
    <div class="infor_product my-4">
        <input class="infor col-sm-5 mx-5 my-2 p-2" type="text" placeholder="Mã sản phẩm">
        <input class="infor col-sm-5 mx-5 my-2 p-2" type="text" placeholder="Tên sản phẩm">
        <input class="infor col-sm-5 mx-5 my-2 p-2" type="text" placeholder="Số lượng">
        <input class="infor col-sm-5 mx-5 my-2 p-2" type="text" placeholder="Giá nhập">
        <input class="infor col-sm-5 mx-5 my-2 p-2" type="text" placeholder="Giá bán">
        <input class="infor col-sm-5 mx-5 my-2 p-2" type="text" placeholder="Nhà cung cấp">
    </div>
    <div class="image mx-5">
        <p class="fw-bold">Chọn ảnh đại diện cho sản phẩm</p>
        <i class="fa-solid fa-upload fs-2"></i>
    </div>
    <div class="descrip_produce mx-5">
        <p class="mt-4 fs-5 fw-bold">Miêu tả sản phẩm</p>
        <textarea></textarea>
    </div>
    <div class="save_product my-4 text-center " id="submit">
        <button class="p-3 fw-bold">Lưu sản phẩm</button>
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


    /*title*/
    .container-fluid .title {
        background-color: #f5f0ea;
        width: 100%;

    }

    /*infor*/
    .container-fluid .infor_product .infor {
        border-radius: 5px;
        border: none;
    }

    /*input*/
    .container-fluid input {
        background-color: #f5f0ea;
        outline: none;
    }


    /*image*/
    .container-fluid .image {
        color: #168d16;
        background: white;
        border: 3px dotted grey;
        border-radius: 10px;
        display: inline-block;
        padding: 10px;
        cursor: pointer;
    }

    .container-fluid .image:active {
        background: #afe2ea;
    }

    .container-fluid .image i {
        margin-left: 40%;
    }

    /*description*/
    .container-fluid .descrip_produce textarea {
        width: 100%;
        height: 25vh;
        border-radius: 7px;
    }

    /*save product*/
    .container-fluid .save_product button {
        border-radius: 5px;
        background: #afe2ea;
        color: #000000;
        border: none;
    }

    .container-fluid .save_product button:hover {
        background: #ff0000;
        color: #ffffff;
    }
</style>
</html>