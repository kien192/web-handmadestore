<%@ page import="org.w3c.dom.stylesheets.LinkStyle" %>
<%@ page import="java.util.List" %>
<%@ page import="model.bean.Product" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.bean.Image" %><%--
  Created by IntelliJ IDEA.
  User: Kien Nguyen
  Date: 12/11/2023
  Time: 4:41 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<% List<Product> data = (List<Product>) request.getAttribute("data");--%>
<%--    if(data == null) data = new ArrayList<>();--%>
<% List<Image> imageList =(List<Image>) request.getAttribute("listImage");%>


<html>
<head>
    <title>ProductDetails</title>

    <jsp:include page="/views/product-details/css/detailCss.jsp"/>
</head>
<body>

<jsp:include page="/views/MenuBar/menu.jsp"/>

<!-- Nội dung Product-details-->
<!-- Thẻ navigation   -->
<section class="product-details container  pt-2">

    <nav aria-label="breadcrumb">
        <ol class="breadcrumb ">
            <li class="breadcrumb-item"><a href="../../MainPage/view_mainpage/mainpage.jsp">Home</a></li>
            <li class="breadcrumb-item"><a href="../../MainPage/view_mainpage/mainpage.jsp">Scrapbook, Album Ảnh</a> </li>
            <li class="breadcrumb-item active" aria-current="page"><%=request.getAttribute("productById")%>></li>
        </ol>
    </nav>
    <div class="row mt-3 ">
        <!--  zoom container start-->


        <div class="xzoom-container col-lg-5 col-md-12 col-12">
            <%if(imageList != null && !imageList.isEmpty()) {
                Image mainImage = imageList.get(0);

            %>
            <img class="img-fluid w-100 pb-1 xzoom " id="MainImg" src="<%=mainImage.getPath()%>"   alt="">
            <div class="small-img-group">
                <%for(int i = 1; i< Math.min(imageList.size(), 4); i++) {
                    Image secondImage = imageList.get(i);
                %>
                <div class="small-img-col">
                    <img src="<%= secondImage.getPath()%>" width="100%" class="small-img" alt="">
                </div>
                <%}}%>



            </div>

        </div>
        <div class="col-lg-7 col-md-12 col-12 right-pd">

            <h3 class=""><%=request.getAttribute("proName") %></h3>
            <div class="d-flex rate-content" >
                <div class="icon-rate me-3">
                    <i class="bi bi-star "></i>
                    <i class="bi bi-star"></i>
                    <i class="bi bi-star"></i>
                    <i class="bi bi-star"></i>
                    <i class="bi bi-star"></i></div>
                <a href="#rating-comment">Đánh giá của bạn</a>

            </div>
            <div class="state-pd my-2">
                <label class="me-2 gray-content">Trạng thái: </label>
<%--    <% int available =Integer.parseInt((String) request.getAttribute("proAvai")); %>--%>
<%--                <%if(available == 0 ) { %>--%>
<%--                <%="Hết hàng nha quý zịiiii"%>--%>

<%--                <%} else {%>--%>
<%--                <%="Hàng bán đến tết congo cũng chưa hết!!"%>--%>
<%--                <%}%>--%>


     <span><%="Còn hàng"%></span>
            </div>
            <h2 class="price-pd mb-4">
                <%=request.getAttribute("proQua") + " đ"%>

            <div class="row">
                <div class="quantity-pd mb-4 col-4">
                    <label  class="me-2"  style="font-size: 14px">Số lượng: </label>
                    <div class="qu-value">
                        <button class="pd-des m-0">-</button>
                        <input type="text" class="quantity-input p-0" value="1">
                        <button class="pd-inc m-0">+</button>
                    </div>
                </div>



                <button class="buy-btn col-4" style="font-size: 16px" <%=request.getAttribute("disable")%>>Thêm vào giỏ hàng</button>


            </div>

<%--                    <c:if test="${request.getAttribute('alert')}">--%>
<%--                    <div class="row justify-content-center mt-3">--%>
<%--                        <div class="alert alert-danger d-flex justify-content-center" role="alert"--%>
<%--                             data-aos="fade-up" style="max-width: 600px; min-width: 400px">--%>
<%--                            <strong class="font-weight-bold">--%>
<%--                                Chỉ còn <%= request.getAttribute("productById.quantity") %> có sẵn !--%>
<%--                            </strong>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    </c:if>--%>
        </div>


            <hr class="mx-auto">
            <h4 class=" mt-4 mb-4 ">Chi tiết sản phẩm</h4>
            <p class="gray-content">
            <%=request.getAttribute("proDtails")%>

            </p>
        </div>
    </div>


