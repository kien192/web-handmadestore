--
-- Database: `handmadestore`
--

CREATE
DATABASE handmadestore;
USE
handmadestore;

--
-- Table structure
--

CREATE TABLE `banner_items`
(
    `title`       varchar(50) NOT NULL,
    `description` text DEFAULT NULL,
    `img_path`    text        NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `category`
(
    `id`   int(11) NOT NULL,
    `name` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `discount`
(
    `id`            int(11) NOT NULL,
    `name`          varchar(30) NOT NULL,
    `startDate`     datetime       DEFAULT current_timestamp(),
    `endDate`       datetime       DEFAULT current_timestamp(),
    `percentageOff` decimal(10, 2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `image`
(
    `id`        int(11) NOT NULL,
    `name`      varchar(255) DEFAULT NULL,
    `path`      text NOT NULL,
    `productId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `order`
(
    `id`          int(11) NOT NULL,
    `totalPrice`  decimal(10, 2) NOT NULL,
    `orderDate`   datetime       DEFAULT current_timestamp(),
    `status`      varchar(20)    NOT NULL,
    `address`     varchar(200)   NOT NULL,
    `shippingFee` decimal(10, 2) DEFAULT 0.00,
    `userId`      int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `order_details`
(
    `orderId`                int(11) NOT NULL,
    `productId`              int(11) NOT NULL,
    `quantity`               int(11) NOT NULL,
    `sellingPrice`           decimal(10, 2) NOT NULL,
    `finalSellingPrice`      decimal(10, 2) NOT NULL,
    `explainPriceDifference` varchar(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `product`
(
    `id`           int(11) NOT NULL,
    `name`         varchar(255) DEFAULT NULL,
    `description`  text           NOT NULL,
    `costPrice`    decimal(10, 2) NOT NULL,
    `sellingPrice` decimal(10, 2) NOT NULL,
    `quantity`     int(11) DEFAULT 1,
    `soldout`      int(11) DEFAULT 0,
    `categoryId`   int(11) NOT NULL,
    `discountId`   int(11) DEFAULT NULL,
    `isSale`       tinyint(1) NOT NULL DEFAULT 1 CHECK (`isSale` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `rate`
(
    `productId`   int(11) NOT NULL,
    `userId`      int(11) NOT NULL,
    `starRatings` int(11) NOT NULL,
    `comment`     text NOT NULL,
    `createDate`  datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `role`
(
    `id`   int(11) NOT NULL DEFAULT 1,
    `name` varchar(20) DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tips`
(
    `title`       varchar(50)  NOT NULL,
    `description` text DEFAULT NULL,
    `img_path`    text         NOT NULL,
    `video_link`  varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `user`
(
    `id`          int(11) NOT NULL,
    `name`        varchar(40) NOT NULL,
    `phoneNumber` varchar(12) NOT NULL,
    `email`       varchar(30) NOT NULL,
    `password`    varchar(30) NOT NULL,
    `createDate`  datetime    DEFAULT current_timestamp(),
    `status`      varchar(25) DEFAULT 'Bình Thường',
    `roleId`      int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Trigger: id > 0: category, discount, order, product, rate, user
--
DELIMITER
CREATE TRIGGER `trigger_insert_category`
    BEFORE INSERT
    ON `category`
    FOR EACH ROW
BEGIN
    IF NEW.id <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot insert a non-positive value into an auto-increment column';
END IF;
END
DELIMITER ;

DELIMITER
CREATE TRIGGER `trigger_insert_discount`
    BEFORE INSERT
    ON `discount`
    FOR EACH ROW
BEGIN
    IF NEW.id <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot insert a non-positive value into an auto-increment column';
END IF;
END
DELIMITER ;

DELIMITER
CREATE TRIGGER `trigger_insert_order`
    BEFORE INSERT
    ON `order`
    FOR EACH ROW
BEGIN
    IF NEW.id <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot insert a non-positive value into an auto-increment column';
END IF;
END
DELIMITER ;

DELIMITER
CREATE TRIGGER `trigger_insert_product`
    BEFORE INSERT
    ON `product`
    FOR EACH ROW
BEGIN
    IF NEW.id <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot insert a non-positive value into an auto-increment column';
END IF;
END
DELIMITER ;

DELIMITER
CREATE TRIGGER `trigger_insert_rate`
    BEFORE INSERT
    ON `rate`
    FOR EACH ROW
BEGIN
    IF NEW.id <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot insert a non-positive value into an auto-increment column';
END IF;
END
DELIMITER ;

DELIMITER
CREATE TRIGGER `trigger_insert_user`
    BEFORE INSERT
    ON `user`
    FOR EACH ROW
BEGIN
    IF NEW.id <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot insert a non-positive value into an auto-increment column';
END IF;
END
DELIMITER ;

--
-- INSERT DATA
--
INSERT INTO `banner_items` (`title`, `description`, `img_path`)
VALUES ('CÙNG NHAU KHÁM PHÁ NÀO!', 'Những sản phẩm đang nóng lòng đợi bạn rinh về nè !',
        'images/banner_tip/item_1.jpg'),
       ('Độc - Đẹp - Bền - Giá Phù Hợp', 'Chế tạo những sản phẩm độc đáo, với tình yêu và sự tận tụy',
        'images/banner_tip/item_2.jpg'),
       ('KÍNH CHÀO QUÝ KHÁCH', 'Mỗi sản phẩm từ HandmadeStore là một phần trái tim của ai đó',
        'images/banner_tip/item_3.jpg');
INSERT INTO `category` (`id`, `name`)
VALUES (1, 'Thiệp, Khung Ảnh Handmade Vint'),
       (2, 'Scrapbook, Album Ảnh'),
       (3, 'Sổ ghi chép, sổ tay'),
       (4, 'Trang sức, phụ kiện thời trang'),
       (5, 'Đồ decor trang trí');

INSERT INTO `discount` (`id`, `name`, `startDate`, `endDate`, `percentageOff`)
VALUES (1, 'Giáng Sinh', '2023-12-20 00:00:00', '2023-12-26 00:00:00', 0.15),
       (2, 'Tết Nguyên Đán', '2024-02-01 00:00:00', '2023-02-16 00:00:00', 0.20),
       (3, 'Ngày phụ nữ Việt Nam', '2024-10-19 00:00:00', '2024-10-20 00:00:00', 0.30),
       (4, 'Ngày Valentine', '2024-02-10 00:00:00', '2024-02-14 00:00:00', 0.30),
       (5, 'Ngày Nhà giáo Việt Nam', '2024-11-15 00:00:00', '2024-11-20 00:00:00', 0.20);

INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES (1, 'Thiệp handmade vintage Beauty & the White', 'images/products/1.webp', 1),
       (2, 'Thiệp handmade vintage Beauty & the White', 'images/products/1_1.webp', 1),
       (3, 'Thiệp handmade vintage Beauty & the White', 'images/products/1_2.webp', 1),
       (4, 'Thiệp handmade Film de Paris', 'images/products/2.webp', 2),
       (5, 'Thiệp handmade Film de Paris', 'images/products/2_1.webp', 2),
       (6, 'Thiệp handmade Film de Paris', 'images/products/2_2.webp', 2),
       (7, 'Thiệp chúc mừng Sweet Mint', 'images/products/3.webp', 3),
       (8, 'Thiệp chúc mừng Sweet Mint', 'images/products/3_1.webp', 3),
       (9, 'Thiệp chúc mừng Sweet Mint', 'images/products/3_2.webp', 3),
       (10, 'Thiệp chúc mừng Black & White', 'images/products/4.webp', 4),
       (11, 'Thiệp chúc mừng Black & White', 'images/products/4_1.webp', 4),
       (12, 'Thiệp chúc mừng Black & White', 'images/products/p04_2.webp', 4),
       (13, 'Thiệp handmade Amazing Carto', 'images/products/p05.webp', 5),
       (14, 'Thiệp handmade Amazing Carto', 'images/products/p05_1.webp', 5),
       (15, 'Thiệp handmade Amazing Carto', 'images/products/p05_2.webp', 5),
       (16, 'Thiệp handmade lớn Beauty & the White', 'images/products/p06.webp', 6),
       (17, 'Thiệp handmade lớn Beauty & the White', 'images/products/p06_1.webp', 6),
       (18, 'Thiệp handmade lớn Beauty & the White', 'images/products/p06_2.webp', 6),
       (19, 'Thiệp da bò độc đáo', 'images/products/p07.webp', 7),
       (20, 'Thiệp da bò độc đáo', 'images/products/p07_1.webp', 7),
       (21, 'Thiệp da bò độc đáo', 'images/products/p07_2.webp', 7),
       (22, 'Thiệp dấu sáp mini', 'images/products/p08.webp', 8),
       (23, 'Thiệp dấu sáp mini', 'images/products/p08_1.webp', 8),
       (24, 'Thiệp dấu sáp mini', 'images/products/p08_2.webp', 8),
       (25, 'Thiệp handmade Vintage Film', 'images/products/p09.webp', 9),
       (26, 'Thiệp handmade Vintage Film', 'images/products/p09_1.webp', 9),
       (27, 'Thiệp handmade Vintage Film', 'images/products/p09_2.webp', 9),
       (28, 'Thiệp handmade vintage vải bố', 'images/products/p10.webp', 10),
       (29, 'Thiệp handmade vintage vải bố', 'images/products/p10_1.webp', 10),
       (30, 'Thiệp handmade vintage vải bố', 'images/products/p10_2.webp', 10),
       (31, 'Thiệp gỗ Jigsaws', 'images/products/p11.webp', 11),
       (32, 'Thiệp gỗ Jigsaws', 'images/products/p11_1.webp', 11),
       (33, 'Thiệp gỗ Jigsaws', 'images/products/p11_2.webp', 11),
       (34, 'Thiệp gỗ Other Half', 'images/products/p12.webp', 12),
       (35, 'Thiệp gỗ Other Half', 'images/products/p12_1.webp', 12),
       (36, 'Thiệp gỗ Other Half', 'images/products/p12_2.webp', 12),
       (37, 'Thiệp chúc mừng handmade Blue Pastel', 'images/products/p13.webp', 13),
       (38, 'Thiệp chúc mừng handmade Blue Pastel', 'images/products/p13_1.webp', 13),
       (39, 'Thiệp chúc mừng handmade Blue Pastel', 'images/products/p13_2.webp', 13),
       (40, 'Thiệp vintage Retro Clock', 'images/products/p14.webp', 14),
       (41, 'Thiệp vintage Retro Clock', 'images/products/p14_1.webp', 14),
       (42, 'Thiệp vintage Retro Clock', 'images/products/p14_2.webp', 14),
       (43, 'Thiệp giấy carton handmade - Thiệp chúc mừng sinh nhật', 'images/products/p15.webp', 15),
       (44, 'Thiệp giấy carton handmade - Thiệp chúc mừng sinh nhật', 'images/products/p15_1.webp', 15),
       (45, 'Thiệp giấy carton handmade - Thiệp chúc mừng sinh nhật', 'images/products/p15_2.webp', 15),
       (46, 'Thiệp tặng bạn thân - Thiệp vintage retro', 'images/products/p16.webp', 16),
       (47, 'Thiệp tặng bạn thân - Thiệp vintage retro', 'images/products/p16_1.webp', 16),
       (48, 'Thiệp tặng bạn thân - Thiệp vintage retro', 'images/products/p16_2.webp', 16),
       (49, 'Giấy viết thư cổ điển Vintage', 'images/products/p17.webp', 17),
       (50, 'Giấy viết thư cổ điển Vintage', 'images/products/p17_1.webp', 17),
       (51, 'Giấy viết thư cổ điển Vintage', 'images/products/p17_2.webp', 17),
       (52, 'Khung ảnh đẹp Frame Triple', 'images/products/p18.webp', 18),
       (53, 'Khung ảnh đẹp Frame Triple', 'images/products/p18_1.webp', 18),
       (54, 'Khung ảnh đẹp Frame Triple', 'images/products/p18_2.webp', 18),
       (55, 'Khung ảnh frame 6 in 1', 'images/products/p19.webp', 19),
       (56, 'Khung ảnh frame 6 in 1', 'images/products/p19_1.webp', 19),
       (57, 'Khung ảnh frame 6 in 1', 'images/products/p19_2.webp', 19),
       (58, 'Khung ảnh gỗ 3 in 1', 'images/products/p20.webp', 20),
       (59, 'Khung ảnh gỗ 3 in 1', 'images/products/p20_1.webp', 20),
       (60, 'Khung ảnh gỗ 3 in 1', 'images/products/p20_2.webp', 20),
       (61, 'Khung ảnh, tủ móc khóa, móc treo 3 in 1', 'images/products/p21.webp', 21),
       (62, 'Khung ảnh, tủ móc khóa, móc treo 3 in 1', 'images/products/p21_1.webp', 21),
       (63, 'Khung hình vintage triple cỡ lớ', 'images/products/p22.webp', 22),
       (64, 'Khung ảnh handmade - thiệp handmade đẹp 2 in 1', 'images/products/p23.webp', 23),
       (65, 'Khung ảnh kiểu Địa Trung Hải', 'images/products/p24.webp', 24),
       (66, 'Khung ảnh vintage kiểu US Army', 'images/products/p25.webp', 25),
       (67, 'Khung ảnh vintage trắng ngà', 'images/products/p26.webp', 26),
       (68, 'Khung ảnh - móc treo FISH HOOK', 'images/products/p27.webp', 27),
       (69, 'Khung ảnh gỗ và thạch cao Ivory Vintage', 'images/products/p28.webp', 28),
       (70, 'Khung ảnh gỗ và thạch cao Ivory Vintage', 'images/products/p28_1.webp', 28),
       (71, 'Khung ảnh gỗ và thạch cao Ivory Vintage', 'images/products/p28_2.webp', 28),
       (72, 'Khung ảnh Hải Âu Mediterranea', 'images/products/p29.webp', 29),
       (73, 'Khung ảnh Địa Trung Hải Kayak', 'images/products/p30.webp', 30),
       (74, 'Khung ảnh vintage hoa văn vuông', 'images/products/p31.jpg', 31),
       (75, 'Khung ảnh mèo Totoro', 'images/products/p32.webp', 32),
       (76, 'Khung ảnh mèo Totoro', 'images/products/p32_1.webp', 32),
       (77, 'Khung ảnh mèo Totoro', 'images/products/p32_2.webp', 32),
       (78, 'Khung ảnh Staring time (lớn)', 'images/products/p33.webp', 33),
       (79, 'Khung ảnh Staring time (lớn)', 'images/products/p33_1.webp', 33),
       (80, 'Khung ảnh Staring time (lớn)', 'images/products/p33_2.webp', 33),
       (81, 'Khung ảnh gỗ thông Rustic', 'images/products/p34.webp', 34),
       (82, 'Khung ảnh gỗ thông Rustic', 'images/products/p34_1.webp', 34),
       (83, 'Khung ảnh gỗ thông Rustic', 'images/products/p34_2.webp', 34),
       (84, 'Khung ảnh Hải Âu Mediterranea', 'images/products/p35.webp', 35),
       (85, 'Khung trang trí bàn hoa hồng sứ C-rose frame', 'images/products/p36.webp', 36),
       (86, 'KHUNG ẢNH NGÔI NHÀ CỬA SỔ NÂU (NGANG)', 'images/products/p37.webp', 37),
       (87, 'KHUNG ẢNH NGÔI NHÀ CỬA SỔ NÂU (NGANG)', 'images/products/p37_1.webp', 37),
       (88, 'KHUNG ẢNH NGÔI NHÀ XE ĐẠP', 'images/products/p38.webp', 38),
       (89, 'KHUNG ẢNH NGÔI NHÀ XE ĐẠP', 'images/products/p38_1.webp', 38),
       (90, 'KHUNG ẢNH VÒNG ĐU QUAY VINTAGE', 'images/products/p39.webp', 39),
       (91, 'Bì thư vintage Tem Việt', 'images/products/p40.webp', 40),
       (92, 'Bì thư vintage Tem Việt', 'images/products/p40_1.webp', 40),
       (93, 'Bì thư vintage Tem Việt', 'images/products/p40_2.webp', 40),
       (94, 'Scrapbook That Time', 'images/products/p41.webp', 41),
       (95, 'Scrapbook That Time', 'images/products/p41_1.webp', 41),
       (96, 'Scrapbook That Time', 'images/products/p41_2.webp', 41),
       (97, 'Scrapbook Sweet Mint', 'images/products/p42.webp', 42),
       (98, 'Scrapbook Sweet Mint', 'images/products/p42_1.webp', 42),
       (99, 'Scrapbook Fly That Time', 'images/products/p43.webp', 43),
       (100, 'Scrapbook Fly That Time', 'images/products/p43_1.webp', 43),
       (101, 'Album ảnh handmade Fly Sweet Mint', 'images/products/p44.webp', 44),
       (102, 'Album ảnh handmade Fly Sweet Mint', 'images/products/p44_1.webp', 44),
       (103, 'Album ảnh handmade Fly Sweet Mint', 'images/products/p44_2.webp', 44),
       (104, 'Album ảnh tự trang trí Love Story (Xanh)', 'images/products/p45.webp', 45),
       (105, 'Album ảnh tự trang trí Love Story (Xanh)', 'images/products/p45_1.webp', 45),
       (106, 'Album ảnh tự trang trí Love Story (Xanh)', 'images/products/p45_2.webp', 45),
       (107, 'Scrapbook Retro Clock', 'images/products/p46.webp', 46),
       (108, 'Scrapbook Retro Clock', 'images/products/p46_1.webp', 46),
       (109, 'Scrapbook Retro Clock', 'images/products/p46_2.webp', 46),
       (110, 'Scrapbook Vintage', 'images/products/p47.webp', 47),
       (111, 'Scrapbook Vintage', 'images/products/p47_1.webp', 47),
       (112, 'Scrapbook Lò Xo Handmade Phong Cách Retro Độc Đáo', 'images/products/p48.webp', 48),
       (113, 'Scrapbook Lò Xo Handmade Phong Cách Retro Độc Đáo', 'images/products/p48_1.webp', 48),
       (114, 'Scrapbook Lò Xo Handmade Phong Cách Retro Độc Đáo', 'images/products/p48_2.webp', 48),
       (115, 'Album ảnh handmade Blue Pastel', 'images/products/p49.webp', 49),
       (116, 'Album ảnh handmade Blue Pastel', 'images/products/p49_1.webp', 49),
       (117, 'Album ảnh handmade Blue Pastel', 'images/products/p49_2.webp', 49),
       (118, 'Scrapbook My Boy For The Memories', 'images/products/p50.webp', 50),
       (119, 'Scrapbook My Boy For The Memories', 'images/products/p50_1.webp', 50),
       (120, 'Scrapbook My Boy For The Memories', 'images/products/p50_2.webp', 50),
       (121, 'Scrapbook Lò Xo Handmade Trang Trí Độc Lạ', 'images/products/p51.webp', 51),
       (122, 'Scrapbook Lò Xo Handmade Trang Trí Độc Lạ', 'images/products/p51_1.webp', 51),
       (123, 'Scrapbook Lò Xo Handmade Trang Trí Độc Lạ', 'images/products/p51_2.webp', 51),
       (124, 'Scrapbook Film de Paris', 'images/products/p52.webp', 52),
       (125, 'Scrapbook Film de Paris', 'images/products/p52_1.webp', 52),
       (126, 'Scrapbook Film de Paris', 'images/products/p52_2.webp', 52),
       (127, 'Scrapbook handmade Sweet Moments', 'images/products/p53.webp', 53),
       (128, 'Scrapbook handmade Sweet Moments', 'images/products/p53_1.webp', 53),
       (129, 'Scrapbook handmade Sweet Moments', 'images/products/p53_2.webp', 53),
       (130, 'SCRAPBOOK CHỦ ĐỀ CHO BÉ', 'images/products/p54.webp', 54),
       (131, 'SCRAPBOOK CHỦ ĐỀ CHO BÉ', 'images/products/p54_1.webp', 54),
       (132, 'SCRAPBOOK CHỦ ĐỀ CHO BÉ', 'images/products/p54_2.webp', 54),
       (133, 'Fly album handmade bicycle', 'images/products/p55.webp', 55),
       (134, 'Fly album handmade bicycle', 'images/products/p55_1.webp', 55),
       (135, 'Fly album handmade bicycle', 'images/products/p55_2.webp', 55),
       (136, 'Fly album handmade Blue Pastel', 'images/products/p56.webp', 56),
       (137, 'Fly album handmade Blue Pastel', 'images/products/p56_1.webp', 56),
       (138, 'Fly album handmade Blue Pastel', 'images/products/p56_2.webp', 56),
       (139, 'Fly album Love (Xanh)', 'images/products/p57.webp', 57),
       (140, 'Fly album Love (Xanh)', 'images/products/p57_1.webp', 57),
       (141, 'Fly album Love (Xanh)', 'images/products/p57_2.webp', 57),
       (142, 'Fly album Sweet Moment', 'images/products/p58.webp', 58),
       (143, 'Fly album Sweet Moment', 'images/products/p58_1.webp', 58),
       (144, 'Fly album Retro Clock', 'images/products/p59.webp', 59),
       (145, 'Fly album Retro Clock', 'images/products/p59_1.webp', 59),
       (146, 'Scrapbook độc đáo cho tình yêu THE JOURNEY OF LOVE', 'images/products/p60.webp', 60),
       (147, 'Scrapbook độc đáo cho tình yêu THE JOURNEY OF LOVE', 'images/products/p60_1.webp', 60),
       (148, 'Scrapbook độc đáo cho tình yêu THE JOURNEY OF LOVE', 'images/products/p60_2.webp', 60),
       (149, 'Album DIY Retro Clock', 'images/products/p61.webp', 61),
       (150, 'Album DIY Retro Clock', 'images/products/p61_1.webp', 61),
       (151, 'Album DIY Retro Clock', 'images/products/p61_2.webp', 61),
       (152, 'Scrapbook LIVE,LAUGH,LOVE', 'images/products/p62.webp', 62),
       (153, 'Scrapbook LIVE,LAUGH,LOVE', 'images/products/p62_1.webp', 62),
       (154, 'Scrapbook LIVE,LAUGH,LOVE', 'images/products/p62_2.webp', 62),
       (155, 'Scrapbook Were Growing', 'images/products/p63.webp', 63),
       (156, 'Scrapbook Were Growing', 'images/products/p63_1.webp', 63),
       (157, 'Scrapbook Were Growing', 'images/products/p63_2.webp', 63),
       (158, 'Scrapbook JUST BE ME', 'images/products/p64.webp', 64),
       (159, 'Scrapbook JUST BE ME', 'images/products/p64_1.webp', 64),
       (160, 'SCRAPBOOK CHỦ ĐỀ TÌNH YÊU', 'images/products/p65.webp', 65),
       (161, 'SCRAPBOOK CHỦ ĐỀ TÌNH YÊU', 'images/products/p65_1.webp', 65),
       (162, 'Scrapbook MY LITTLE PRINCESS', 'images/products/p66.webp', 66),
       (163, 'Scrapbook MY LITTLE PRINCESS', 'images/products/p66_1.webp', 66),
       (164, 'Scrapbook MY LITTLE PRINCESS', 'images/products/p66_2.webp', 66),
       (165, 'Album handmade bé trai MY LITTLE PRINCE', 'images/products/p67.webp', 67),
       (166, 'Album ảnh bé trai Wonderful My boy', 'images/products/p68.webp', 68),
       (167, 'Album ảnh bé trai Wonderful My boy', 'images/products/p68_1.webp', 68),
       (168, 'Scrapbook cao cấp My little princess', 'images/products/p69.webp', 69),
       (169, 'Scrapbook cao cấp My little princess', 'images/products/p69_1.webp', 69),
       (170, 'Scrapbook handmade Darling Daughter', 'images/products/p70.webp', 70),
       (171, 'Scrapbook handmade Darling Daughter', 'images/products/p70_1.webp', 70),
       (172, 'Scrapbook cao cấp I am marvelous', 'images/products/p71.webp', 71),
       (173, 'Scrapbook cao cấp My boy', 'images/products/p72.webp', 72),
       (174, 'Album cưới handmade Beautiful In White', 'images/products/p73.webp', 73),
       (175, 'Album cưới handmade Beautiful In White', 'images/products/p73_1.webp', 73),
       (176, 'Album handmade scrapbook đẹp Together Forever', 'images/products/p74.webp', 74),
       (177, 'Album handmade scrapbook đẹp Together Forever', 'images/products/p74_1.webp', 74),
       (178, 'Album handmade scrapbook đẹp Together Forever', 'images/products/p74_2.webp', 74),
       (179, 'Scrapbook cao cấp Were growing', 'images/products/p75.webp', 75),
       (180, 'Scrapbook cao cấp Were growing', 'images/products/p75_1.webp', 75),
       (181, 'Scrapbook cao cấp Were growing', 'images/products/p75_2.webp', 75),
       (182, 'Album ảnh handmade I am Marvelous', 'images/products/p76.webp', 76),
       (183, 'Album ảnh handmade I am Marvelous', 'images/products/p76_1.webp', 76),
       (184, 'Album ảnh handmade I am Marvelous', 'images/products/p76_2.webp', 76),
       (185, 'Flying album handmade Love Story', 'images/products/p77.webp', 77),
       (186, 'Flying album handmade Love Story', 'images/products/p77_1.webp', 77),
       (187, 'Flying album handmade Love Story', 'images/products/p77_2.webp', 77),
       (188, 'Flying album handmade Somewhere in time', 'images/products/p78.webp', 78),
       (189, 'Flying album handmade Somewhere in time', 'images/products/p78_1.webp', 78),
       (190, 'Flying album handmade Somewhere in time', 'images/products/p78_2.webp', 78),
       (191, 'Flying album handmade A Moment in Time', 'images/products/p79.webp', 79),
       (192, 'Flying album handmade A Moment in Time', 'images/products/p79_1.webp', 79),
       (193, 'Flying album handmade A Moment in Time', 'images/products/p79_2.webp', 79),
       (194, 'Flying album vintage Memories', 'images/products/p80.webp', 80),
       (195, 'Flying album vintage Memories', 'images/products/p80_1.webp', 80),
       (196, 'Flying album vintage Memories', 'images/products/p80_2.webp', 80),
       (197, 'Sổ ký tên đám cưới handmade', 'images/products/p81.webp', 81),
       (198, 'Sổ ký tên đám cưới handmade', 'images/products/p81_1.webp', 81),
       (199, 'Sổ ký tên đám cưới handmade', 'images/products/p81_2.webp', 81),
       (200, 'Exploding love box album handmade', 'images/products/p82.webp', 82),
       (201, 'Exploding love box album handmade', 'images/products/p82_1.webp', 82),
       (202, 'Exploding love box album handmade', 'images/products/p82_2.webp', 82),
       (203, 'Mini Love Card-Album Handmade', 'images/products/p83.webp', 83),
       (204, 'Mini Love Card-Album Handmade', 'images/products/p83_1.webp', 83),
       (205, 'Mini Love Card-Album Handmade', 'images/products/p83_2.jpg', 83),
       (206, 'ALBUM TỰ TRANG TRÍ (P,I) - SCRAPBOOK', 'images/products/p84.webp', 84),
       (207, 'ALBUM TỰ TRANG TRÍ (P,II) - ALBUM DIY', 'images/products/p85.webp', 85),
       (208, 'ALBUM TỰ TRANG TRÍ (P,II) - ALBUM DIY', 'images/products/p85_1.webp', 85),
       (209, 'Album tự trang trí Vân gỗ trắng', 'images/products/p86.webp', 86),
       (210, 'Album tự trang trí Vân gỗ trắng', 'images/products/p86_1.webp', 86),
       (211, 'Album tự trang trí Vân gỗ trắng', 'images/products/p86_2.webp', 86),
       (212, 'Album DIY Vân gỗ Đỏ', 'images/products/p87.webp', 87),
       (213, 'Album DIY Vân gỗ Đỏ', 'images/products/p87_1.webp', 87),
       (214, 'Album DIY Vân gỗ Đỏ', 'images/products/p87_2.webp', 87),
       (215, 'Album DIY Vân gỗ Pastel', 'images/products/p88.webp', 88),
       (216, 'Album DIY Vân gỗ Pastel', 'images/products/p88_1.webp', 88),
       (217, 'Album DIY Vân gỗ Pastel', 'images/products/p88_2.webp', 88),
       (218, 'Album DIY Sọc nhỏ', 'images/products/p89.webp', 89),
       (219, 'Album DIY Sọc nhỏ', 'images/products/p89_1.webp', 89),
       (220, 'Album DIY Sọc nhỏ', 'images/products/p89_2.webp', 89),
       (221, 'Scrapbook handmade FOLIO', 'images/products/p90.webp', 90),
       (222, 'Scrapbook handmade FOLIO', 'images/products/p90_1.webp', 90),
       (223, 'Scrapbook handmade FOLIO', 'images/products/p90_2.webp', 90),
       (224, 'Sổ ký tên handmade Save the date', 'images/products/p91.webp', 91),
       (225, 'Sổ ký tên handmade Save the date', 'images/products/p91_1.webp', 91),
       (226, 'Sổ ký tên handmade Save the date', 'images/products/p91_2.webp', 91),
       (227, 'Sổ ký tên Our Story', 'images/products/p92.webp', 92),
       (228, 'Sổ ký tên Our Story', 'images/products/p92_1.webp', 92),
       (229, 'Sổ ký tên Our Story', 'images/products/p92_2.webp', 92),
       (230, 'Sổ ký tên ngày cưới Let me love you', 'images/products/p93.webp', 93),
       (231, 'Sổ ký tên ngày cưới Let me love you', 'images/products/p93_1.webp', 93),
       (232, 'Sổ ký tên Happy Light', 'images/products/p94.webp', 94),
       (233, 'Sổ ký tên Happy Light', 'images/products/p94_1.webp', 94),
       (234, 'Sổ ký tên Happy Light', 'images/products/p94_2.webp', 94),
       (235, 'Sổ ký tên Happy Forest', 'images/products/p95.webp', 95),
       (236, 'Sổ ký tên Tiny Love', 'images/products/p96.webp', 96),
       (237, 'Sổ ký tên Tiny Love', 'images/products/p96_1.webp', 96),
       (238, 'Album tự thiết kế Baby photo GIRL (27cm*27cm)', 'images/products/p97.webp', 97),
       (239, 'Album tự thiết kế Baby photo GIRL (27cm*27cm)', 'images/products/p97_1.webp', 97),
       (240, 'Album tự thiết kế Baby photo GIRL (27cm*27cm)', 'images/products/p97_2.webp', 97),
       (241, 'Guest Book Feeling good', 'images/products/p98.webp', 98),
       (242, 'Guest Book Feeling good', 'images/products/p98_1.webp', 98),
       (243, 'Guestbook - sổ ký tên đám cưới Memory Book', 'images/products/p99.webp', 99),
       (244, 'Guestbook - sổ ký tên đám cưới Memory Book', 'images/products/p99_1.webp', 99),
       (245, 'Album DIY gáy lò xo tiện dụng Paris Je Táime', 'images/products/p100.webp', 100),
       (246, 'Album DIY gáy lò xo tiện dụng Paris Je Táime', 'images/products/p100_1.webp', 100),
       (247, 'Album DIY gáy lò xo tiện dụng Paris Je Táime', 'images/products/p100_2.webp', 100),
       (248, 'Bình cắm hoa LYO', 'images/products/p101.webp', 101),
       (249, 'Bình cắm hoa LYO', 'images/products/p101_1.webp', 101),
       (250, 'Bình cắm hoa LYO', 'images/products/p101_2.webp', 101),
       (251, 'Bình sứ trang trí Vintage', 'images/products/p102.webp', 102),
       (252, 'Bình sứ trang trí Vintage', 'images/products/p102_1.webp', 102),
       (253, 'Bình sứ trang trí Vintage', 'images/products/p102_2.webp', 102),
       (254, 'Bình cắm hoa trang trí dây thừng', 'images/products/p103.webp', 103),
       (255, 'Bình cắm hoa trang trí dây thừng', 'images/products/p103_1.webp', 103),
       (256, 'Bình cắm hoa trang trí dây thừng', 'images/products/p103_2.webp', 103),
       (257, 'Chai thủy tinh quấn thừng lớ', 'images/products/p104.webp', 104),
       (258, 'Chai thủy tinh quấn thừng lớ', 'images/products/p104_1.webp', 104),
       (259, 'Chai thủy tinh quấn thừng lớ', 'images/products/p104_2.webp', 104),
       (260, 'Bình gốm cao giả cổ hoa văn vintage', 'images/products/p105.webp', 105),
       (261, 'Bình gốm cao giả cổ hoa văn vintage', 'images/products/p105_1.webp', 105),
       (262, 'Bình gốm cao giả cổ hoa văn vintage', 'images/products/p105_2.webp', 105),
       (263, 'Khay sứ giả cổ', 'images/products/p106.webp', 106),
       (264, 'Khay sứ giả cổ', 'images/products/p106_1.webp', 106),
       (265, 'Khay sứ giả cổ', 'images/products/p106_2.webp', 106),
       (266, 'Giá để rượu vang gốm giả cổ', 'images/products/p107.webp', 107),
       (267, 'Giá để rượu vang gốm giả cổ', 'images/products/p107_1.webp', 107),
       (268, 'Giá để rượu vang gốm giả cổ', 'images/products/p107_2.webp', 107),
       (269, 'Đế để rượu Nhân Sư Ai Cập', 'images/products/p108.webp', 108),
       (270, 'Đế để rượu Nhân Sư Ai Cập', 'images/products/p108_1.webp', 108),
       (271, 'Đế để rượu Nhân Sư Ai Cập', 'images/products/p108_2.webp', 108),
       (272, 'Giá rượu Mèo Thần Ai Cập', 'images/products/p109.webp', 109),
       (273, 'Giá rượu Mèo Thần Ai Cập', 'images/products/p109_1.webp', 109),
       (274, 'Bình sứ Le Jardinier', 'images/products/p110.webp', 110),
       (275, 'Bình sứ Le Jardinier', 'images/products/p110_1.webp', 110),
       (276, 'Cốc vintage', 'images/products/p111.webp', 111),
       (277, 'Cốc vintage', 'images/products/p111_1.webp', 111),
       (278, 'Cốc vintage', 'images/products/p111_2.webp', 111),
       (279, 'Ly sứ vintage phong cảnh châu Âu', 'images/products/p112.webp', 112),
       (280, 'Ly sứ vintage phong cảnh châu Âu', 'images/products/p112_1.webp', 112),
       (281, 'Ly sứ vintage phong cảnh châu Âu', 'images/products/p112_2.webp', 112),
       (282, 'Bình sứ xinh xắn Dream House', 'images/products/p113.webp', 113),
       (283, 'Bình sứ xinh xắn Dream House', 'images/products/p113_1.webp', 113),
       (284, 'Bình sứ xinh xắn Dream House', 'images/products/p113_2.webp', 113),
       (285, 'Ly sứ starbucks coffee', 'images/products/p114.webp', 114),
       (286, 'Ly sứ starbucks coffee', 'images/products/p114_1.webp', 114),
       (287, 'Ly sứ starbucks coffee', 'images/products/p114_2.webp', 114),
       (288, 'Ly sứ vintage street', 'images/products/p115.webp', 115),
       (289, 'Ly sứ vintage street', 'images/products/p115_1.webp', 115),
       (290, 'Ly sứ vintage street', 'images/products/p115_2.webp', 115),
       (291, 'Bình hoa gốm trắng GRID', 'images/products/p116.webp', 116),
       (292, 'Bình hoa gốm trắng GRID', 'images/products/p116_1.webp', 116),
       (293, 'Bình hoa gốm trắng GRID', 'images/products/p116_2.webp', 116),
       (294, 'Bình hoa gốm giả cổ trang trí nâu cao cổ trò', 'images/products/p117.webp', 117),
       (295, 'Bình hoa gốm giả cổ trang trí nâu cao cổ trò', 'images/products/p117_1.webp', 117),
       (296, 'Bình hoa gốm giả cổ trang trí nâu cao cổ trò', 'images/products/p117_2.webp', 117),
       (297, 'Bình sứ giả cổ Victoria', 'images/products/p118.webp', 118),
       (298, 'Bình sứ giả cổ Victoria', 'images/products/p118_1.webp', 118),
       (299, 'Hộp đựng bút R102', 'images/products/p119.jpg', 119),
       (300, 'Hộp đựng bút R102', 'images/products/p119_1.jpg', 119),
       (301, 'Hộp đựng bút R102', 'images/products/p119_2.jpg', 119),
       (302, 'Mèo thần tài R104', 'images/products/p120.jpg', 120),
       (303, 'Mèo thần tài R104', 'images/products/p120_1.jpg', 120),
       (304, 'Mèo thần tài R104', 'images/products/p120_2.jpg', 120),
       (305, 'Tượng Hươu trang trí R103', 'images/products/p121.jpg', 121),
       (306, 'Tượng Hươu trang trí R103', 'images/products/p121_1.jpg', 121),
       (307, 'Tượng Hươu trang trí R103', 'images/products/p121_2.jpg', 121),
       (308, 'Xe máy mô hình trang trí R101', 'images/products/p122.jpg', 122),
       (309, 'Xe máy mô hình trang trí R101', 'images/products/p122_1.jpg', 122),
       (310, 'Xe máy mô hình trang trí R101', 'images/products/p122_2.jpg', 122),
       (311, 'Đèn bão trang trí Vintage', 'images/products/p123.webp', 123),
       (312, 'Đèn bão trang trí Vintage', 'images/products/p123_1.webp', 123),
       (313, 'Đèn bão trang trí Vintage', 'images/products/p123_2.webp', 123),
       (314, 'Móc treo nữ trang vintage', 'images/products/p124.webp', 124),
       (315, 'Móc treo nữ trang vintage', 'images/products/p124_1.webp', 124),
       (316, 'Lọ hoa thủy tinh handmade', 'images/products/p125.webp', 125),
       (317, 'Lọ hoa thủy tinh handmade', 'images/products/p125_1.webp', 125),
       (318, 'Hoa lavender oải hương handmade trang trí nhà cửa', 'images/products/p126.webp', 126),
       (319, 'Hoa lavender oải hương handmade trang trí nhà cửa', 'images/products/p126_1.webp', 126),
       (320, 'Hoa lavender oải hương handmade trang trí nhà cửa', 'images/products/p126_2.webp', 126),
       (321, 'Hoa chậu handmade - Hoa hồng giấy', 'images/products/p127.webp', 127),
       (322, 'Hoa chậu handmade - Hoa hồng giấy', 'images/products/p127_1.webp', 127),
       (323, 'Hoa chậu handmade - Hoa hồng giấy', 'images/products/p127_2.webp', 127),
       (324, 'Hộp nhạc piano pha lê khắc tê', 'images/products/p128.webp', 128),
       (325, 'Hộp nhạc piano pha lê khắc tê', 'images/products/p128_1.webp', 128),
       (326, 'Hộp nhạc piano pha lê khắc tê', 'images/products/p128_2.webp', 128),
       (327, 'Hộp nhạc gỗ Piano', 'images/products/p129.webp', 129),
       (328, 'Hộp nhạc gỗ Piano', 'images/products/p129_1.webp', 129),
       (329, 'Hộp nhạc gỗ Piano', 'images/products/p129_2.webp', 129),
       (330, 'Hộp nhạc cổ điển camera', 'images/products/p130.webp', 130),
       (331, 'Hộp nhạc cổ điển camera', 'images/products/p130_1.webp', 130),
       (332, 'Hộp nhạc cổ điển camera', 'images/products/p130_2.webp', 130),
       (333, 'Tượng trang trí phòng khách Thinker', 'images/products/p131.webp', 131),
       (334, 'Tượng trang trí phòng khách Thinker', 'images/products/p131_1.webp', 131),
       (335, 'Tượng trang trí phòng khách Thinker', 'images/products/p131_2.webp', 131),
       (336, 'Tượng trang trí vintage không thấy - không nghe -không nói', 'images/products/p132.webp', 132),
       (337, 'Tượng trang trí vintage không thấy - không nghe -không nói', 'images/products/p132_1.webp', 132),
       (338, 'Tượng trang trí vintage không thấy - không nghe -không nói', 'images/products/p132_2.webp', 132),
       (339, 'Xe Vespa mô hình trang trí, phụ kiện chụp ảnh', 'images/products/p133.webp', 133),
       (340, 'Xe Vespa mô hình trang trí, phụ kiện chụp ảnh', 'images/products/p133_1.webp', 133),
       (341, 'Xe Vespa mô hình trang trí, phụ kiện chụp ảnh', 'images/products/p133_2.webp', 133),
       (342, 'Thuyền gỗ vintage decor trang trí, phụ kiện chụp ảnh', 'images/products/p134.webp', 134),
       (343, 'Thuyền gỗ vintage decor trang trí, phụ kiện chụp ảnh', 'images/products/p134_1.webp', 134),
       (344, 'Thuyền gỗ vintage decor trang trí, phụ kiện chụp ảnh', 'images/products/p134_2.webp', 134),
       (345, 'Logo', 'images/logo.png', NULL),
       (346, 'Background', 'images/background.jpg', NULL);

INSERT INTO `order` (`id`, `totalPrice`, `orderDate`, `status`, `address`, `shippingFee`, `userId`)
VALUES (1, 218000.00, '2023-11-29 00:00:00', 'Thành công', '29 Tô Vĩnh Diện , Đông Hòa ,Dĩ An , Bình Dương', 30.00, 1),
       (2, 1235000.00, '2023-11-29 00:00:00', 'Đang giao',
        '416 Phạm Văn Đồng, Phường 11, Bình Thạnh, Thành phố Hồ Chí Minh', 30.00, 3),
       (3, 649000.00, '2023-11-30 00:00:00', 'Đang giao', '312 Trường Chinh, Nhơn Hưng, An Nhơn, Bình Định', 40.00, 2),
       (4, 349000.00, '2023-11-30 00:00:00', 'Thành công', '32 Đ, Mạc Đĩnh Chi, Đa Kao, Quận 1, Thành phố Hồ Chí Minh',
        30.00, 4),
       (5, 117000.00, '2023-11-30 00:00:00', 'Đang giao',
        '312 Đường Võ Nguyên Giáp, Thiện Nghiệp, Thành phố Phan Thiết, Bình Thuận', 40.00, 5),
       (6, 780000.00, '2023-11-30 00:00:00', 'Thành công', '31 Trần Phú, P, Mộ Lao, Hà Đông, Hà Nội', 50.00, 6),
       (7, 240000.00, '2023-12-01 00:00:00', 'Đang giao', '29 Tô Vĩnh Diện , Đông Hòa ,Dĩ An , Bình Dương', 30.00, 1),
       (8, 649000.00, '2023-12-01 00:00:00', 'Thành công', '15 Trường Chinh, Phước Trung, Bà Rịa, Bà Rịa - Vũng Tàu',
        30.00, 8),
       (9, 404000.00, '2023-12-01 00:00:00', 'Thành công', '21 Võ Trường Toản, An Phú, Quận 2, Thành phố Hồ Chí Minh',
        30.00, 7),
       (10, 322000.00, '2023-12-01 00:00:00', 'Chờ xác nhận', '314 Âu Cơ, TT, Tân Châu, Tân Châu, An Giang', 30.00, 9),
       (11, 78000.00, '2023-12-02 00:00:00', 'Thành công', '31 Trần Phú, P, Mộ Lao, Hà Đông, Hà Nội', 50.00, 6),
       (12, 117000.00, '2023-12-02 00:00:00', 'Đã hủy', '18 Phan Văn Trị, Khuê Trung, Cẩm Lệ, Đà Nẵng', 40.00, 10),
       (13, 1103000.00, '2023-12-02 00:00:00', 'Chờ xác nhận', '312 Trường Chinh, Nhơn Hưng, An Nhơn, Bình Định', 40.00,
        2),
       (14, 104000.00, '2023-12-02 00:00:00', 'Chờ xác nhận',
        '416 Phạm Văn Đồng, Phường 11, Bình Thạnh, Thành phố Hồ Chí Minh', 30.00, 3);

INSERT INTO `order_details` (`orderId`, `productId`, `quantity`, `sellingPrice`, `finalSellingPrice`)
VALUES (1, 1, 2, 3000.0, 3000.0),
       (1, 7, 2, 50000.0, 50000.0),
       (2, 12, 1, 39000.0, 39000.0),
       (2, 14, 1, 30000.0, 30000.0),
       (2, 118, 1, 395000.0, 395000.0),
       (3, 122, 1, 135000.0, 135000.0);

INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `soldout`, `categoryId`,
                       `discountId`, `isSale`)
VALUES (1, 'Thiệp handmade vintage Beauty & the White',
        'Kích thước lớn hơn thông thường: 11x18cm, gồm bì thư, giấy viết thông điệp và thiệp;\nChủ đề có sẵn: chúc mừng sinh nhật, valentine, 8/3, 20/10, 20/11;\nLiên lạc ngay với Craft & More Vietnam nếu bạn muốn làm thiệp theo chủ đề riêng;\nThiệp làm handmade tỉ mỉ với vật liệu giấy cứng, giấy mỹ thuật, hoa lá cỏ khô,,, rất thân thiện môi trường;\nTùy biến kích thước, câu chữ, logo cho nhóm, công ty, đoàn thể,,,\nLưu ý: Thiệp được làm thủ công-handmade với các vật liệu hoa, lá, cỏ, giấy,,, nên các chi tiết có thể khác đôi chút cho từng sản phẩm nhưng phong cách (concept) luôn thống nhất theo các mẫu,',
        50000.00, 70000.00, 35, 0, 1, NULL, 1),
       (2, 'Thiệp handmade Film de Paris',
        'Mẫu thiệp chúc mừng FILM de PARIS đậm chất retro, vintage hoài cổ;\nKích thước lớn hơn thông thường: 11x18cm, gồm bì thư, giấy viết thông điệp và thiệp;\nChủ đề có sẵn: chúc mừng sinh nhật, valentine, 8/3, 20/10, 20/11;\nLiên lạc ngay với Craft & More Vietnam nếu bạn muốn làm thiệp theo chủ đề riêng;\nThiệp làm handmade tỉ mỉ với vật liệu giấy cứng, giấy mỹ thuật, hoa lá cỏ khô,,, rất thân thiện môi trường;\nTùy biến kích thước, câu chữ, logo cho nhóm, công ty, đoàn thể,,,\nLưu ý: Thiệp được làm thủ công-handmade với các vật liệu hoa, lá, cỏ, giấy,,, nên các chi tiết có thể khác đôi chút cho từng sản phẩm nhưng phong cách (concept) luôn thống nhất theo các mẫu,',
        55000.00, 70000.00, 21, 0, 1, NULL, 1),
       (3, 'Thiệp chúc mừng Sweet Mint',
        'Mẫu thiệp SWEET MINT - ngọt ngào như viên kẹo bạc hà! \nKích thước lớn hơn thông thường: 11x18cm, gồm bì thư, giấy viết thông điệp và thiệp; \nChủ đề có sẵn: chúc mừng sinh nhật, valentine, 8/3, 20/10, 20/11; \nLiên lạc ngay với Craft & More Vietnam nếu bạn muốn làm thiệp theo chủ đề riêng; \nThiệp làm handmade tỉ mỉ với vật liệu giấy cứng, giấy mỹ thuật, hoa lá cỏ khô,,, rất thân thiện môi trường; \nTùy biến kích thước, câu chữ, logo cho nhóm, công ty, đoàn thể,,, \nLưu ý: Thiệp được làm thủ công-handmade với các vật liệu hoa, lá, cỏ, giấy,,, nên các chi tiết có thể khác đôi chút cho từng sản phẩm nhưng phong cách (concept) luôn thống nhất theo các mẫu,',
        50000.00, 70000.00, 24, 0, 1, NULL, 1),
       (4, 'Thiệp chúc mừng Black & White',
        'Trắng - đen luôn có nét đẹp riêng, mẫu thiệp mang đậm phong cách vintage, hoài cổ & màu sắc tối giản nhưng cá tính với nền là giấy kraft cứng đen kết hợp die cut được sắp xếp hài hòa,\nKích thước: 11x14cm,\nGồm bì thư, giấy viết thông điệp và thiệp,\nThiệp được làm handmade tỉ mỉ, chỉn chu,\nThiệp phù hợp với nhiều dịp tặng 14/2 Valentine, 8/3, 20/10, 20/11, Noel Giáng Sinh,,,',
        24000.00, 39000.00, 15, 0, 1, NULL, 1),
       (5, 'Thiệp handmade Amazing Carto',
        'Mẫu thiệp AMAZING CARTON cảm hứng từ những tấm bìa cứng thô ráp! \nKích thước: 9x14cm; \nChủ đề có sẵn: chúc mừng sinh nhật, valentine, 8/3, 20/10, 20/11; \nLiên lạc ngay với Craft & More Vietnam nếu bạn muốn làm thiệp theo chủ đề riêng; \nThiệp làm handmade tỉ mỉ với vật liệu giấy cứng, giấy mỹ thuật, hoa lá cỏ khô,,, rất thân thiện môi trường; \nTùy biến kích thước, câu chữ, logo cho nhóm, công ty, đoàn thể,,, \nLưu ý: Thiệp được làm thủ công-handmade với các vật liệu hoa, lá, cỏ, giấy,,, nên các chi tiết có thể khác đôi chút cho từng sản phẩm nhưng phong cách (concept) luôn thống nhất theo các mẫu,',
        24000.00, 39000.00, 5, 0, 1, NULL, 1),
       (6, 'Thiệp handmade lớn Beauty & the White',
        'Kích thước 11x18cm \nChất liệu giấy mỹ thuật cao cấp \nChủ đề đa dạng, tùy biến \nPhù hợp với hầu hết các đối tượng, các dịp như 8/3, 20/10, 20/11, sinh nhật, chúc mừng,,,',
        50000.00, 70000.00, 13, 0, 1, NULL, 1),
       (7, 'Thiệp da bò độc đáo',
        'Kích thước: 10x13,5cm \n\n- Chất liệu da bò chọn lọc, charm đồng, giấy dó \n\n- Tùy biến theo ý riêng: theo mục đích tặng (sinh nhật, 20/11, 20/10, 8/3, valentine 14/2, giáng sinh v,v,,,) hoặc thay đổi hoàn toàn thông điệp theo ý riêng,',
        30000.00, 50000.00, 19, 0, 1, NULL, 1),
       (8, 'Thiệp dấu sáp mini',
        'Thiệp mini đơn giản nhưng đẹp! \n\nThiệp làm & đóng sáp thủ công handmade; \n\nKích thước 6x9cm, gồm giấy viết thông điệp bên trong thiệp; \n\nVật liệu: giấy craft, sáp đóng dấu, dây thừng, giấy mỹ thuật',
        7000.00, 19000.00, 40, 0, 1, NULL, 1),
       (9, 'Thiệp handmade Vintage Film',
        'Kích thước: 10x14,5cm \n\n- Chất liệu giấy mỹ thuật đặc biệt, charm đồng \n\n- Sản phẩm gồm thiệp, tấm giấy ghi thông điệp, bì thư vintage \n\n- Tùy biến theo ý riêng: theo mục đích tặng (sinh nhật, 20/11, 20/10, 8/3, valentine 14/2, giáng sinh v,v,,,) hoặc thay đổi hoàn toàn thông điệp theo ý riêng,',
        15000.00, 39000.00, 50, 0, 1, NULL, 1),
       (10, 'Thiệp handmade vintage vải bố',
        '- Kích thước: 10x14,5cm \n\n- Chất liệu vải bố nâu, charm đồng, giấy dó \n\n- Tùy biến theo ý riêng: theo mục đích tặng (sinh nhật, 20/11, 20/10, 8/3, valentine 14/2, giáng sinh v,v,,,) hoặc thay đổi hoàn toàn thông điệp theo ý riêng,',
        18500.00, 39000.00, 34, 0, 1, NULL, 1),
       (11, 'Thiệp gỗ Jigsaws',
        'Khắc thông điệp theo ý riêng \n\n- Kích thước: 10x14,5cm \n\n- Chất liệu gỗ polywood \n\n- Sản phẩm gồm thiệp, tấm giấy ghi thông điệp, bì thư vintage \n\n- Tùy biến theo ý riêng: theo mục đích tặng (sinh nhật, 20/11, 20/10, 8/3, valentine 14/2, giáng sinh v,v,,,) hoặc thay đổi hoàn toàn thông điệp theo ý riêng,',
        20100.00, 39000.00, 49, 0, 1, NULL, 1),
       (12, 'Thiệp gỗ Other Half',
        '- Kích thước: 10x14,5cm \n\n- Chất liệu gỗ polywood \n\n- Sản phẩm gồm thiệp, tấm giấy ghi thông điệp, bì thư vintage \n\n- Tùy biến theo ý riêng: theo mục đích tặng (sinh nhật, 20/10, 8/3, valentine 14/2, giáng sinh, annivesary,,,) hoặc thay đổi hoàn toàn thông điệp theo ý riêng,',
        17800.00, 39000.00, 40, 0, 1, NULL, 1),
       (13, 'Thiệp chúc mừng handmade Blue Pastel',
        '- Kích thước: 10x14,5cm \n\n- Chất liệu giấy mỹ thuật đặc biệt, charm đồng \n\n- Sản phẩm gồm thiệp, tấm giấy ghi thông điệp, bì thư vintage \n\n- Tùy biến theo ý riêng: theo mục đích tặng (sinh nhật, 20/11, 20/10, 8/3, valentine 14/2, giáng sinh v,v,,,) hoặc thay đổi hoàn toàn thông điệp theo ý riêng,',
        23000.00, 39000.00, 37, 0, 1, NULL, 1),
       (14, 'Thiệp vintage Retro Clock',
        '- Kích thước: 10x14,5cm \n\n- Chất liệu giấy mỹ thuật đặc biệt, charm đồng \n\n- Sản phẩm gồm thiệp, tấm giấy ghi thông điệp, bì thư vintage \n\n- Tùy biến theo ý riêng: theo mục đích tặng (sinh nhật, 20/11, 20/10, 8/3, valentine 14/2, giáng sinh v,v,,,) hoặc thay đổi hoàn toàn thông điệp theo ý riêng,',
        17000.00, 30000.00, 25, 0, 1, NULL, 1),
       (15, 'Thiệp giấy carton handmade - Thiệp chúc mừng sinh nhật',
        'Thiệp làm handmade tỉ mỉ lấy cảm hứng từ những tấm carton thô ráp, kết hợp với hoa lá cỏ khô tạo thành mẫu thiệp đẹp, độc đáo, \n\nCó thể thay đổi chủ đề theo yêu cầu, \n\nKích thước: 11x14cm,',
        28900.00, 49000.00, 19, 0, 1, NULL, 1),
       (16, 'Thiệp tặng bạn thân - Thiệp vintage retro',
        'Thiệp tặng bạn thân - Thiệp vintage retro Là một trong những mẫu thiệp handmade cổ điển, HeadQuarter giúp bạn trở về lại với những giá trị tinh thần mà nhiều khi sống giữa thời đại công nghệ chúng,,,',
        16500.00, 49000.00, 11, 0, 1, NULL, 1),
       (17, 'Giấy viết thư cổ điển Vintage',
        '- Giấy viết thư cổ điển hoa văn vintage Mang dáng dấp cổ điển độc đáo, những tờ giấy viết thư đầy cảm xúc sẽ là của bạn với những thiết kế độc đáo, cổ điển Vintage lạ mắt, Giấy viết thư,,,',
        17900.00, 35000.00, 34, 0, 1, NULL, 1),
       (18, 'Khung ảnh đẹp Frame Triple',
        'Bộ khung ảnh ba đẹp Bộ ba khung ảnh thiết kế với gỗ mộc mạc, mang phong cách Vintage độc đáo, thiết kế bộ ba, sử dụng trang trí được cả hai mặt tương đương với 6 bức hình, Khung ảnh bộ,,,',
        145000.00, 377000.00, 20, 0, 1, NULL, 1),
       (19, 'Khung ảnh frame 6 in 1',
        'Khung ảnh frame gỗ trang trí Cực xinh xắn và tiện dụng với bộ khung ảnh frame theo phong cách Vintage ấn tượng: + Bộ sản phẩm tiện dụng với bộ khung gỗ, gắn móc khóa, đồng hồ và khung ảnh kích thước 53,,,',
        950000.00, 1337000.00, 10, 0, 1, NULL, 1),
       (20, 'Khung ảnh gỗ 3 in 1',
        'Thiết kế cực sang trọng với màu trắng làm chủ đạo, phù hợp với mọi không gian trong căn nhà bạn', 475000.00,
        630000.00, 10, 0, 1, NULL, 1),
       (21, 'Khung ảnh, tủ móc khóa, móc treo 3 in 1', 'Kích thước: 21x28cm; \nChất liệu: gỗ;', 134000.00, 347000.00, 0,
        0, 1, NULL, 1),
       (22, 'Khung hình vintage triple cỡ lớ',
        'Kích thước khung 57x31cm; cỡ hình 10x15cm; trọng lượng 1,38kg; \nChất liệu: gỗ, thiết kế hoài cổ, vintage, cá tính,',
        376000.00, 519000.00, 6, 0, 1, NULL, 1),
       (23, 'Khung ảnh handmade - thiệp handmade đẹp 2 in 1',
        'Sản phẩm được thiết kế cá tính và đậm chất Vintage cổ xưa sẽ là sản phẩm độc đáo dành cho bạn có nhu cầu lưu giữ những tấm ảnh \"hay ho\" hay ghi lại khoảnh khắc đáng nhớ, Bạn có thể dán hình hoặc câu chữ yêu thích đặt vào khung hình,',
        13000.00, 29000.00, 0, 0, 1, NULL, 1),
       (24, 'Khung ảnh kiểu Địa Trung Hải',
        'Mang nắng, gió và biển Địa Trung Hải vào thiết kế không gian của bạn đơn giản chỉ với chiếc khung ảnh này, Kích thước: 19 x 23cm; Chất liệu: gỗ thông đẹp và bền bỉ,',
        106000.00, 189000.00, 24, 0, 1, NULL, 1),
       (25, 'Khung ảnh vintage kiểu US Army',
        'Bằng chất liệu kim loại, gỗ cùng một chút sáng tạo, khung ảnh US Army sẽ là điểm nhấn cho không gian thêm phần khác lạ, Kích thước khung 1 x 23 x 28cm; cỡ hình 10 x 15cm;',
        98000.00, 167000.00, 21, 0, 1, NULL, 1),
       (26, 'Khung ảnh vintage trắng ngà',
        'Khung hình thiết kế đơn giản, đẹp, tinh tế, nhẹ nhàng với tông màu trắng, Kích thước lần lượt cho các khổ ảnh 9x9cm giá 105k; 9x13cm giá 162k; 10x15cm giá 173k; 13x18cm giá 197k,',
        88000.00, 97000.00, 16, 0, 1, NULL, 1),
       (27, 'Khung ảnh - móc treo FISH HOOK',
        'Kích thước: 55x4x20cm; \nChất liệu: gỗ, dây thừng \nKhung 3 ảnh 6x9cm được làm thủ công tỉ mỉ', 204000.00,
        379000.00, 0, 0, 1, NULL, 1),
       (28, 'Khung ảnh gỗ và thạch cao Ivory Vintage',
        'Khung ảnh gỗ và thạch cao Ivory Vintage ấn tượng Chất liệu gỗ và thạch cao hòa quyện cùng sự sáng tạo độc đáo đã cho ra đời sản phẩm khung ảnh độc đáo Ivory Vintage, Kích thước sản phẩm: 4 x,,,',
        219000.00, 349000.00, 5, 0, 1, NULL, 1),
       (29, 'Khung ảnh Hải Âu Mediterranea', 'Chất liệu: gỗ; \nKích thước khung 18x23cm; khổ hình 10x15cm;', 101000.00,
        189000.00, 1, 0, 1, NULL, 1),
       (30, 'Khung ảnh Địa Trung Hải Kayak',
        'Thiết kế thuyền kayak độc đáo, hiện đại và khác biệt, chiếc khung ảnh Địa Trung Hải này như một chút biến tấu cho không gian của bạn thêm sự mới lạ, Kích thước sản phẩm: 15 x 26cm, được làm bằng chất liệu: gỗ, thừng, thạch cao, sò biển,,,',
        96000.00, 167000.00, 0, 0, 1, NULL, 1),
       (31, 'Khung ảnh vintage hoa văn vuông',
        'Cổ điển và ấn tượng, chiếc khung ảnh Vintage mang hơi thở hoài cổ nhẹ nhàng và ấn tượng, Chất liệu: gỗ, kích thước khung 18 x 22cm; cỡ hình 10 x 15cm,',
        104000.00, 150000.00, 0, 0, 1, NULL, 1),
       (32, 'Khung ảnh mèo Totoro',
        'Khung ảnh mèo Totoro Mang nét mộc mạc đơn sơ nhưng cực kì xinh xắn, với khung ảnh mèo Totoro, sự đơn giản từ chiếc khung ảnh có thể làm nổi bật lên tấm hình mà bạn muốn trưng cho không,,,',
        65000.00, 84000.00, 3, 0, 1, NULL, 1),
       (33, 'Khung ảnh Staring time (lớn)',
        'Khung ảnh gỗ đẹp Staring time Không chỉ là chiếc khung ảnh gỗ, mà nó còn là kỉ vật thời gian gắn bó với rất nhiều người, do đó, một chiếc khung ảnh luôn là món đồ vật được trân trọng,,,,',
        145000.00, 212000.00, 2, 0, 1, NULL, 1),
       (34, 'Khung ảnh gỗ thông Rustic',
        'Khung ảnh Rustic cỡ lớn Những điều ý nghĩa, những kỷ niệm đẹp hãy lưu lại và trân trọng điều đó bởi đó là những điều sẽ đi suốt cuộc đời của bạn, Chính vì thể hãy giữ cho những bức,,,',
        179000.00, 227000.00, 15, 0, 1, NULL, 1),
       (35, 'Khung ảnh Hải Âu Mediterranea',
        'Quà tặng khung ảnh Hải Âu Mediterranean Chất liệu: gỗ; Kích thước khung 18x23cm; khổ hình 10x15cm; Like FACEBOOK VIETGIFTCENTER,COM để được cập nhật nhanh nhất!',
        125000.00, 189000.00, 13, 0, 1, NULL, 1),
       (36, 'Khung trang trí bàn hoa hồng sứ C-rose frame',
        'Phong cách \"mộc\" ấn tượng cho khung trang trí để bàn C-rose, Ngoài việc trang trí, khung trang trí còn là điểm nhấn phong thủy độc đáo cho nội thất của bạn, Khung trang trí để bàn hoa hồng Kích thước:13,9 x,,,',
        241000.00, 317000.00, 18, 0, 1, NULL, 1),
       (37, 'KHUNG ẢNH NGÔI NHÀ CỬA SỔ NÂU (NGANG)', 'KÍCH THƯỚC: 24,5 * 20,5cm \nChất liệu: Gỗ', 178000.00, 240000.00,
        4, 0, 1, NULL, 1),
       (38, 'KHUNG ẢNH NGÔI NHÀ XE ĐẠP', 'KÍCH THƯỚC: 19*26,5cm \nChất liệu: Gỗ', 178000.00, 240000.00, 1, 0, 1, NULL,
        1),
       (39, 'KHUNG ẢNH VÒNG ĐU QUAY VINTAGE',
        'Khung ảnh vòng đu quay vintage 2 \nKích thước: 33 x 18,5 cm \nChất liệu: kim loại', 175000.00, 189000.00, 0, 0,
        1, NULL, 1),
       (40, 'Bì thư vintage Tem Việt',
        'BÌ THƯ VINTAGE CỔ ĐIỂN Bao thư với phong cách vintage thích hợp cho bạn nếu yêu thích những phong cách retro đặc biệt ấn tượng này, Bạn có thể sử dụng để làm quà tặng hoặc để trang trí đều,,,',
        19000.00, 35000.00, 12, 0, 1, NULL, 1),
       (41, 'Scrapbook That Time',
        '- Kích thước 21x21x5cm; \n\n- Trang trí được 30-50 ảnh đủ các kích thước 4x6cm đến 13x18cm; \n\n- Sản phẩm được làm thủ công, chăm chút từng chi tiết nhỏ; scrapbook có phong cách, màu sắc đậm chất vintage, hoài cổ rất được yêu thích; \n\n- Scrapbook có thể thiết kế, tùy biến chủ đề theo ý riêng,',
        450000.00, 649000.00, 10, 0, 2, NULL, 1),
       (42, 'Scrapbook Sweet Mint',
        '- Kích thước 21x21x5cm \n\n- Trang trí được 30-50 ảnh đủ các kích thước 4x6cm đến 13x18cm \n\n- Sản phẩm được làm thủ công, chăm chút từng chi tiết nhỏ \n\n- Scrapbook có thể thiết kế, tùy biến chủ đề theo ý riêng',
        450000.00, 649000.00, 8, 0, 2, NULL, 1),
       (43, 'Scrapbook Fly That Time',
        '- Kích thước 14,5 x 21,5 x 5cm \n\n- Trang trí được 30 ảnh 6x9cm \n\n- Sản phẩm được làm handmade tỉ mỉ từng chi tiết nhỏ',
        104000.00, 329.00, 13, 0, 2, NULL, 1),
       (44, 'Album ảnh handmade Fly Sweet Mint',
        '- Sản phẩm được làm handmade chăm chút tỉ mỉ \n\n- Kích thước 14,5 x 21,5 x 5cm \n\n- Trang trí được 30 hình 6x9cm \n\n- Có thể tùy biến, thiết kế chủ đề theo yêu cầu riêng',
        104000.00, 329000.00, 16, 0, 2, NULL, 1),
       (45, 'Album ảnh tự trang trí Love Story (Xanh)',
        'Màu xanh Vintage huyền bí cùng thiết kế theo phong cách Vintage đầy bí ẩn sẽ làm cuốn album của bạn thêm thu hút và độc đáo,',
        147000.00, 220000.00, 24, 0, 2, NULL, 1),
       (46, 'Scrapbook Retro Clock',
        '- Màu sắc: Nâu - trắng, \n\n- Kích thước: 20 x 20cm, \n\n- Chất liệu: Giấy cứng cao cấp, được trang trí hoàn toàn bằng tay (100% handmade), \n\n- Số trang: 11, có thể dán được 40-60 hình các size khác nhau,',
        402000.00, 649000.00, 1, 0, 2, NULL, 1),
       (47, 'Scrapbook Vintage',
        'Scrapbook handmade cao cấp đậm chất vintage Just be me Quyển scrapbook (một dạng sổ ảnh handmade) được làm thủ công với thiết kế hoàn toàn khác biệt, chắc chắn, chứa được nhiều hình hơn so với các scrapbook khác, Màu,,,',
        1350000.00, 1620000.00, 4, 0, 2, NULL, 1),
       (48, 'Scrapbook Lò Xo Handmade Phong Cách Retro Độc Đáo',
        '✔ Kích thước: 20 x 21cm \n\n️ ✔ Các size ảnh: 4x6, 6x9, 9x12 \n\n️ ✔ 16 trang giấy cứng và các họa tiết trang trí ấn tượng, \n\n️ ✔ Tối đa 47 tấm hình, Có nhiều lớp được xếp chồng lên nhau và kéo thả để hiển thị hình ảnh,',
        400000.00, 549000.00, 9, 0, 2, NULL, 1),
       (49, 'Album ảnh handmade Blue Pastel',
        'Màu sắc chủ đạo: Trắng - Xanh Rustic/Pastel nhẹ nhàng, \n\n- Kích thước: 20 x 20cm, \n\n- Chất liệu: Giấy cứng cao cấp, được trang trí hoàn toàn bằng tay (100% handmade), \n\n- Số trang: 11, có thể dán được 40-60 hình các size khác nhau,',
        400000.00, 649000.00, 14, 0, 2, NULL, 1),
       (50, 'Scrapbook My Boy For The Memories',
        'Scrapbook thường được xem là món quà đặc biệt không chỉ với thiết kế mà còn giá trị của tinh thần lẫn vật chất của nó, Sản phẩm thành công và được nhiều người yêu thích vì những ý nghĩa,,,',
        400000.00, 549000.00, 14, 0, 2, NULL, 1),
       (51, 'Scrapbook Lò Xo Handmade Trang Trí Độc Lạ',
        '- Kích thước: 9,5 x 21cm\n\n- Các size ảnh phù hợp: 4x6, 6x9, 9x12\n\n- Giấy cứng và các họa tiết trang trí ấn tượng,\n\n- Tối đa 47 tấm hình, Có nhiều lớp được xếp chồng lên nhau và kéo thả để hình ảnh vô cùng độc lạ,',
        400000.00, 549000.00, 14, 0, 2, NULL, 1),
       (52, 'Scrapbook Film de Paris',
        'Scrapbook handmade Film de Paris độc đáo và ấn tượng với phiên bản Blue siêu quyến rũ, Scrapbook dùng làm album ảnh lưu trữ những kỉ niệm đẹp, - Kích thước: 21 x 21cm - Có thể trang trí 50 hình lớn nhỏ - Chất liệu:,,,',
        450000.00, 649000.00, 16, 0, 2, NULL, 1),
       (53, 'Scrapbook handmade Sweet Moments',
        '- Màu sắc: vàng lúa mạch,\n\n- Kích thước: 20 x 20cm,\n\n- Chất liệu: Giấy cứng cao cấp, được trang trí hoàn toàn bằng tay (100% handmade),\n\n- Số trang: 11, có thể dán được 40-60 hình các size khác nhau,',
        450000.00, 649000.00, 12, 0, 2, NULL, 1),
       (54, 'SCRAPBOOK CHỦ ĐỀ CHO BÉ',
        'Scrapbook chủ đề cho bé trai và bé gái Bạn băn khoăn về việc lưu giữ hình ảnh của bé con sao cho vừa đẹp, vừa ý nghĩa, dễ thương mà vẫn độc đáo và khác biệt, Bạn không chỉ muốn đơn thuần,,,',
        500000.00, 629000.00, 8, 0, 2, NULL, 1),
       (55, 'Fly album handmade bicycle',
        'Fly album handmade bicycle Chất liệu: giấy cứng cao cấp; Làm bằng tay hoàn toàn (100% handmade); Kích thước: 14,5*21,5 cm; Số trang: 14, Dán được được 30 hình khổ 6x9 cm, Like Fanpage vietgiftcenter,com để được hỗ trợ thông tin nhanh nhất,',
        210000.00, 329000.00, 9, 0, 2, NULL, 1),
       (56, 'Fly album handmade Blue Pastel',
        '- Chất liệu: giấy cứng cao cấp; \n- Làm bằng tay hoàn toàn (100% handmade); \n- Kích thước: 14 cm*23 cm; \n- Số trang: 15, Dán được được 32 hình khổ 6 x 9cm,',
        210000.00, 329000.00, 20, 0, 2, NULL, 1),
       (57, 'Fly album Love (Xanh)',
        'Phiên bản độc quyền mang phong cách riêng của Craft & More, Mang màu sắc cùng thiết kế bí ẩn, fly album handmade Love có thể trang trí trên bàn làm việc, bàn học, không gian, Sản phẩm có hộp đựng vô cùng xinh xắn,',
        210000.00, 329000.00, 17, 0, 2, NULL, 1),
       (58, 'Fly album Sweet Moment',
        'Nếu fly album Anchor với tông màu hồng xin xắn dành riêng cho mùa xuân thì fly album Sweet Moment lại khơi gợi nét nhẹ nhàng, lãng đãng của mùa thu dịu dàng, Sản phẩm vừa là cuốn album ảnh \"độc\", vừa là vật trang trí cực lãng mạn cho không gian,',
        210000.00, 329000.00, 6, 0, 2, NULL, 1),
       (59, 'Fly album Retro Clock',
        '- Chất liệu: giấy cứng cao cấp; \n- Làm bằng tay hoàn toàn (100% handmade); \n- Kích thước: 14 cm*23 cm; \n- Số trang: 15, Dán được được 32 hình khổ 6 x 9cm,',
        210000.00, 329000.00, 11, 0, 2, NULL, 1),
       (60, 'Scrapbook độc đáo cho tình yêu THE JOURNEY OF LOVE',
        '- Màu sắc: Nâu trầm, \n\n- Kích thước: 21 x 21cm, gồm 11 trang giấy trang trí sẵn, \n\n- Sản phẩm mang thông điệp và màu sắc trung tính, có thể dùng làm quà tặng, album trang trí cho cả nam lẫn nữ, \n\n- Sản phẩm có 2 mẫu khác nhau, Vui lòng chọn mẫu khi đặt hàng,',
        400000.00, 649000.00, 9, 0, 2, NULL, 1),
       (61, 'Album DIY Retro Clock',
        'Thiết kế mang dáng vẻ cổ điển cùng lối trang trí đơn giản nhưng mang lại nét sang trọng, nhẹ nhàng cùng chi tiết bánh răng, đồng hồ, poscard,,,,',
        145000.00, 222000.00, 0, 0, 2, NULL, 1),
       (62, 'Scrapbook LIVE,LAUGH,LOVE',
        'Scrapbook với chất liệu giấy cứng, khổ: 20*20 cm; có thể trang trí khoảng 50 hình lớn nhỏ,', 400000.00,
        649000.00, 38, 0, 2, NULL, 1),
       (63, 'Scrapbook Were Growing',
        'Quà handmade cho bé, cho tuổi trẻ - scrapbook Were Growing - Sweet Laughing Album ảnh handmade có thiết kế ấn tượng tông màu nâu mang nét hoài cổ cá tính, Album phù hợp ghi dấu những chặng đường phát triển,,,',
        550000.00, 699000.00, 25, 0, 2, NULL, 1),
       (64, 'Scrapbook JUST BE ME',
        'Scrapbook JUST BE ME Album ảnh có kích thước: 20x20cm; dán được 30-40 ảnh, Scrapbook được thiết kế ấn tượng theo phong cách VINTAGE, RETRO, Bạn có thể thêm bớt giấy tùy theo số lượng hình, Album được tặng thêm một số phụ,,,',
        500000.00, 679000.00, 19, 0, 2, NULL, 1),
       (65, 'SCRAPBOOK CHỦ ĐỀ TÌNH YÊU',
        'Để giúp bạn dễ dàng hơn trong việc lựa chọn, ở bài viết này, Craft & More sẽ giới thiệu đến bạn một số mẫu Scrapbook theo chủ đề Tình yêu, Click vào tên sản phẩm để biết thêm nhiều thông,,,',
        400000.00, 649000.00, 24, 0, 2, NULL, 1),
       (66, 'Scrapbook MY LITTLE PRINCESS',
        'Scrapbook độc đáo cho bé yêu - bé gái: MY LITTLE PRINCESS Album ảnh handmade có kích thước: 21*21 cm; giấy cao cấp, dán được khoảng trên 50 hình lớn nhỏ, Album được trang trí sẵn rất cá tính nhưng dịu dàng với tông màu hồng,,,',
        400000.00, 649000.00, 35, 0, 2, NULL, 1),
       (67, 'Album handmade bé trai MY LITTLE PRINCE',
        'Scrapbook bé trai MY LITTLE PRINCE Album ảnh handmade dành riêng cho bé trai, tông màu xanh mạnh mẽ, cá tính - món quà độc đáo cho chàng hoàng tử bé của bạn; khổ: 21*21 cm; dán được 50 hình, Album làm,,,',
        400000.00, 649000.00, 32, 0, 2, NULL, 1),
       (68, 'Album ảnh bé trai Wonderful My boy',
        'Scrapbook cho bé trai WONDERFUL - MY BOY Album ảnh handmade cho bé trai đậm chất vintage, là dạng kết hợp trang trí sẵn và tự làm (DIY): bìa và 3 trang bên trong trang trí sẵn; các trang còn lại trống (blank) để,,,',
        500000.00, 679000.00, 15, 0, 2, NULL, 1),
       (69, 'Scrapbook cao cấp My little princess',
        'Scrapbook handmade cao cấp My little princess Album được bằng tay với nhiều chi tiết tinh xảo, Scrapbook có thể dán hơn 150 hình với khích thước khác nhau, Kích thước: 20x20cm, Like Facebook của chúng tôi để được cập nhật nhanh nhất thông,,,',
        1400000.00, 1620000.00, 6, 0, 2, NULL, 1),
       (70, 'Scrapbook handmade Darling Daughter',
        '- Chất liệu: giấy cứng cao cấp; \n- Khổ: 20*20 cm; \n- Album gáy còng, có thể dễ dàng thêm bớt trang tùy thích, Sản phẩm có thể đựng được 50-60 hình lớn nhỏ,',
        500000.00, 679000.00, 4, 0, 2, NULL, 1),
       (71, 'Scrapbook cao cấp I am marvelous',
        'Scrapbook cao cấp I am marvelous Album đươc làm hoàn toàn bằng tay tỉ mỉ, chất liệu giấy mỹ thuật cao cấp; kích thước: 20x20cm, Like Facebook của chúng tôi ngay các bạn nhé!',
        1400000.00, 1620000.00, 22, 0, 2, NULL, 1),
       (72, 'Scrapbook cao cấp My boy',
        'Scrapbook handmade cao cấp My boy Album được làm hoàn toàn bằng tay rất tỉ mỉ, Kích thước: 20x20cm; Scrapbook có thể dán được hơn 150 hình với khích thước khác nhau, Chất liệu: giấy mỹ thuật cao cấp, Like ngay Facebook,,,',
        1400000.00, 1620000.00, 21, 0, 2, NULL, 1),
       (73, 'Album cưới handmade Beautiful In White',
        'Album cưới handmade - scrapbook chủ đề TÌNH YÊU Beautiful In White Album handmade Beautiful in White đúng như tên gọi, được thiết kế thanh thoát, giản dị, lãng mạn với tông trắng chủ đạo, Các trang nền bên trong có hoa văn,,,,',
        400000.00, 649000.00, 19, 0, 2, NULL, 1),
       (74, 'Album handmade scrapbook đẹp Together Forever',
        'Album handmade scrapbook đẹp Together Forever Làm bằng tay hoàn toàn, tĩ mĩ từng chi tiết nhỏ nhất! 20 trang giấy chuyên dụng được trang trí đặc sắc; Chủ đề tình yêu: TOGETHER FOREVER; Chứa khoảng,,,',
        520000.00, 729000.00, 18, 0, 2, NULL, 1),
       (75, 'Scrapbook cao cấp Were growing',
        'Scrapbook cao cấp làm album ảnh đẹp cho bé và gia đình Sự ra đời của cuốn album scrapbook cao cấp Were growing là một sự đột phá trong cách trang trí, lưu giữ kỉ niệm bằng album, Bằng những trang giấy nghệ,,,',
        1400000.00, 1620000.00, 0, 0, 2, NULL, 1),
       (76, 'Album ảnh handmade I am Marvelous',
        'Lưu giữ những khoảnh khắc đáng nhớ bằng scrapbook I am Marvelous Scrapbook I am Marvelous sẽ là nơi lý tưởng để bạn có thể lưu giữ những kỉ niệm hạnh phúc và đáng nhớ bên gia đình của mình, Những tấm hình,,,',
        500000.00, 679000.00, 12, 0, 2, NULL, 1),
       (77, 'Flying album handmade Love Story',
        'Album ảnh handmade có thể kéo dài -flying album Chất liệu: giấy cứng cao cấp; Làm bằng tay hoàn toàn (100% handmade); Kích thước: 14,5*21,5 cm; Số trang: 14, đựng được 30 hình khổ 6*9 cm và 1 hình 9*12cm Like facebook Craft & More để,,,',
        210000.00, 329000.00, 20, 0, 2, NULL, 1),
       (78, 'Flying album handmade Somewhere in time',
        'Flying album handmade tỉ mỉ Chất liệu: giấy cứng cao cấp; Làm bằng tay hoàn toàn (100% handmade); Kích thước: 14,5*21,5 cm; Số trang: 14, đựng được 30 hình khổ 6*9 cm và 1 hình 9x12cm, Món quà tặng độc đáo cho những người yêu,,,',
        210000.00, 329000.00, 20, 0, 2, NULL, 1),
       (79, 'Flying album handmade A Moment in Time',
        'Món quà tặng độc đáo cho những người yêu thương, hay cho chính bạn!', 210000.00, 329000.00, 20, 0, 2, NULL, 1),
       (80, 'Flying album vintage Memories',
        'Album ảnh bay handmade (flying album) Memories Chất liệu: giấy cứng cao cấp; Làm bằng tay hoàn toàn (100% handmade); Kích thước: 14,5*21,5 cm; Số trang: 14, đựng được 30 hình khổ 6*9 cm và 1 hình 9*12cm,',
        210000.00, 329000.00, 25, 0, 2, NULL, 1),
       (81, 'Sổ ký tên đám cưới handmade',
        'Sổ ký tên đám cưới handmade phong cách vintage Album cưới handmade dùng để ký tên và dán hình trang trí tiệc cưới được làm bằng tay hoàn toàn, Sổ có tối thiểu 3 trang hình và 3 trang ký tên, chứa khoảng 10-15 hình;',
        970000.00, 1129000.00, 34, 0, 2, NULL, 1),
       (82, 'Exploding love box album handmade',
        'Chất liệu: Giấy cứng hoa văn cao cấp \n\nKích thước: 9 x 13cm, cao 6cm, chứa được khoảng 29 tấm hình 6 x 9cm,',
        310000.00, 449000.00, 0, 0, 2, NULL, 1),
       (83, 'Mini Love Card-Album Handmade',
        'Chất liệu: giấy cứng cao cấp; bền bỉ theo thời gian \nKích thước: 7,5*12 cm; \nChủ đề đa dạng, được thiết kế và thực hiện tại HeadQuarter',
        56000.00, 109000.00, 14, 0, 2, NULL, 1),
       (84, 'ALBUM TỰ TRANG TRÍ (P,I) - SCRAPBOOK',
        'Khác với 5-10 năm trước đây, làm album handmade không chỉ là một phạm trù xa lạ mà còn khá khó khăn cho người làm bởi sự hạn chế về nguồn cung cấp và nơi bán các loại nguyên vật liệu,,,,',
        500000.00, 679000.00, 31, 0, 2, NULL, 1),
       (85, 'ALBUM TỰ TRANG TRÍ (P,II) - ALBUM DIY',
        'Bài trước, chúng ta đã tìm hiểu qua Scrapbook, bài tiếp theo này Craft & More xin giới thiệu tiếp đến Album ảnh DIY Album DIY (DO IT YOURSELF) Album DIY vượt trội hơn Scrapbook về số lượng ảnh được lưu trữ,,,,',
        145000.00, 220000.00, 30, 0, 2, NULL, 1),
       (86, 'Album tự trang trí Vân gỗ trắng',
        'Album thiết kế tối giản với màu sơn trắng Vintage cổ điển, họa tiết dấu mộc cổ độc đáo như một nét chấm phá hoàn hảo cho cuốn album ảnh lưu bút độc đáo của bản thân,',
        140000.00, 220000.00, 30, 0, 2, NULL, 1),
       (87, 'Album DIY Vân gỗ Đỏ',
        'Màu sắc chủ đạo: Nâu, vàng, đỏ được phối hợp khéo léo theo phong cách Vintage tinh tế, Thiết kế không bao giờ lỗi thời, tối giản tới mức thấp nhất mọi nét trang trí cầu kì trên sản phẩm,',
        140000.00, 220000.00, 30, 0, 2, NULL, 1),
       (88, 'Album DIY Vân gỗ Pastel',
        'Màu chủ đạo: tông màu trắng + xanh Pastel dịu nhẹ, Thiết kế nhẹ nhàng và đầy ngẫu hứng, họa tiết vân gỗ quen thuộc nhưng vẫn gây cảm giác lạ mắt rất riêng cho sản phẩm,',
        140000.00, 220000.00, 30, 0, 2, NULL, 1),
       (89, 'Album DIY Sọc nhỏ',
        'Họa tiết sọc xinh xắn, nhẹ nhàng, album gồm 60 trang với 2 màu nâu - đen đơn giản, 100% trang giấy trống cho bạn thỏa sức sáng tạo,',
        140000.00, 220000.00, 19, 0, 2, NULL, 1),
       (90, 'Scrapbook handmade FOLIO',
        'Mẫu scrapbook đẹp với việc sắp xếp khéo léo nhiều tấm thẻ thành một quyển sổ ảnh, kết hợp việc phối màu sắc, hoa văn tạo nên tổng thể một quyển scrapbook handmade đậm chất retro, Scrapbook có kích thước A5,,,,',
        230000.00, 479000.00, 18, 0, 2, NULL, 1),
       (91, 'Sổ ký tên handmade Save the date',
        'Thiết kế sổ ký tên + album ảnh cưới 2 in 1, Sản phẩm được làm 100% bằng tay từ ý tưởng đến thiết kế, lấy ý tưởng từ chủ đề đại dương lãng mạn và dịu dàng, sổ ký tên Save the date chắc chắn sẽ làm bạn và người chiêm ngưỡng bất ngờ và thích thú,',
        1100000.00, 1380000.00, 20, 0, 2, NULL, 1),
       (92, 'Sổ ký tên Our Story',
        'Sản phẩm là sổ ký tên kết hợp album ảnh cưới cực độc đáo, Tông màu xanh, nâu trầm chủ đạo, họa tiết Vintage cuốn hút và quyến rũ, Cuốn sổ ký tên được thiết kế sang trọng và bắt mắt, ấn tượng như một câu chuyện cổ tích có thật!',
        1100000.00, 1380000.00, 20, 0, 2, NULL, 1),
       (93, 'Sổ ký tên ngày cưới Let me love you',
        'Sổ ký tên đám cưới mua ở đâu? Khổ 31x31cm; 24 trang luôn bìa; các họa tiết vẽ tay artline in trên giấy mỹ thuật Tinki 250 gsm kết hợp làm album ảnh handmade độc đáo! Guestbook - sổ ký tên với,,,',
        180000.00, 319000.00, 0, 0, 2, NULL, 1),
       (94, 'Sổ ký tên Happy Light',
        'Sổ ký tên Happy Light Kích thước: 31x31cm Định lượng giấy 250gsm Số trang: 20 trang', 180000.00, 319000.00, 1,
        0, 2, NULL, 1),
       (95, 'Sổ ký tên Happy Forest',
        'Guestbook Happy Forest Định lượng giấy: 250gsm Số trang: 20 trang Kích thước 31x31cm', 180000.00, 319000.00, 1,
        0, 2, NULL, 1),
       (96, 'Sổ ký tên Tiny Love',
        'Guestbook Tiny Love Kích thước: 31cm x 31cm Định lượng giấy: 250gsm Số lượng trang: 20 trang', 180000.00,
        319000.00, 5, 0, 2, NULL, 1),
       (97, 'Album tự thiết kế Baby photo GIRL (27cm*27cm)',
        'Album tự thiết kế Baby photo màu hồng-món quà cho các bé gái và gia đình tại vietgiftcenter,com Khổ vuông 27cm*27cm, 64 trang luôn bìa, giấy bên trong 2 màu đen,',
        176000.00, 280000.00, 16, 0, 2, NULL, 1),
       (98, 'Guest Book Feeling good',
        'Guest book-sổ kí tên Feeling good Kích thước: 31x31cm, định lượng giấy: 250gsm, số lượng trang: 20 trang,',
        180000.00, 319000.00, 16, 0, 2, NULL, 1),
       (99, 'Guestbook - sổ ký tên đám cưới Memory Book',
        'Guestbook - sổ ký tên đám cưới Khổ: 31x31cm; 24 trang luôn bìa, được thiết kế đặc biệt dành cho ký tên ngày cưới, Hoặc bạn có thể dùng làm album ảnh dán DIY, Bìa guestbook được thiết kế với tông màu,,,',
        180000.00, 319000.00, 19, 0, 2, NULL, 1),
       (100, 'Album DIY gáy lò xo tiện dụng Paris Je Táime',
        'Album tự trang trí gáy lò xo tiện dụng Paris Je Táime Kích thước vừa phải,tiện dụng: 17*18cm; Bìa giấy cứng cáp, 2 màu đen và nâu; có ruy băng vải buộc chắc chắn,,,',
        78000.00, 125000.00, 27, 0, 2, NULL, 1),
       (101, 'Bình cắm hoa LYO',
        'Bình cắm hoa LYON trang trí, Kích thước 12cm đường kính x 20cm cao, chất liệu: thiếc không gỉ', 350000.00,
        404000.00, 10, 0, 5, NULL, 1),
       (102, 'Bình sứ trang trí Vintage',
        'Bình sứ trang trí đẹp nhẹ nhàng phù hợp trang trí shop, studio, quán cafe, nhà hàng, phòng khách', 95000.00,
        163000.00, 10, 0, 5, NULL, 1),
       (103, 'Bình cắm hoa trang trí dây thừng',
        'Bình cắm hoa trang trí dây thừng\nkích thước: 14cm đường kính x 19,5cm cao\nChất liệu thiếc được sơn chống gỉ,',
        280000.00, 404000.00, 10, 0, 5, NULL, 1),
       (104, 'Chai thủy tinh quấn thừng lớ',
        'Chai (lọ) thủy tinh quấn thừng xinh xắn dùng cắm hoa cực đẹp Với chai thủy tinh, sợi thừng nhỏ, Cổ & Cũ đã giúp thổi hồn vào sản phẩm một cách tinh tế và điệu đà, sản phẩm \"chất\" và \"mộc\" một,,,',
        89000.00, 119000.00, 10, 0, 5, NULL, 1),
       (105, 'Bình gốm cao giả cổ hoa văn vintage',
        'Chất liệu: sứ; hoa văn vintage cổ điển;\nKích thước: chân bình 15,5 cm; miệng bình 26 cm; cao 28 cm,',
        320000.00, 545000.00, 10, 0, 5, NULL, 1),
       (106, 'Khay sứ giả cổ',
        'Chất liệu: sứ màu xanh ngọc; \nKích thước: cao 27cm, dài gồm tay cầm 43 cm, dài mặt trong khay 31cm, rộng 22cm, đường kính đáy khay 13cm,',
        690000.00, 924000.00, 7, 0, 5, NULL, 1),
       (107, 'Giá để rượu vang gốm giả cổ', 'Chất liệu: gốm; \nKích thước: 18x30cm,', 310000.00, 499000.00, 14, 0, 5,
        NULL, 1),
       (108, 'Đế để rượu Nhân Sư Ai Cập', 'Kích thước: 31x11x17cm; \nChất liệu: thạch cao, nhựa tổng hợp,', 340000.00,
        562000.00, 20, 0, 5, NULL, 1),
       (109, 'Giá rượu Mèo Thần Ai Cập', 'Kích thước: 23x26x10cm; \nChất liệu: thạch cao và nhựa tổng hợp,', 340000.00,
        562000.00, 20, 0, 5, NULL, 1),
       (110, 'Bình sứ Le Jardinier', 'Chất liệu gốm sứ \nKích thước: 12,5 x 5,3 x 6,5cm \nDùng trang trí, cắm hoa,,,,',
        23000.00, 52000.00, 35, 0, 5, NULL, 1),
       (111, 'Cốc vintage', 'Chất liệu; gốm sứ \nKích thước: 8,5cm x 7,7cm \nDung tích: 300ml', 45000.00, 69000.00, 0,
        0, 5, NULL, 1),
       (112, 'Ly sứ vintage phong cảnh châu Âu', 'Cao 11,5cm; Đường kính 8cm; dung tích 300ml,', 59000.00, 89000.00, 0,
        0, 5, NULL, 1),
       (113, 'Bình sứ xinh xắn Dream House', 'Dung tích: 200ml; \nKích thước: 8x10cm,', 70000.00, 105000.00, 0, 0, 5,
        NULL, 1),
       (114, 'Ly sứ starbucks coffee', 'Dung tích 300ml; \nLy cao 8,5cm; đường kính 7,5cm;', 23000.00, 45000.00, 0, 0,
        5, NULL, 1),
       (115, 'Ly sứ vintage street', 'Cao 9cm; đường kính 7cm; có nắp,', 84000.00, 115000.00, 12, 0, 5, NULL, 1),
       (116, 'Bình hoa gốm trắng GRID', 'Kích thước 20x25cm;', 395000.00, 532000.00, 15, 0, 5, NULL, 1),
       (117, 'Bình hoa gốm giả cổ trang trí nâu cao cổ trò', 'Kích thước: 17x38 cm;', 400000.00, 509000.00, 0, 0, 5,
        NULL, 1),
       (118, 'Bình sứ giả cổ Victoria',
        'Bình sứ trang trí đẹp nhẹ nhàng mang phong cách vintage phù hợp trang trí quán cafe, studio, shop,,,,',
        240000.00, 395000.00, 2, 0, 5, NULL, 1),
       (119, 'Hộp đựng bút R102',
        'kích thước :16,5x7x21 (cm) \n\nKích thước thuyền :21×4,5×16(cm) \n\nChất liệu : Sắt sơn tĩnh điện, chống rỉ sét, mài mòn, \n\nGiúp cho phòng làm việc trở nên gọn gàng, hiện đại hơn, từ đó mà không gian trở nên thoải mái, làm việc cũng hiệu quả hơn,',
        90000.00, 170000.00, 6, 0, 5, NULL, 1),
       (120, 'Mèo thần tài R104',
        'Mèo thần tài R104 với thiết kế góc cạnh hiện đại, được làm từ gốm sứ cao cấp, tráng men sáng bóng, màu sắc tươi tắn, sắc nét mang đến may mắn, bình an và tài lộc vô biên cho gia chủ, Mèo thần tài cũng rất phù hợp để làm quà tặng dịp mừng khai trương, tân gia, thăng quan tiến chức,…',
        290000.00, 400000.00, 20, 0, 5, NULL, 1),
       (121, 'Tượng Hươu trang trí R103',
        'Từ xa xưa, hình ảnh hươu nai trang trí đã được các tầng lớp quý tộc vô cùng ưa chuộng, Bởi họ quan niệm rằng, hươu nai biểu tượng cho sự sung túc và giàu có, Do hươu là loài vật sống rất lâu năm nên việc trưng bày hình ảnh của loài vật này còn mang ý nghĩa may mắn và trường thọ, Đặt tượng hươu trang trí trong nhà sẽ mang đến cho gia đình một cuộc sống bình an, mạnh khỏe, Đặc biệt, hỗ trợ cực tốt cho gia chủ trên con đường làm ăn kinh doanh, phát tài phát lộc, gặp nhiều may mắn và thuận lợi trong công việc,',
        550000.00, 649999.00, 19, 0, 5, NULL, 1),
       (122, 'Xe máy mô hình trang trí R101',
        'Kích thước :15 x 5,5 x 9,5 (cm) \n\nChất liệu : sắt phủ sơn tĩnh điện, chống rỉ sét, mài mòn, \n\nPhù hợp để trang trí bàn làm việc, văn phòng, Studio , giúp cho không gian thêm phần thanh lịch, hiện đại,',
        75000.00, 135000.00, 27, 0, 5, NULL, 1),
       (123, 'Đèn bão trang trí Vintage',
        'Đèn bão vintage trang trí nhà cửa Đèn bão được phủ một lớp sơn đồng, bạc đậm chất retro, Đèn bão thời trước đây dùng trong các trường hợp không có điện, ngày nay khi mọi thứ trở nên hiện đại,,,,',
        140000.00, 192000.00, 4, 0, 5, NULL, 1),
       (124, 'Móc treo nữ trang vintage', 'Kích thước: 25x16cm \nChất liệu: gỗ, kim loại', 100000.00, 152000.00,
        4, 0, 5, NULL, 1),
       (125, 'Lọ hoa thủy tinh handmade',
        'LỌ HOA THỦY TINH HANDMADE Được chăm chút tỉ mỉ từng cánh hoa, chậu hoa handmade thủy tinh sẽ là một món quà tặng xinh xắn hay làm căn phòng của bạn dễ thương hơn bao giờ hết, Lọ hoa thủy,,,',
        89000.00, 120000.00, 0, 0, 5, NULL, 1),
       (126, 'Hoa lavender oải hương handmade trang trí nhà cửa', 'Chất liệu foam, giấy, dây kẽm, \nMàu sắc đa dạng',
        15000.00, 35000.00, 0, 0, 5, NULL, 1),
       (127, 'Hoa chậu handmade - Hoa hồng giấy',
        'Hoa chậu handmade - Hoa hồng giấy Hoa handmade chậu thủy tinh quấn thừng nhỏ xinh, dễ thương khi sử dụng làm quà tặng, người nhận có thể dùng trang trí kệ, bàn, Ưu điểm của hoa handmade là hình thức đẹp không,,,',
        101000.00, 157000.00, 19, 0, 5, NULL, 1),
       (128, 'Hộp nhạc piano pha lê khắc tê',
        'Hộp nhạc dây cót piano pha lê khắc tên Thiết kế mới lạ, sang trọng, được làm từ nhựa trong acrylic bạn sẽ nhìn được chuyển động đang chạy trong hộp nhạc trông rất thú vị, Làm đồ decor trong nhà, bàn làm,,,',
        510000.00, 559000.00, 25, 0, 5, NULL, 1),
       (129, 'Hộp nhạc gỗ Piano', 'Màu sắc trắng, hồng \nKhắc tên laser', 510000.00, 559000.00, 33, 0, 5, NULL, 1),
       (130, 'Hộp nhạc cổ điển camera',
        'Kích thước:12x6x7,5cm \nChất liệu: gỗ \nThiết kế tỉ mỉ, khéo léo \nMẫu mã thịnh hành \nThích hợp làm quà tặng sinh nhật, valentine, noel, 8/3, 20/10,,,',
        220000.00, 250000.00, 14, 0, 5, NULL, 1),
       (131, 'Tượng trang trí phòng khách Thinker',
        'Chất liệu: đá sa thạch bền chắc, thân thiện với môi trường và an toàn với người sử dụng, \nKích thước: cao 23cm x ngang 12,5cm, \nMàu sắc: như hình, \nBảo quản: Không được rửa bằng nước hay bất kì dung dịch nào, Khi tượng bám bụi, hãy dùng khăn mềm lau nhẹ nhàng,',
        190000.00, 249000.00, 19, 0, 5, NULL, 1),
       (132, 'Tượng trang trí vintage không thấy - không nghe -không nói',
        'Kích thước 11x12 cao 32cm \nChất liệu : Đá Composite cao cấp \nMàu sắc giả đá tự nhiê', 260000.00, 406000.00,
        27, 0, 5, NULL, 1),
       (133, 'Xe Vespa mô hình trang trí, phụ kiện chụp ảnh',
        'Mô hình xe Vespa chất liệu kim loại \n\n- Kích thước 12x7,5cm, nhỏ xinh siêu cute \n\n- Xe Vespa trang trí, làm đồ decor sưu tập, phụ kiện chụp ảnh',
        108000.00, 152000.00, 19, 0, 5, NULL, 1),
       (134, 'Thuyền gỗ vintage decor trang trí, phụ kiện chụp ảnh',
        'Có 3 kích thước 27cm; 34cm và 42cm \nChất liệu gỗ theo phong cách Địa Trung Hải,', 88000.00, 149000.00, 16, 0,
        5, NULL, 1),
       (135, 'Vòng hoa Giáng sinh kim nỉ Holly',
        'Mỗi quả bóng và lá nhựa ruồi được nỉ riêng bằng 100% len với màu sắc Giáng sinh truyền thống \n\nVòng hoa dài 135cm và cụm lá nhựa ruồi ở giữa có kích thước khoảng, 11 x 11 cm',
        113000.00, 200000.00, 16, 0, 5, NULL, 1),
       (136, 'Cây thông Noel Macrame',
        'Tôi đã làm cây macrame này bằng dây bông màu xanh nhạt,\n\nNó được làm trên một chiếc nhẫn bằng đồng 25 mm và có thêm 10 hạt gỗ và một ngôi sao/bông tuyết bằng gỗ ở trên cùng,\n\nTổng số đo bao gồm vòng và tua là khoảng, 30cm x 11cm',
        113000.00, 200000.00, 0, 0, 5, NULL, 1);

INSERT INTO `rate` (`productId`, `userId`, `starRatings`, `comment`, `createDate`)
VALUES (2, 1, 4, 'Sản phẩm tốt', '2023-11-29 00:00:00'),
       (4, 1, 5, 'Thiếp đẹp mắt và rất phù hợp', '2023-12-03 00:00:00'),
       (7, 4, 5, 'Sản phẩm chất liệu tốt và rất đẹp', '2023-12-01 00:00:00'),
       (12, 5, 5, 'Khung ảnh đẹp và tốt lắm ! 10điểm cho shop', '2023-12-01 00:00:00'),
       (34, 3, 5, 'Sản phẩm quá đẹp rất hợp ý tôi!', '2023-11-29 00:00:00'),
       (101, 7, 3, 'Sản phẩm ổn không quá xuất sắc!', '2023-12-02 00:00:00'),
       (119, 9, 5, 'Không có gì để chê sản phẩm này !', '2023-12-03 00:00:00'),
       (124, 9, 5, 'Quá ưng ý với sản phẩm này!', '2023-12-03 00:00:00');

INSERT INTO `role` (`id`, `name`)
VALUES (0, 'admin'),
       (1, 'user');

INSERT INTO `tips` (`title`, `description`, `img_path`, `video_link`)
VALUES ('Cách cắm hoa khô đẹp trong 5 phút',
        'Hoa khô hay còn gọi là hoa không tàn, hoa vĩnh cửu luôn có nét đẹp riêng,\r\nĐể tăng thêm sự độc đáo và giá trị thì cách cắm hoa...',
        'images/banner_tip/tip_1.jpg',
        'https://youtu.be/t4Sjrj0MvUg'),
       ('Cách làm trang trí thiệp hoa khô handmade siêu dễ',
        'Thiệp hoa khô tự nhiên có nét quyến rũ thú vị, thể hiện sự chỉnh chu của người tặng,\r\nTự tay làm chiếc thiệp hoa khô sẽ thật ý nghĩa...',
        'images/banner_tip/tip_2.jpg',
        'https://youtu.be/eA_cUtEO6zA'),
       ('Hướng dẫn cách làm scrapbook album ảnh handmade',
        'Scrapbook là một dạng nhật ký ảnh, album hình được làm, trang trí thủ công có nội dung ,\r\ncâu chuyện hoàn chỉnh,Thời gian, sự kiện được ghi chú...',
        'images/banner_tip/tip_3.jpg',
        'https://youtu.be/U3kAyqvfWoc');

INSERT INTO `user` (`id`, `name`, `phoneNumber`, `email`, `password`, `createDate`, `status`, `roleId`)
VALUES (1, 'admin', '0865266994', 'handmadestore@gmail.com', 'j5Y57UE67Etm9o/3budppVPs26Y=', '2023-12-21 11:55:58',
        'Bình Thường', 0),
       (2, 'Nguyễn Trung Kiên', '0336677141', '	21130408@st.hcmuaf.edu.vn', 'j5Y57UE67Etm9o/3budppVPs26Y=',
        '2023-12-21 11:55:58',
        'Bình Thường', 1),
       (3, 'Nguyễn Trọng Nghĩa', '0336677141', 'NTN@st.hcmuaf.edu.vn', 'j5Y57UE67Etm9o/3budppVPs26Y=',
        '2023-12-21 11:55:58',
        'Bình Thường', 1),
       (4, 'Pblues', '0336677141', 'lungbaphe772003@gmail.com', 'j5Y57UE67Etm9o/3budppVPs26Y=', '2023-12-21 11:55:58',
        'Bình Thường', 0),

       (5, 'Giàng A Phò', '0383301249', 'gioaphang10@gmail.com', 'bzEG9mi+7P1TKsq8TWaJPvLB/rA=', '2023-12-21 11:57:42',
        'Bình Thường', 1),
       (6, 'Giàng A Lữ', '0383331294', 'alu122@gmail.com', 'tmJ8E7v+JZxOlCpaUDHANskmiFQ=', '2023-12-21 11:58:07',
        'Bình Thường', 1),
       (7, 'Cáp Tần', '0747712817', 'captanam12@gmail.com', 'FT2mYccNA0jxMv5hr7KHMPThfsk=', '2023-12-21 11:58:36',
        'Bình Thường', 1),
       (8, 'Nguyễn Thị Nghĩa', '0846992305', 'nghiarunner1@gmail.com', 'gkwSuLZQX5Uw2621/gVpx+MXpCo=',
        '2023-12-21 11:59:30', 'Bình Thường', 1),
       (9, 'Lê Ngọc Phụng', '0932100348', 'chanden12@gmail.com', 'YG1YVf8v5O2tVb8w6XgN9aFm/Jo=', '2023-12-21 12:00:08',
        'Bình Thường', 1),
       (10, 'Nguyễn Quang Hải', '0875244129', 'quanghai19@gmail.com', 'JxcrosuODLiKLbKuTAEOJuQrzTg=',
        '2023-12-21 12:00:49', 'Bình Thường', 1),
       (11, 'Phan Thanh Hòa', '0324712889', 'pdl199@gmail.com', 'PT/lnWok0bM7NAadn1sCWRqTjUg=', '2023-12-21 12:01:28',
        'Bình Thường', 1),
       (12, 'Tôn Ngộ Không', '0671821176', 'wukong99@gmail.com', 'HcAWujhP8PZAsYe/3icfc9N4b1s=', '2023-12-21 12:02:03',
        'Bình Thường', 1),
       (13, 'Đường Tăng Tạng', '0315821901', 'thinhkinh008@gmail.com', 'jHdhq9r1HYxgovt/ST+OaNAaF/w=',
        '2023-12-21 12:02:30', 'Bình Thường', 1),
       (14, 'Trư Bát Giới', '0871881103', 'packgioi77@gmail.com', 'SIBC9HV8hbf63+dVHRSjRaV+TWk=', '2023-12-21 12:03:06',
        'Bình Thường', 1),
       (15, 'Người Cồn', '0341007611', 'nguoicon88@gmail.com', 'En4OJjjx1rRcqPxSFAgmP4/82/w=', '2023-12-21 12:05:41',
        'Bình Thường', 1),
       (16, 'Nguyễn Khư', '0765 122 822', 'coko@gmail.com', 'bkB6UP/uoLhvBxphkqHaxgRUGxU=', '2023-12-25 00:04:10',
        'Bình Thường', 1),
       (17, 'Ngô Huy', '0756 788 192', 'huyngu92@go.vn', '3BMxq3cwKG/6fhkEG1SJMySX+58=', '2023-12-25 00:14:09',
        'Bình Thường', 1);

ALTER TABLE `banner_items`
    ADD PRIMARY KEY (`title`) USING BTREE;


ALTER TABLE `category`
    ADD PRIMARY KEY (`id`) USING BTREE;


ALTER TABLE `discount`
    ADD PRIMARY KEY (`id`) USING BTREE;


ALTER TABLE `image`
    ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `fk_image` (`productId`) USING BTREE;


ALTER TABLE `order`
    ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `fk_order` (`userId`) USING BTREE;


ALTER TABLE `order_details`
    ADD PRIMARY KEY (`orderId`, `productId`) USING BTREE,
  ADD KEY `fk_od2` (`productId`) USING BTREE;


ALTER TABLE `product`
    ADD PRIMARY KEY (`id`),
  ADD KEY `fk_discount` (`discountId`) USING BTREE;


ALTER TABLE `rate`
    ADD PRIMARY KEY (`productId`, `userId`) USING BTREE;

ALTER TABLE `role`
    ADD PRIMARY KEY (`id`);


ALTER TABLE `tips`
    ADD PRIMARY KEY (`title`) USING BTREE;

ALTER TABLE `user`
    ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `fkuser` (`roleId`) USING BTREE;



ALTER TABLE `category`
    MODIFY `id` int (11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;


ALTER TABLE `discount`
    MODIFY `id` int (11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;


ALTER TABLE `image`
    MODIFY `id` int (11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=347;


ALTER TABLE `order`
    MODIFY `id` int (11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

ALTER TABLE `product`
    MODIFY `id` int (11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=137;


ALTER TABLE `user`
    MODIFY `id` int (11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;


ALTER TABLE `image`
    ADD CONSTRAINT `fk_image` FOREIGN KEY (`productId`) REFERENCES `product` (`id`);


ALTER TABLE `order`
    ADD CONSTRAINT `fk_order` FOREIGN KEY (`userId`) REFERENCES `user` (`id`);


ALTER TABLE `order_details`
    ADD CONSTRAINT `fk_od1` FOREIGN KEY (`orderId`) REFERENCES `order` (`id`);
COMMIT;