</section>
<section class="product-description container mt-5">
    <h4 >Giới thiệu sản phẩm</h4>
    <hr class="mx-auto under">

    <div class="content-descr container">
        <p>- <strong>Scrapbook </strong> được định nghĩa là một cuốn sổ lưu niệm tự thiết kế dùng để lưu giữ thông tin đến chủ sở hữu, gia đình và bạn bè. Scrapbook lưu giữ hình ảnh, hay cả những tác phẩm nghệ thuật. Đồng thời, album Scrapbook được trang trí và lưu lại bút ký của bạn, bạn bè hoặc bất cứ ai.</p>
        <p>- Nó được làm hoàn toàn từ 100% giấy tái chế, có thể tái chế, phân hủy sinh học và có thể phân hủy sinh học. Tấm bìa được làm từ giấy cứng để đảm bảo độ chắc chắn và bảo vệ trang bên trong. Tất cả được ghép lại bằng dây kim loại. </p>
        <div class="d-flex flex-column justify-content-center">
            <img src="../../images/scrapbook-intro.jpg" alt="" class=" img-thumbnail mx-auto w-50">
            <figure>Sản phẩm được làm thủ công tại HeadQuarters</figure>
        </div>
        <p>- Hãy lưu giữ những tấm hình chứa đựng những kỉ niệm đẹp, những mảng ký ức của bản thân, gia đình, bạn bè vào scrapbook và hi vọng bạn yêu thích sản phẩm của chúng tôi </p>
        <p>- Sản phẩm này sẽ được vận chuyển sớm trong vòng 2-3 ngày.</p>
        <p>- Nếu bạn có bất kỳ thắc mắc cần giải đáp xin vui lòng liên hệ qua Hotline 1900 3456.</p>
    </div>



</section>

<section id="rating-comment" class="rating container mt-5" >
    <h4 pb-1>Đánh giá - Bình luận </h4>

    <div class="ratings mb-3">
        <i class="bi bi-star-fill "></i>
        <i class="bi bi-star-fill "></i>
        <i class="bi bi-star-fill"></i>
        <i class="bi bi-star-fill"></i>
        <i class="bi bi-star-fill"></i>
    </div>
    <div class="d-flex comment-pd">
    <textarea class="comment-input p-2" rows="3" placeholder="Viết bình luận" maxlength="350">

    </textarea>
        <button type="button" class="submit-comment btn  btn-outline-success btn-sm shadow-sm ">Gửi</button>
        <div class="comments">
            <!-- Các bình luận sẽ được hiển thị ở đây -->
        </div>

    </div>


</section>



<section id="relate" class="my-5 ">
    <div class="container pb-4">
        <h4>Sản phẩm liên quan</h4>
        <hr class="mx-auto">

        <div class="row my-5 " >
            <div class="col info-item mx-3">
                <div class="info-img ">
                    <img src="../../images/anh3.webp" alt="" class="img-fluid d-block mx-auto mt-2">


                    <div class="row btns w-100 mx-auto ">
                        <button type="button" class="col-6 py-2">
                            <i class="bi bi-cart-plus"></i>

                        </button>
                        <button type="button" class="col-6 py-2">
                            <i class="bi bi-eye"></i>
                        </button>
                    </div>
                </div>
                <div class="info-product p-3" >
                    <a href="#" class="d-block text-dark text-decoration-none py-2 info-name">
                        Scrapbook album ảnh handmade Sweet Mint
                    </a>
                    <span class="info-price fw-bold">649.000₫ </span>
                    <div class="info-rating d-flex mt-1">
                        <i class="bi bi-star-fill "></i>
                        <i class="bi bi-star-fill "></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <span>(25 đánh giá)</span>
                    </div>
                </div>

            </div>
            <div class="col info-item mx-3">
                <div class="info-img ">
                    <img src="../../images/anh3.webp" alt="" class="img-fluid d-block mx-auto mt-2">


                    <div class="row btns w-100 mx-auto ">
                        <button type="button" class="col-6 py-2">
                            <i class="bi bi-cart-plus"></i>

                        </button>
                        <button type="button" class="col-6 py-2">
                            <i class="bi bi-eye"></i>
                        </button>
                    </div>
                </div>
                <div class="info-product p-3" >
                    <a href="#" class="d-block text-dark text-decoration-none py-2 info-name">
                        Scrapbook album ảnh handmade Sweet Mint
                    </a>
                    <span class="info-price fw-bold">649.000₫ </span>
                    <div class="info-rating d-flex mt-1">
                        <i class="bi bi-star-fill "></i>
                        <i class="bi bi-star-fill "></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <span>(25 đánh giá)</span>
                    </div>
                </div>

            </div>
            <div class="col info-item mx-3">
                <div class="info-img ">
                    <img src="../../images/anh3.webp" alt="" class="img-fluid d-block mx-auto mt-2">


                    <div class="row btns w-100 mx-auto ">
                        <button type="button" class="col-6 py-2">
                            <i class="bi bi-cart-plus"></i>

                        </button>
                        <button type="button" class="col-6 py-2">
                            <i class="bi bi-eye"></i>
                        </button>
                    </div>
                </div>
                <div class="info-product p-3" >
                    <a href="#" class="d-block text-dark text-decoration-none py-2 info-name">
                        Scrapbook album ảnh handmade Sweet Mint
                    </a>
                    <span class="info-price fw-bold">649.000₫ </span>
                    <div class="info-rating d-flex mt-1">
                        <i class="bi bi-star-fill "></i>
                        <i class="bi bi-star-fill "></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <span>(25 đánh giá)</span>
                    </div>
                </div>

            </div>
            <div class="col info-item mx-3">
                <div class="info-img ">
                    <img src="../../images/anh3.webp" alt="" class="img-fluid d-block mx-auto mt-2">


                    <div class="row btns w-100 mx-auto ">
                        <button type="button" class="col-6 py-2">
                            <i class="bi bi-cart-plus"></i>

                        </button>
                        <button type="button" class="col-6 py-2">
                            <i class="bi bi-eye"></i>
                        </button>
                    </div>
                </div>
                <div class="info-product p-3" >
                    <a href="#" class="d-block text-dark text-decoration-none py-2 info-name">
                        Scrapbook album ảnh handmade Sweet Mint
                    </a>
                    <span class="info-price fw-bold">649.000₫ </span>
                    <div class="info-rating d-flex mt-1">
                        <i class="bi bi-star-fill "></i>
                        <i class="bi bi-star-fill "></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <span>(25 đánh giá)</span>
                    </div>
                </div>

            </div>
            <div class="col info-item mx-3">
                <div class="info-img ">
                    <img src="../../images/anh3.webp" alt="" class="img-fluid d-block mx-auto mt-2">


                    <div class="row btns w-100 mx-auto ">
                        <button type="button" class="col-6 py-2">
                            <i class="bi bi-cart-plus"></i>

                        </button>
                        <button type="button" class="col-6 py-2">
                            <i class="bi bi-eye"></i>
                        </button>
                    </div>
                </div>
                <div class="info-product p-3" >
                    <a href="#" class="d-block text-dark text-decoration-none py-2 info-name">
                        Scrapbook album ảnh handmade Sweet Mint
                    </a>
                    <span class="info-price fw-bold">649.000₫ </span>
                    <div class="info-rating d-flex mt-1">
                        <i class="bi bi-star-fill "></i>
                        <i class="bi bi-star-fill "></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <span>(25 đánh giá)</span>
                    </div>
                </div>

            </div>

        </div>


    </div>







</section>

<!--    Footer-->
<div id="footer">
    <ul class="d-flex ">
        <li class="content col-6" >
            <img src="../../images/logo.png" width="30%">
            <p class="me-5">
                HEADQUARTERS là cửa hàng về đồ HANDMADE về đồ trang trí, phụ kiện, thiệp, album ảnh, sổ tay được làm thủ công
                đẹp, ý nghĩa, thân thiện với mọi người.
            </p>
        </li>
        <li class="contact col-6 mt-5">
            <p class="content fs-2 fw-bold">Liên hệ với chúng tôi</p>
            <div class="address d-flex">
                <i class="fa-solid fa-location-dot py-2" style="color: #4d8a54"></i>
                <p class="p-2">Địa chỉ: Lớp DH21DTC,Khoa Công Nghệ Thông Tin,</br> Trường Đại Học Nông Lâm TP.HCM</p>
            </div>
            <div class="hotline d-flex">
                <i class="fa-solid fa-mobile-screen py-2" style="color: #4d8a54"></i>
                <p class="p-2">Hotline : 1900 3456</p>
            </div>
            <div class="icon">
                <a class="me-3 fs-3" href=""><i class="fa-brands fa-twitter" style="color: #4d8a54"></i></a>
                <a class="mx-3 fs-3" href=""><i class="fa-brands fa-facebook" style="color: #4d8a54"></i></a>
                <a class="mx-3 fs-3" href=""><i class="fa-brands fa-square-instagram" style="color: #4d8a54"></i></a>
                <a class="mx-3 fs-3" href=""><i class="fa-brands fa-youtube" style="color: #4d8a54"></i></a>
            </div>
        </li>
    </ul>
    <div class="solid  m-auto "></div>
    <div class="content_end fs-6 fw-bold text-center">
        <p>Bản quyền thuộc về HEADQUARTERS| Cung cấp bởi HEADQUARTERS</p>
    </div>
</div>






<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>

<script>
    var MainImg = document.getElementById('MainImg');
    var smallimg = document.getElementsByClassName('small-img');
    smallimg[0].onclick = function () {
        MainImg.src = smallimg[0].src;
    }
    smallimg[1].onclick = function () {
        MainImg.src = smallimg[1].src;
    }
    smallimg[2].onclick = function () {
        MainImg.src = smallimg[2].src;
    }
    smallimg[3].onclick = function () {
        MainImg.src = smallimg[3].src;
    }


</script>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const incrementButton = document.querySelector(".pd-inc");
        const decrementButton = document.querySelector(".pd-des");
        const quantityInput = document.querySelector(".quantity-input");

        incrementButton.addEventListener("click", function () {
            quantityInput.value = parseInt(quantityInput.value) + 1;
        });

        decrementButton.addEventListener("click", function () {
            const currentValue = parseInt(quantityInput.value);
            if (currentValue > 1) {
                quantityInput.value = currentValue - 1;
            }
        });
    });
</script>
</body>
</html>
