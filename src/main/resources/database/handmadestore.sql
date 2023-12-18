/* CREATE DATABASE */
CREATE
DATABASE handmadestore;
USE
handmadestore;
/* CREATE TABLES */
CREATE TABLE `handmadestore`.`category`
(
    `id`   varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

CREATE TABLE `handmadestore`.`discount`
(
    `id`            varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  NOT NULL,
    `name`          varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `startDate`     datetime NULL DEFAULT current_timestamp (),
    `endDate`       datetime NULL DEFAULT current_timestamp (),
    `percentageOff` decimal(10, 2) NULL DEFAULT 0.00,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;


CREATE TABLE `handmadestore`.`product`
(
    `id`           varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `name`         varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `description`  text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `costPrice`    decimal(10, 2)                                              NOT NULL,
    `sellingPrice` decimal(10, 2)                                              NOT NULL,
    `quantity`     int(11) NULL DEFAULT 1,
    `soldout`      int(11) NULL DEFAULT 0,
    `categoryId`   varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `discountId`   varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `isSale`       TINYINT(1) NOT NULL DEFAULT 1,
    CHECK (`isSale` IN (0, 1)),
    PRIMARY KEY (`id`) USING BTREE,
    INDEX          `fk_discount`(`discountId`) USING BTREE,
    CONSTRAINT `fk_discount` FOREIGN KEY (`discountId`) REFERENCES `handmadestore`.`discount` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;


CREATE TABLE `handmadestore`.`role`
(
    `id`   varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

CREATE TABLE `handmadestore`.`user`
(
    `id`          varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  NOT NULL,
    `name`        varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `phoneNumber` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `email`       varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `password`    varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `createDate`  datetime NULL DEFAULT current_timestamp (),
    `status`      varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `roleId`      varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  NOT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    INDEX         `fkuser`(`roleId`) USING BTREE,
    CONSTRAINT `fkuser` FOREIGN KEY (`roleId`) REFERENCES `handmadestore`.`role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;


CREATE TABLE `handmadestore`.`order`
(
    `id`          varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci   NOT NULL,
    `totalPrice`  decimal(10, 2)                                                NOT NULL,
    `orderDate`   datetime NULL DEFAULT current_timestamp (),
    `status`      varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  NOT NULL,
    `address`     varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `shippingFee` decimal(10, 2) NULL DEFAULT 0.00,
    `userId`      varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci   NOT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    INDEX         `fk_order`(`userId`) USING BTREE,
    CONSTRAINT `fk_order` FOREIGN KEY (`userId`) REFERENCES `handmadestore`.`user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;


CREATE TABLE `handmadestore`.`order_details`
(
    `orderId`   varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `productId` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `quantity`  int(11) NOT NULL,
    PRIMARY KEY (`orderId`, `productId`) USING BTREE,
    INDEX       `fk_od2`(`productId`) USING BTREE,
    CONSTRAINT `fk_od1` FOREIGN KEY (`orderId`) REFERENCES `handmadestore`.`order` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `fk_od2` FOREIGN KEY (`productId`) REFERENCES `handmadestore`.`product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

CREATE TABLE `handmadestore`.`image`
(
    `id`        varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `name`      varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `path`      text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `productId` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    PRIMARY KEY (`id`) USING BTREE,
    INDEX       `fk_image`(`productId`) USING BTREE,
    CONSTRAINT `fk_image` FOREIGN KEY (`productId`) REFERENCES `handmadestore`.`product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

CREATE TABLE `handmadestore`.`rate`
(
    `productId`   varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `userId`      varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `starRatings` int(11) NOT NULL,
    `comment`     text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `createDate`  datetime NULL DEFAULT current_timestamp (),
    PRIMARY KEY (`productId`, `userId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;



/* CREATE TABLES */
/* CATEGORY */

INSERT INTO `category` (`id`, `name`)
VALUES ('C01', 'Thiệp, Khung Ảnh Handmade Vint');
INSERT INTO `category` (`id`, `name`)
VALUES ('C02', 'Scrapbook, Album Ảnh');
INSERT INTO `category` (`id`, `name`)
VALUES ('C03', 'Sổ ghi chép, sổ tay');
INSERT INTO `category` (`id`, `name`)
VALUES ('C04', 'Trang sức, phụ kiện thời trang');
INSERT INTO `category` (`id`, `name`)
VALUES ('C05', 'Đồ decor trang trí');

/* ROLE */

INSERT INTO `role` (`id`, `name`)
VALUES ('r0', 'admin');
INSERT INTO `role` (`id`, `name`)
VALUES ('r1', 'user');

/* DISCOUNT */

INSERT INTO `discount` (`id`, `name`, `startDate`, `endDate`, `percentageOff`)
VALUES ('DC01', 'Giáng Sinh', '2023-12-20 00:00:00', '2023-12-26 00:00:00', 0.15);
INSERT INTO `discount` (`id`, `name`, `startDate`, `endDate`, `percentageOff`)
VALUES ('DC02', 'Tết Nguyên Đán', '2024-02-01 00:00:00', '2023-02-16 00:00:00', 0.20);
INSERT INTO `discount` (`id`, `name`, `startDate`, `endDate`, `percentageOff`)
VALUES ('DC03', 'Ngày phụ nữ Việt Nam', '2024-10-19 00:00:00', '2024-10-20 00:00:00', 0.30);
INSERT INTO `discount` (`id`, `name`, `startDate`, `endDate`, `percentageOff`)
VALUES ('DC04', 'Ngày Valentine', '2024-02-10 00:00:00', '2024-02-14 00:00:00', 0.30);
INSERT INTO `discount` (`id`, `name`, `startDate`, `endDate`, `percentageOff`)
VALUES ('DC05', 'Ngày Nhà giáo Việt Nam', '2024-11-15 00:00:00', '2024-11-20 00:00:00', 0.20);


/* PRODUCT */

INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P01', 'Thiệp handmade vintage Beauty & the Whit',
        'Kích thước lớn hơn thông thường: 11x18cm, gồm bì thư, giấy viết thông điệp và thiệp;\nChủ đề có sẵn: chúc mừng sinh nhật, valentine, 8/3, 20/10, 20/11;\nLiên lạc ngay với Craft & More Vietnam nếu bạn muốn làm thiệp theo chủ đề riêng;\nThiệp làm handmade tỉ mỉ với vật liệu giấy cứng, giấy mỹ thuật, hoa lá cỏ khô... rất thân thiện môi trường;\nTùy biến kích thước, câu chữ, logo cho nhóm, công ty, đoàn thể...\nLưu ý: Thiệp được làm thủ công-handmade với các vật liệu hoa, lá, cỏ, giấy... nên các chi tiết có thể khác đôi chút cho từng sản phẩm nhưng phong cách (concept) luôn thống nhất theo các mẫu.',
        50000.00, 70000.00, 35, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P02', 'Thiệp handmade Film de Paris',
        'Mẫu thiệp chúc mừng FILM de PARIS đậm chất retro, vintage hoài cổ;\nKích thước lớn hơn thông thường: 11x18cm, gồm bì thư, giấy viết thông điệp và thiệp;\nChủ đề có sẵn: chúc mừng sinh nhật, valentine, 8/3, 20/10, 20/11;\nLiên lạc ngay với Craft & More Vietnam nếu bạn muốn làm thiệp theo chủ đề riêng;\nThiệp làm handmade tỉ mỉ với vật liệu giấy cứng, giấy mỹ thuật, hoa lá cỏ khô... rất thân thiện môi trường;\nTùy biến kích thước, câu chữ, logo cho nhóm, công ty, đoàn thể...\nLưu ý: Thiệp được làm thủ công-handmade với các vật liệu hoa, lá, cỏ, giấy... nên các chi tiết có thể khác đôi chút cho từng sản phẩm nhưng phong cách (concept) luôn thống nhất theo các mẫu.',
        55000.00, 70000.00, 21, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P03', 'Thiệp chúc mừng Sweet Mint',
        'Mẫu thiệp SWEET MINT - ngọt ngào như viên kẹo bạc hà! \nKích thước lớn hơn thông thường: 11x18cm, gồm bì thư, giấy viết thông điệp và thiệp; \nChủ đề có sẵn: chúc mừng sinh nhật, valentine, 8/3, 20/10, 20/11; \nLiên lạc ngay với Craft & More Vietnam nếu bạn muốn làm thiệp theo chủ đề riêng; \nThiệp làm handmade tỉ mỉ với vật liệu giấy cứng, giấy mỹ thuật, hoa lá cỏ khô... rất thân thiện môi trường; \nTùy biến kích thước, câu chữ, logo cho nhóm, công ty, đoàn thể... \nLưu ý: Thiệp được làm thủ công-handmade với các vật liệu hoa, lá, cỏ, giấy... nên các chi tiết có thể khác đôi chút cho từng sản phẩm nhưng phong cách (concept) luôn thống nhất theo các mẫu.',
        50000.00, 70000.00, 24, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P04', 'Thiệp chúc mừng Black & White',
        'Trắng - đen luôn có nét đẹp riêng, mẫu thiệp mang đậm phong cách vintage, hoài cổ & màu sắc tối giản nhưng cá tính với nền là giấy kraft cứng đen kết hợp die cut được sắp xếp hài hòa.\nKích thước: 11x14cm.\nGồm bì thư, giấy viết thông điệp và thiệp.\nThiệp được làm handmade tỉ mỉ, chỉn chu.\nThiệp phù hợp với nhiều dịp tặng 14/2 Valentine, 8/3, 20/10, 20/11, Noel Giáng Sinh...',
        24000.00, 39000.00, 15, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P05', 'Thiệp handmade Amazing Carto',
        'Mẫu thiệp AMAZING CARTON cảm hứng từ những tấm bìa cứng thô ráp! \nKích thước: 9x14cm; \nChủ đề có sẵn: chúc mừng sinh nhật, valentine, 8/3, 20/10, 20/11; \nLiên lạc ngay với Craft & More Vietnam nếu bạn muốn làm thiệp theo chủ đề riêng; \nThiệp làm handmade tỉ mỉ với vật liệu giấy cứng, giấy mỹ thuật, hoa lá cỏ khô... rất thân thiện môi trường; \nTùy biến kích thước, câu chữ, logo cho nhóm, công ty, đoàn thể... \nLưu ý: Thiệp được làm thủ công-handmade với các vật liệu hoa, lá, cỏ, giấy... nên các chi tiết có thể khác đôi chút cho từng sản phẩm nhưng phong cách (concept) luôn thống nhất theo các mẫu.',
        24000.00, 39000.00, 5, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P06', 'Thiệp handmade lớn Beauty & the White',
        'Kích thước 11x18cm \nChất liệu giấy mỹ thuật cao cấp \nChủ đề đa dạng, tùy biến \nPhù hợp với hầu hết các đối tượng, các dịp như 8/3, 20/10, 20/11, sinh nhật, chúc mừng...',
        50000.00, 70000.00, 13, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P07', 'Thiệp da bò độc đáo',
        'Kích thước: 10x13.5cm \n\n- Chất liệu da bò chọn lọc, charm đồng, giấy dó \n\n- Tùy biến theo ý riêng: theo mục đích tặng (sinh nhật, 20/11, 20/10, 8/3, valentine 14/2, giáng sinh v.v...) hoặc thay đổi hoàn toàn thông điệp theo ý riêng.',
        30000.00, 50000.00, 19, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P08', 'Thiệp dấu sáp mini',
        'Thiệp mini đơn giản nhưng đẹp! \n\nThiệp làm & đóng sáp thủ công handmade; \n\nKích thước 6x9cm, gồm giấy viết thông điệp bên trong thiệp; \n\nVật liệu: giấy craft, sáp đóng dấu, dây thừng, giấy mỹ thuật',
        7000.00, 19000.00, 40, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P09', 'Thiệp handmade Vintage Film',
        'Kích thước: 10x14.5cm \n\n- Chất liệu giấy mỹ thuật đặc biệt, charm đồng \n\n- Sản phẩm gồm thiệp, tấm giấy ghi thông điệp, bì thư vintage \n\n- Tùy biến theo ý riêng: theo mục đích tặng (sinh nhật, 20/11, 20/10, 8/3, valentine 14/2, giáng sinh v.v...) hoặc thay đổi hoàn toàn thông điệp theo ý riêng.',
        15000.00, 39000.00, 50, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P10', 'Thiệp handmade vintage vải bố',
        '- Kích thước: 10x14.5cm \n\n- Chất liệu vải bố nâu, charm đồng, giấy dó \n\n- Tùy biến theo ý riêng: theo mục đích tặng (sinh nhật, 20/11, 20/10, 8/3, valentine 14/2, giáng sinh v.v...) hoặc thay đổi hoàn toàn thông điệp theo ý riêng.',
        18500.00, 39000.00, 34, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P100', 'Album DIY gáy lò xo tiện dụng Paris Je T',
        'Album tự trang trí gáy lò xo tiện dụng Paris Je Táime Kích thước vừa phải,tiện dụng: 17*18cm; Bìa giấy cứng cáp, 2 màu đen và nâu; có ruy băng vải buộc chắc chắn...',
        78000.00, 125000.00, 27, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P101', 'Bình cắm hoa LYO',
        'Bình cắm hoa LYON trang trí, Kích thước 12cm đường kính x 20cm cao, chất liệu: thiếc không gỉ', 350000.00,
        404000.00, 10, 'C05', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P102', 'Bình sứ trang trí Vintage',
        'Bình sứ trang trí đẹp nhẹ nhàng phù hợp trang trí shop, studio, quán cafe, nhà hàng, phòng khách', 95000.00,
        163000.00, 10, 'C05', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P103', 'Bình cắm hoa trang trí dây thừng',
        'Bình cắm hoa trang trí dây thừng\nkích thước: 14cm đường kính x 19,5cm cao\nChất liệu thiếc được sơn chống gỉ.',
        280000.00, 404000.00, 10, 'C05', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P104', 'Chai thủy tinh quấn thừng lớ',
        'Chai (lọ) thủy tinh quấn thừng xinh xắn dùng cắm hoa cực đẹp Với chai thủy tinh, sợi thừng nhỏ, Cổ & Cũ đã giúp thổi hồn vào sản phẩm một cách tinh tế và điệu đà, sản phẩm \"chất\" và \"mộc\" một...',
        89000.00, 119000.00, 10, 'C05', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P105', 'Bình gốm cao giả cổ hoa văn vintage',
        'Chất liệu: sứ; hoa văn vintage cổ điển;\nKích thước: chân bình 15.5 cm; miệng bình 26 cm; cao 28 cm.',
        320000.00, 545000.00, 10, 'C05', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P106', 'Khay sứ giả cổ',
        'Chất liệu: sứ màu xanh ngọc; \nKích thước: cao 27cm, dài gồm tay cầm 43 cm, dài mặt trong khay 31cm, rộng 22cm, đường kính đáy khay 13cm.',
        690000.00, 924000.00, 7, 'C05', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P107', 'Giá để rượu vang gốm giả cổ', 'Chất liệu: gốm; \nKích thước: 18x30cm.', 310000.00, 499000.00, 14,
        'C05', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P108', 'Đế để rượu Nhân Sư Ai Cập', 'Kích thước: 31x11x17cm; \nChất liệu: thạch cao, nhựa tổng hợp.',
        340000.00, 562000.00, 20, 'C05', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P109', 'Giá rượu Mèo Thần Ai Cập', 'Kích thước: 23x26x10cm; \nChất liệu: thạch cao và nhựa tổng hợp.',
        340000.00, 562000.00, 20, 'C05', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P11', 'Thiệp gỗ Jigsaws',
        'Khắc thông điệp theo ý riêng \n\n- Kích thước: 10x14.5cm \n\n- Chất liệu gỗ polywood \n\n- Sản phẩm gồm thiệp, tấm giấy ghi thông điệp, bì thư vintage \n\n- Tùy biến theo ý riêng: theo mục đích tặng (sinh nhật, 20/11, 20/10, 8/3, valentine 14/2, giáng sinh v.v...) hoặc thay đổi hoàn toàn thông điệp theo ý riêng.',
        20100.00, 39000.00, 49, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P110', 'Bình sứ Le Jardinier',
        'Chất liệu gốm sứ \nKích thước: 12.5 x 5.3 x 6.5cm \nDùng trang trí, cắm hoa,...', 23000.00, 52000.00, 35,
        'C05', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P111', 'Cốc vintage', 'Chất liệu; gốm sứ \nKích thước: 8,5cm x 7,7cm \nDung tích: 300ml', 45000.00, 69000.00,
        0, 'C05', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P112', 'Ly sứ vintage phong cảnh châu Âu', 'Cao 11.5cm; Đường kính 8cm; dung tích 300ml.', 59000.00, 89000.00,
        0, 'C05', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P113', 'Bình sứ xinh xắn Dream House', 'Dung tích: 200ml; \nKích thước: 8x10cm.', 70000.00, 105000.00, 0,
        'C05', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P114', 'Ly sứ starbucks coffee', 'Dung tích 300ml; \nLy cao 8.5cm; đường kính 7.5cm;', 23000.00, 45000.00, 0,
        'C05', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P115', 'Ly sứ vintage street', 'Cao 9cm; đường kính 7cm; có nắp.', 84000.00, 115000.00, 12, 'C05',
        NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P116', 'Bình hoa gốm trắng GRID', 'Kích thước 20x25cm;', 395000.00, 532000.00, 15, 'C05', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P117', 'Bình hoa gốm giả cổ trang trí nâu cao cổ', 'Kích thước: 17x38 cm;', 400000.00, 509000.00, 0,
        'C05', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P118', 'Bình sứ giả cổ Victoria',
        'Bình sứ trang trí đẹp nhẹ nhàng mang phong cách vintage phù hợp trang trí quán cafe, studio, shop,...',
        240000.00, 395000.00, 2, 'C05', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P119', 'Hộp đựng bút R102',
        'kích thước :16.5x7x21 (cm) \n\nKích thước thuyền :21×4.5×16(cm) \n\nChất liệu : Sắt sơn tĩnh điện, chống rỉ sét, mài mòn. \n\nGiúp cho phòng làm việc trở nên gọn gàng, hiện đại hơn, từ đó mà không gian trở nên thoải mái, làm việc cũng hiệu quả hơn.',
        90000.00, 170000.00, 6, 'C05', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P12', 'Thiệp gỗ Other Half',
        '- Kích thước: 10x14.5cm \n\n- Chất liệu gỗ polywood \n\n- Sản phẩm gồm thiệp, tấm giấy ghi thông điệp, bì thư vintage \n\n- Tùy biến theo ý riêng: theo mục đích tặng (sinh nhật, 20/10, 8/3, valentine 14/2, giáng sinh, annivesary...) hoặc thay đổi hoàn toàn thông điệp theo ý riêng.',
        17800.00, 39000.00, 40, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P120', 'Mèo thần tài R104',
        'Mèo thần tài R104 với thiết kế góc cạnh hiện đại, được làm từ gốm sứ cao cấp, tráng men sáng bóng, màu sắc tươi tắn, sắc nét mang đến may mắn, bình an và tài lộc vô biên cho gia chủ. Mèo thần tài cũng rất phù hợp để làm quà tặng dịp mừng khai trương, tân gia, thăng quan tiến chức,…',
        290000.00, 400000.00, 20, 'C05', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P121', 'Tượng Hươu trang trí R103',
        'Từ xa xưa, hình ảnh hươu nai trang trí đã được các tầng lớp quý tộc vô cùng ưa chuộng. Bởi họ quan niệm rằng, hươu nai biểu tượng cho sự sung túc và giàu có. Do hươu là loài vật sống rất lâu năm nên việc trưng bày hình ảnh của loài vật này còn mang ý nghĩa may mắn và trường thọ. Đặt tượng hươu trang trí trong nhà sẽ mang đến cho gia đình một cuộc sống bình an, mạnh khỏe. Đặc biệt, hỗ trợ cực tốt cho gia chủ trên con đường làm ăn kinh doanh, phát tài phát lộc, gặp nhiều may mắn và thuận lợi trong công việc.',
        550000.00, 649999.00, 19, 'C05', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P122', 'Xe máy mô hình trang trí R101',
        'Kích thước :15 x 5.5 x 9.5 (cm) \n\nChất liệu : sắt phủ sơn tĩnh điện, chống rỉ sét, mài mòn. \n\nPhù hợp để trang trí bàn làm việc, văn phòng, Studio , giúp cho không gian thêm phần thanh lịch, hiện đại.',
        75000.00, 135000.00, 27, 'C05', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P123', 'Đèn bão trang trí Vintage',
        'Đèn bão vintage trang trí nhà cửa Đèn bão được phủ một lớp sơn đồng, bạc đậm chất retro. Đèn bão thời trước đây dùng trong các trường hợp không có điện, ngày nay khi mọi thứ trở nên hiện đại,...',
        140000.00, 192000.00, 4, 'C05', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P124', 'Móc treo nữ trang vintage', 'Kích thước: 25x16cm \nChất liệu: gỗ, kim loại', 100000.00,
        152000.00, 4, 'C05', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P125', 'Lọ hoa thủy tinh handmade',
        'LỌ HOA THỦY TINH HANDMADE Được chăm chút tỉ mỉ từng cánh hoa, chậu hoa handmade thủy tinh sẽ là một món quà tặng xinh xắn hay làm căn phòng của bạn dễ thương hơn bao giờ hết. Lọ hoa thủy...',
        89000.00, 120000.00, 0, 'C05', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P126', 'Hoa lavender oải hương handmade trang tr', 'Chất liệu foam, giấy, dây kẽm. \nMàu sắc đa dạng',
        15000.00, 35000.00, 0, 'C05', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P127', 'Hoa chậu handmade - Hoa hồng giấy',
        'Hoa chậu handmade - Hoa hồng giấy Hoa handmade chậu thủy tinh quấn thừng nhỏ xinh, dễ thương khi sử dụng làm quà tặng, người nhận có thể dùng trang trí kệ, bàn. Ưu điểm của hoa handmade là hình thức đẹp không...',
        101000.00, 157000.00, 19, 'C05', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P128', 'Hộp nhạc piano pha lê khắc tê',
        'Hộp nhạc dây cót piano pha lê khắc tên Thiết kế mới lạ, sang trọng, được làm từ nhựa trong acrylic bạn sẽ nhìn được chuyển động đang chạy trong hộp nhạc trông rất thú vị. Làm đồ decor trong nhà, bàn làm...',
        510000.00, 559000.00, 25, 'C05', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P129', 'Hộp nhạc gỗ Piano', 'Màu sắc trắng, hồng \nKhắc tên laser', 510000.00, 559000.00, 33,
        'C05', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P13', 'Thiệp chúc mừng handmade Blue Pastel',
        '- Kích thước: 10x14.5cm \n\n- Chất liệu giấy mỹ thuật đặc biệt, charm đồng \n\n- Sản phẩm gồm thiệp, tấm giấy ghi thông điệp, bì thư vintage \n\n- Tùy biến theo ý riêng: theo mục đích tặng (sinh nhật, 20/11, 20/10, 8/3, valentine 14/2, giáng sinh v.v...) hoặc thay đổi hoàn toàn thông điệp theo ý riêng.',
        23000.00, 39000.00, 37, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P130', 'Hộp nhạc cổ điển camera',
        'Kích thước:12x6x7,5cm \nChất liệu: gỗ \nThiết kế tỉ mỉ, khéo léo \nMẫu mã thịnh hành \nThích hợp làm quà tặng sinh nhật, valentine, noel, 8/3, 20/10,..',
        220000.00, 250000.00, 14, 'C05', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P131', 'Tượng trang trí phòng khách Thinker',
        'Chất liệu: đá sa thạch bền chắc, thân thiện với môi trường và an toàn với người sử dụng. \nKích thước: cao 23cm x ngang 12,5cm. \nMàu sắc: như hình. \nBảo quản: Không được rửa bằng nước hay bất kì dung dịch nào. Khi tượng bám bụi, hãy dùng khăn mềm lau nhẹ nhàng.',
        190000.00, 249000.00, 19, 'C05', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P132', 'Tượng trang trí vintage không thấy - khô',
        'Kích thước 11x12 cao 32cm \nChất liệu : Đá Composite cao cấp \nMàu sắc giả đá tự nhiê', 260000.00, 406000.00,
        27, 'C05', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P133', 'Xe Vespa mô hình trang trí, phụ kiện chụ',
        'Mô hình xe Vespa chất liệu kim loại \n\n- Kích thước 12x7.5cm, nhỏ xinh siêu cute \n\n- Xe Vespa trang trí, làm đồ decor sưu tập, phụ kiện chụp ảnh',
        108000.00, 152000.00, 19, 'C05', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P134', 'Thuyền gỗ vintage decor trang trí, phụ k',
        'Có 3 kích thước 27cm; 34cm và 42cm \nChất liệu gỗ theo phong cách Địa Trung Hải.', 88000.00, 149000.00, 16,
        'C05', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P14', 'Thiệp vintage Retro Clock',
        '- Kích thước: 10x14.5cm \n\n- Chất liệu giấy mỹ thuật đặc biệt, charm đồng \n\n- Sản phẩm gồm thiệp, tấm giấy ghi thông điệp, bì thư vintage \n\n- Tùy biến theo ý riêng: theo mục đích tặng (sinh nhật, 20/11, 20/10, 8/3, valentine 14/2, giáng sinh v.v...) hoặc thay đổi hoàn toàn thông điệp theo ý riêng.',
        17000.00, 30000.00, 25, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P15', 'Thiệp giấy carton handmade - Thiệp chúc ',
        'Thiệp làm handmade tỉ mỉ lấy cảm hứng từ những tấm carton thô ráp, kết hợp với hoa lá cỏ khô tạo thành mẫu thiệp đẹp, độc đáo. \n\nCó thể thay đổi chủ đề theo yêu cầu. \n\nKích thước: 11x14cm.',
        28900.00, 49000.00, 19, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P16', 'Thiệp tặng bạn thân - Thiệp vintage retr',
        'Thiệp tặng bạn thân - Thiệp vintage retro Là một trong những mẫu thiệp handmade cổ điển, HeadQuarter giúp bạn trở về lại với những giá trị tinh thần mà nhiều khi sống giữa thời đại công nghệ chúng...',
        16500.00, 49000.00, 11, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P17', 'Giấy viết thư cổ điển Vintage',
        '- Giấy viết thư cổ điển hoa văn vintage Mang dáng dấp cổ điển độc đáo, những tờ giấy viết thư đầy cảm xúc sẽ là của bạn với những thiết kế độc đáo, cổ điển Vintage lạ mắt. Giấy viết thư...',
        17900.00, 35000.00, 34, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P18', 'Khung ảnh đẹp Frame Triple',
        'Bộ khung ảnh ba đẹp Bộ ba khung ảnh thiết kế với gỗ mộc mạc, mang phong cách Vintage độc đáo, thiết kế bộ ba, sử dụng trang trí được cả hai mặt tương đương với 6 bức hình. Khung ảnh bộ...',
        145000.00, 377000.00, 20, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P19', 'Khung ảnh frame 6 in 1',
        'Khung ảnh frame gỗ trang trí Cực xinh xắn và tiện dụng với bộ khung ảnh frame theo phong cách Vintage ấn tượng: + Bộ sản phẩm tiện dụng với bộ khung gỗ, gắn móc khóa, đồng hồ và khung ảnh kích thước 53...',
        950000.00, 1337000.00, 10, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P20', 'Khung ảnh gỗ 3 in 1',
        'Thiết kế cực sang trọng với màu trắng làm chủ đạo, phù hợp với mọi không gian trong căn nhà bạn', 475000.00,
        630000.00, 10, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P21', 'Khung ảnh, tủ móc khóa, móc treo 3 in 1', 'Kích thước: 21x28cm; \nChất liệu: gỗ;', 134000.00, 347000.00,
        0, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P22', 'Khung hình vintage triple cỡ lớ',
        'Kích thước khung 57x31cm; cỡ hình 10x15cm; trọng lượng 1.38kg; \nChất liệu: gỗ, thiết kế hoài cổ, vintage, cá tính.',
        376000.00, 519000.00, 6, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P23', 'Khung ảnh handmade - thiệp handmade đẹp ',
        'Sản phẩm được thiết kế cá tính và đậm chất Vintage cổ xưa sẽ là sản phẩm độc đáo dành cho bạn có nhu cầu lưu giữ những tấm ảnh \"hay ho\" hay ghi lại khoảnh khắc đáng nhớ. Bạn có thể dán hình hoặc câu chữ yêu thích đặt vào khung hình.',
        13000.00, 29000.00, 0, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P24', 'Khung ảnh kiểu Địa Trung Hải',
        'Mang nắng, gió và biển Địa Trung Hải vào thiết kế không gian của bạn đơn giản chỉ với chiếc khung ảnh này. Kích thước: 19 x 23cm; Chất liệu: gỗ thông đẹp và bền bỉ.',
        106000.00, 189000.00, 24, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P25', 'Khung ảnh vintage kiểu US Army',
        'Bằng chất liệu kim loại, gỗ cùng một chút sáng tạo, khung ảnh US Army sẽ là điểm nhấn cho không gian thêm phần khác lạ. Kích thước khung 1 x 23 x 28cm; cỡ hình 10 x 15cm;',
        98000.00, 167000.00, 21, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P26', 'Khung ảnh vintage trắng ngà',
        'Khung hình thiết kế đơn giản, đẹp, tinh tế, nhẹ nhàng với tông màu trắng. Kích thước lần lượt cho các khổ ảnh 9x9cm giá 105k; 9x13cm giá 162k; 10x15cm giá 173k; 13x18cm giá 197k.',
        88000.00, 97000.00, 16, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P27', 'Khung ảnh - móc treo FISH HOOK',
        'Kích thước: 55x4x20cm; \nChất liệu: gỗ, dây thừng \nKhung 3 ảnh 6x9cm được làm thủ công tỉ mỉ', 204000.00,
        379000.00, 0, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P28', 'Khung ảnh gỗ và thạch cao Ivory Vintage',
        'Khung ảnh gỗ và thạch cao Ivory Vintage ấn tượng Chất liệu gỗ và thạch cao hòa quyện cùng sự sáng tạo độc đáo đã cho ra đời sản phẩm khung ảnh độc đáo Ivory Vintage. Kích thước sản phẩm: 4 x...',
        219000.00, 349000.00, 5, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P29', 'Khung ảnh Hải Âu Mediterranea', 'Chất liệu: gỗ; \nKích thước khung 18x23cm; khổ hình 10x15cm;',
        101000.00, 189000.00, 1, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P30', 'Khung ảnh Địa Trung Hải Kayak',
        'Thiết kế thuyền kayak độc đáo, hiện đại và khác biệt, chiếc khung ảnh Địa Trung Hải này như một chút biến tấu cho không gian của bạn thêm sự mới lạ. Kích thước sản phẩm: 15 x 26cm, được làm bằng chất liệu: gỗ, thừng, thạch cao, sò biển...',
        96000.00, 167000.00, 0, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P31', 'Khung ảnh vintage hoa văn vuông',
        'Cổ điển và ấn tượng, chiếc khung ảnh Vintage mang hơi thở hoài cổ nhẹ nhàng và ấn tượng. Chất liệu: gỗ, kích thước khung 18 x 22cm; cỡ hình 10 x 15cm.',
        104000.00, 150000.00, 0, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P32', 'Khung ảnh mèo Totoro',
        'Khung ảnh mèo Totoro Mang nét mộc mạc đơn sơ nhưng cực kì xinh xắn, với khung ảnh mèo Totoro, sự đơn giản từ chiếc khung ảnh có thể làm nổi bật lên tấm hình mà bạn muốn trưng cho không...',
        65000.00, 84000.00, 3, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P33', 'Khung ảnh Staring time (lớn)',
        'Khung ảnh gỗ đẹp Staring time Không chỉ là chiếc khung ảnh gỗ, mà nó còn là kỉ vật thời gian gắn bó với rất nhiều người, do đó, một chiếc khung ảnh luôn là món đồ vật được trân trọng,...',
        145000.00, 212000.00, 2, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P34', 'Khung ảnh gỗ thông Rustic',
        'Khung ảnh Rustic cỡ lớn Những điều ý nghĩa, những kỷ niệm đẹp hãy lưu lại và trân trọng điều đó bởi đó là những điều sẽ đi suốt cuộc đời của bạn. Chính vì thể hãy giữ cho những bức...',
        179000.00, 227000.00, 15, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P35', 'Khung ảnh Hải Âu Mediterranea',
        'Quà tặng khung ảnh Hải Âu Mediterranean Chất liệu: gỗ; Kích thước khung 18x23cm; khổ hình 10x15cm; Like FACEBOOK VIETGIFTCENTER.COM để được cập nhật nhanh nhất!',
        125000.00, 189000.00, 13, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P36', 'Khung trang trí bàn hoa hồng sứ C-rose f',
        'Phong cách \"mộc\" ấn tượng cho khung trang trí để bàn C-rose. Ngoài việc trang trí, khung trang trí còn là điểm nhấn phong thủy độc đáo cho nội thất của bạn. Khung trang trí để bàn hoa hồng Kích thước:13,9 x...',
        241000.00, 317000.00, 18, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P37', 'KHUNG ẢNH NGÔI NHÀ CỬA SỔ NÂU (NGANG)', 'KÍCH THƯỚC: 24.5 * 20.5cm \nChất liệu: Gỗ', 178000.00,
        240000.00, 4, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P38', 'KHUNG ẢNH NGÔI NHÀ XE ĐẠP', 'KÍCH THƯỚC: 19*26.5cm \nChất liệu: Gỗ', 178000.00, 240000.00, 1,
        'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P39', 'KHUNG ẢNH VÒNG ĐU QUAY VINTAGE',
        'Khung ảnh vòng đu quay vintage 2 \nKích thước: 33 x 18.5 cm \nChất liệu: kim loại', 0.00, 0.00, NULL,
        'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P40', 'Bì thư vintage Tem Việt',
        'BÌ THƯ VINTAGE CỔ ĐIỂN Bao thư với phong cách vintage thích hợp cho bạn nếu yêu thích những phong cách retro đặc biệt ấn tượng này. Bạn có thể sử dụng để làm quà tặng hoặc để trang trí đều...',
        19000.00, 35000.00, 12, 'C01', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P41', 'Scrapbook That Time',
        '- Kích thước 21x21x5cm; \n\n- Trang trí được 30-50 ảnh đủ các kích thước 4x6cm đến 13x18cm; \n\n- Sản phẩm được làm thủ công, chăm chút từng chi tiết nhỏ; scrapbook có phong cách, màu sắc đậm chất vintage, hoài cổ rất được yêu thích; \n\n- Scrapbook có thể thiết kế, tùy biến chủ đề theo ý riêng.',
        450000.00, 649000.00, 10, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P42', 'Scrapbook Sweet Mint',
        '- Kích thước 21x21x5cm \n\n- Trang trí được 30-50 ảnh đủ các kích thước 4x6cm đến 13x18cm \n\n- Sản phẩm được làm thủ công, chăm chút từng chi tiết nhỏ \n\n- Scrapbook có thể thiết kế, tùy biến chủ đề theo ý riêng',
        450000.00, 649000.00, 8, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P43', 'Scrapbook Fly That Time',
        '- Kích thước 14.5 x 21.5 x 5cm \n\n- Trang trí được 30 ảnh 6x9cm \n\n- Sản phẩm được làm handmade tỉ mỉ từng chi tiết nhỏ',
        104000.00, 0.00, 13, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P44', 'Album ảnh handmade Fly Sweet Mint',
        '- Sản phẩm được làm handmade chăm chút tỉ mỉ \n\n- Kích thước 14.5 x 21.5 x 5cm \n\n- Trang trí được 30 hình 6x9cm \n\n- Có thể tùy biến, thiết kế chủ đề theo yêu cầu riêng',
        104000.00, 0.00, 16, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P45', 'Album ảnh tự trang trí Love Story (Xanh)',
        'Màu xanh Vintage huyền bí cùng thiết kế theo phong cách Vintage đầy bí ẩn sẽ làm cuốn album của bạn thêm thu hút và độc đáo.',
        147000.00, 220000.00, 24, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P46', 'Scrapbook Retro Clock',
        '- Màu sắc: Nâu - trắng. \n\n- Kích thước: 20 x 20cm. \n\n- Chất liệu: Giấy cứng cao cấp, được trang trí hoàn toàn bằng tay (100% handmade). \n\n- Số trang: 11, có thể dán được 40-60 hình các size khác nhau.',
        402000.00, 649000.00, 1, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P47', 'Scrapbook Vintage',
        'Scrapbook handmade cao cấp đậm chất vintage Just be me Quyển scrapbook (một dạng sổ ảnh handmade) được làm thủ công với thiết kế hoàn toàn khác biệt, chắc chắn, chứa được nhiều hình hơn so với các scrapbook khác. Màu...',
        1350000.00, 1620000.00, 4, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P48', 'Scrapbook Lò Xo Handmade Phong Cách Retr',
        '✔ Kích thước: 20 x 21cm \n\n️ ✔ Các size ảnh: 4x6, 6x9, 9x12 \n\n️ ✔ 16 trang giấy cứng và các họa tiết trang trí ấn tượng. \n\n️ ✔ Tối đa 47 tấm hình. Có nhiều lớp được xếp chồng lên nhau và kéo thả để hiển thị hình ảnh.',
        400000.00, 549000.00, 9, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P49', 'Album ảnh handmade Blue Pastel',
        'Màu sắc chủ đạo: Trắng - Xanh Rustic/Pastel nhẹ nhàng. \n\n- Kích thước: 20 x 20cm. \n\n- Chất liệu: Giấy cứng cao cấp, được trang trí hoàn toàn bằng tay (100% handmade). \n\n- Số trang: 11, có thể dán được 40-60 hình các size khác nhau.',
        400000.00, 649000.00, 14, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P50', 'Scrapbook My Boy For The Memories',
        'Scrapbook thường được xem là món quà đặc biệt không chỉ với thiết kế mà còn giá trị của tinh thần lẫn vật chất của nó. Sản phẩm thành công và được nhiều người yêu thích vì những ý nghĩa...',
        400000.00, 549000.00, 14, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P51', 'Scrapbook Lò Xo Handmade Trang Trí Độc L',
        '- Kích thước: 9,5 x 21cm\n\n- Các size ảnh phù hợp: 4x6, 6x9, 9x12\n\n- Giấy cứng và các họa tiết trang trí ấn tượng.\n\n- Tối đa 47 tấm hình. Có nhiều lớp được xếp chồng lên nhau và kéo thả để hình ảnh vô cùng độc lạ.',
        400000.00, 549000.00, 14, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P52', 'Scrapbook Film de Paris',
        'Scrapbook handmade Film de Paris độc đáo và ấn tượng với phiên bản Blue siêu quyến rũ. Scrapbook dùng làm album ảnh lưu trữ những kỉ niệm đẹp. - Kích thước: 21 x 21cm - Có thể trang trí 50 hình lớn nhỏ - Chất liệu:...',
        450000.00, 649000.00, 16, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P53', 'Scrapbook handmade Sweet Moments',
        '- Màu sắc: vàng lúa mạch.\n\n- Kích thước: 20 x 20cm.\n\n- Chất liệu: Giấy cứng cao cấp, được trang trí hoàn toàn bằng tay (100% handmade).\n\n- Số trang: 11, có thể dán được 40-60 hình các size khác nhau.',
        450000.00, 649000.00, 12, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P54', 'SCRAPBOOK CHỦ ĐỀ CHO BÉ',
        'Scrapbook chủ đề cho bé trai và bé gái Bạn băn khoăn về việc lưu giữ hình ảnh của bé con sao cho vừa đẹp, vừa ý nghĩa, dễ thương mà vẫn độc đáo và khác biệt. Bạn không chỉ muốn đơn thuần...',
        500000.00, 629000.00, 8, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P55', 'Fly album handmade bicycle',
        'Fly album handmade bicycle Chất liệu: giấy cứng cao cấp; Làm bằng tay hoàn toàn (100% handmade); Kích thước: 14.5*21.5 cm; Số trang: 14, Dán được được 30 hình khổ 6x9 cm. Like Fanpage vietgiftcenter.com để được hỗ trợ thông tin nhanh nhất.',
        210000.00, 329000.00, 9, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P56', 'Fly album handmade Blue Pastel',
        '- Chất liệu: giấy cứng cao cấp; \n- Làm bằng tay hoàn toàn (100% handmade); \n- Kích thước: 14 cm*23 cm; \n- Số trang: 15, Dán được được 32 hình khổ 6 x 9cm.',
        210000.00, 329000.00, 20, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P57', 'Fly album Love (Xanh)',
        'Phiên bản độc quyền mang phong cách riêng của Craft & More. Mang màu sắc cùng thiết kế bí ẩn, fly album handmade Love có thể trang trí trên bàn làm việc, bàn học, không gian. Sản phẩm có hộp đựng vô cùng xinh xắn.',
        210000.00, 329000.00, 17, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P58', 'Fly album Sweet Moment',
        'Nếu fly album Anchor với tông màu hồng xin xắn dành riêng cho mùa xuân thì fly album Sweet Moment lại khơi gợi nét nhẹ nhàng, lãng đãng của mùa thu dịu dàng. Sản phẩm vừa là cuốn album ảnh \"độc\", vừa là vật trang trí cực lãng mạn cho không gian.',
        210000.00, 329000.00, 6, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P59', 'Fly album Retro Clock',
        '- Chất liệu: giấy cứng cao cấp; \n- Làm bằng tay hoàn toàn (100% handmade); \n- Kích thước: 14 cm*23 cm; \n- Số trang: 15, Dán được được 32 hình khổ 6 x 9cm.',
        210000.00, 329000.00, 11, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P60', 'Scrapbook độc đáo cho tình yêu THE JOURN',
        '- Màu sắc: Nâu trầm. \n\n- Kích thước: 21 x 21cm, gồm 11 trang giấy trang trí sẵn. \n\n- Sản phẩm mang thông điệp và màu sắc trung tính, có thể dùng làm quà tặng, album trang trí cho cả nam lẫn nữ. \n\n- Sản phẩm có 2 mẫu khác nhau. Vui lòng chọn mẫu khi đặt hàng.',
        400000.00, 649000.00, 9, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P61', 'Album DIY Retro Clock',
        'Thiết kế mang dáng vẻ cổ điển cùng lối trang trí đơn giản nhưng mang lại nét sang trọng, nhẹ nhàng cùng chi tiết bánh răng, đồng hồ, poscard,...',
        145000.00, 222000.00, 0, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P62', 'Scrapbook LIVE.LAUGH.LOVE',
        'Scrapbook với chất liệu giấy cứng, khổ: 20*20 cm; có thể trang trí khoảng 50 hình lớn nhỏ.', 400000.00,
        649000.00, 38, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P63', 'Scrapbook Were Growing',
        'Quà handmade cho bé, cho tuổi trẻ - scrapbook Were Growing - Sweet Laughing Album ảnh handmade có thiết kế ấn tượng tông màu nâu mang nét hoài cổ cá tính. Album phù hợp ghi dấu những chặng đường phát triển...',
        550000.00, 699000.00, 25, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P64', 'Scrapbook JUST BE ME',
        'Scrapbook JUST BE ME Album ảnh có kích thước: 20x20cm; dán được 30-40 ảnh. Scrapbook được thiết kế ấn tượng theo phong cách VINTAGE, RETRO. Bạn có thể thêm bớt giấy tùy theo số lượng hình. Album được tặng thêm một số phụ...',
        500000.00, 679000.00, 19, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P65', 'SCRAPBOOK CHỦ ĐỀ TÌNH YÊU',
        'Để giúp bạn dễ dàng hơn trong việc lựa chọn, ở bài viết này, Craft & More sẽ giới thiệu đến bạn một số mẫu Scrapbook theo chủ đề Tình yêu. Click vào tên sản phẩm để biết thêm nhiều thông...',
        400000.00, 649000.00, 24, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P66', 'Scrapbook MY LITTLE PRINCESS',
        'Scrapbook độc đáo cho bé yêu - bé gái: MY LITTLE PRINCESS Album ảnh handmade có kích thước: 21*21 cm; giấy cao cấp, dán được khoảng trên 50 hình lớn nhỏ. Album được trang trí sẵn rất cá tính nhưng dịu dàng với tông màu hồng...',
        400000.00, 649000.00, 35, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P67', 'Album handmade bé trai MY LITTLE PRINCE',
        'Scrapbook bé trai MY LITTLE PRINCE Album ảnh handmade dành riêng cho bé trai, tông màu xanh mạnh mẽ, cá tính - món quà độc đáo cho chàng hoàng tử bé của bạn; khổ: 21*21 cm; dán được 50 hình. Album làm...',
        400000.00, 649000.00, 32, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P68', 'Album ảnh bé trai Wonderful My boy',
        'Scrapbook cho bé trai WONDERFUL - MY BOY Album ảnh handmade cho bé trai đậm chất vintage, là dạng kết hợp trang trí sẵn và tự làm (DIY): bìa và 3 trang bên trong trang trí sẵn; các trang còn lại trống (blank) để...',
        500000.00, 679000.00, 15, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P69', 'Scrapbook cao cấp My little princess',
        'Scrapbook handmade cao cấp My little princess Album được bằng tay với nhiều chi tiết tinh xảo. Scrapbook có thể dán hơn 150 hình với khích thước khác nhau. Kích thước: 20x20cm. Like Facebook của chúng tôi để được cập nhật nhanh nhất thông...',
        1400000.00, 1620000.00, 6, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P70', 'Scrapbook handmade Darling Daughter',
        '- Chất liệu: giấy cứng cao cấp; \n- Khổ: 20*20 cm; \n- Album gáy còng, có thể dễ dàng thêm bớt trang tùy thích. Sản phẩm có thể đựng được 50-60 hình lớn nhỏ.',
        500000.00, 679000.00, 4, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P71', 'Scrapbook cao cấp I am marvelous',
        'Scrapbook cao cấp I am marvelous Album đươc làm hoàn toàn bằng tay tỉ mỉ, chất liệu giấy mỹ thuật cao cấp; kích thước: 20x20cm. Like Facebook của chúng tôi ngay các bạn nhé!',
        1400000.00, 1620000.00, 22, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P72', 'Scrapbook cao cấp My boy',
        'Scrapbook handmade cao cấp My boy Album được làm hoàn toàn bằng tay rất tỉ mỉ. Kích thước: 20x20cm; Scrapbook có thể dán được hơn 150 hình với khích thước khác nhau. Chất liệu: giấy mỹ thuật cao cấp. Like ngay Facebook...',
        1400000.00, 1620000.00, 21, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P73', 'Album cưới handmade Beautiful In White',
        'Album cưới handmade - scrapbook chủ đề TÌNH YÊU Beautiful In White Album handmade Beautiful in White đúng như tên gọi, được thiết kế thanh thoát, giản dị, lãng mạn với tông trắng chủ đạo. Các trang nền bên trong có hoa văn,...',
        400000.00, 649000.00, 19, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P74', 'Album handmade scrapbook đẹp Together Fo',
        'Album handmade scrapbook đẹp Together Forever Làm bằng tay hoàn toàn, tĩ mĩ từng chi tiết nhỏ nhất! 20 trang giấy chuyên dụng được trang trí đặc sắc; Chủ đề tình yêu: TOGETHER FOREVER; Chứa khoảng...',
        520000.00, 729000.00, 18, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P75', 'Scrapbook cao cấp Were growing',
        'Scrapbook cao cấp làm album ảnh đẹp cho bé và gia đình Sự ra đời của cuốn album scrapbook cao cấp Were growing là một sự đột phá trong cách trang trí, lưu giữ kỉ niệm bằng album. Bằng những trang giấy nghệ...',
        1400000.00, 1620000.00, 0, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P76', 'Album ảnh handmade I am Marvelous',
        'Lưu giữ những khoảnh khắc đáng nhớ bằng scrapbook I am Marvelous Scrapbook I am Marvelous sẽ là nơi lý tưởng để bạn có thể lưu giữ những kỉ niệm hạnh phúc và đáng nhớ bên gia đình của mình. Những tấm hình...',
        500000.00, 679000.00, 12, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P77', 'Flying album handmade Love Story',
        'Album ảnh handmade có thể kéo dài -flying album Chất liệu: giấy cứng cao cấp; Làm bằng tay hoàn toàn (100% handmade); Kích thước: 14.5*21.5 cm; Số trang: 14, đựng được 30 hình khổ 6*9 cm và 1 hình 9*12cm Like facebook Craft & More để...',
        210000.00, 329000.00, 20, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P78', 'Flying album handmade Somewhere in time',
        'Flying album handmade tỉ mỉ Chất liệu: giấy cứng cao cấp; Làm bằng tay hoàn toàn (100% handmade); Kích thước: 14.5*21.5 cm; Số trang: 14, đựng được 30 hình khổ 6*9 cm và 1 hình 9x12cm. Món quà tặng độc đáo cho những người yêu...',
        210000.00, 329000.00, 20, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P79', 'Flying album handmade A Moment in Time',
        'Món quà tặng độc đáo cho những người yêu thương, hay cho chính bạn!', 210000.00, 329000.00, 20,
        'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P80', 'Flying album vintage Memories',
        'Album ảnh bay handmade (flying album) Memories Chất liệu: giấy cứng cao cấp; Làm bằng tay hoàn toàn (100% handmade); Kích thước: 14.5*21.5 cm; Số trang: 14, đựng được 30 hình khổ 6*9 cm và 1 hình 9*12cm.',
        210000.00, 329000.00, 25, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P81', 'Sổ ký tên đám cưới handmade',
        'Sổ ký tên đám cưới handmade phong cách vintage Album cưới handmade dùng để ký tên và dán hình trang trí tiệc cưới được làm bằng tay hoàn toàn. Sổ có tối thiểu 3 trang hình và 3 trang ký tên, chứa khoảng 10-15 hình;',
        970000.00, 1129000.00, 34, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P82', 'Exploding love box album handmade',
        'Chất liệu: Giấy cứng hoa văn cao cấp \n\nKích thước: 9 x 13cm, cao 6cm, chứa được khoảng 29 tấm hình 6 x 9cm.',
        310000.00, 449000.00, 0, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P83', 'Mini Love Card-Album Handmade',
        'Chất liệu: giấy cứng cao cấp; bền bỉ theo thời gian \nKích thước: 7.5*12 cm; \nChủ đề đa dạng, được thiết kế và thực hiện tại HeadQuarter',
        56000.00, 109000.00, 14, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P84', 'ALBUM TỰ TRANG TRÍ (P.I) - SCRAPBOOK',
        'Khác với 5-10 năm trước đây, làm album handmade không chỉ là một phạm trù xa lạ mà còn khá khó khăn cho người làm bởi sự hạn chế về nguồn cung cấp và nơi bán các loại nguyên vật liệu....',
        500000.00, 679000.00, 31, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P85', 'ALBUM TỰ TRANG TRÍ (P.II) - ALBUM DIY',
        'Bài trước, chúng ta đã tìm hiểu qua Scrapbook, bài tiếp theo này Craft & More xin giới thiệu tiếp đến Album ảnh DIY Album DIY (DO IT YOURSELF) Album DIY vượt trội hơn Scrapbook về số lượng ảnh được lưu trữ,...',
        145000.00, 220000.00, 30, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P86', 'Album tự trang trí Vân gỗ trắng',
        'Album thiết kế tối giản với màu sơn trắng Vintage cổ điển, họa tiết dấu mộc cổ độc đáo như một nét chấm phá hoàn hảo cho cuốn album ảnh lưu bút độc đáo của bản thân.',
        140000.00, 220000.00, 30, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P87', 'Album DIY Vân gỗ Đỏ',
        'Màu sắc chủ đạo: Nâu, vàng, đỏ được phối hợp khéo léo theo phong cách Vintage tinh tế. Thiết kế không bao giờ lỗi thời, tối giản tới mức thấp nhất mọi nét trang trí cầu kì trên sản phẩm.',
        140000.00, 220000.00, 30, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P88', 'Album DIY Vân gỗ Pastel',
        'Màu chủ đạo: tông màu trắng + xanh Pastel dịu nhẹ. Thiết kế nhẹ nhàng và đầy ngẫu hứng, họa tiết vân gỗ quen thuộc nhưng vẫn gây cảm giác lạ mắt rất riêng cho sản phẩm.',
        140000.00, 220000.00, 30, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P89', 'Album DIY Sọc nhỏ',
        'Họa tiết sọc xinh xắn, nhẹ nhàng, album gồm 60 trang với 2 màu nâu - đen đơn giản, 100% trang giấy trống cho bạn thỏa sức sáng tạo.',
        140000.00, 220000.00, 19, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P90', 'Scrapbook handmade FOLIO',
        'Mẫu scrapbook đẹp với việc sắp xếp khéo léo nhiều tấm thẻ thành một quyển sổ ảnh, kết hợp việc phối màu sắc, hoa văn tạo nên tổng thể một quyển scrapbook handmade đậm chất retro. Scrapbook có kích thước A5,...',
        230000.00, 479000.00, 18, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P91', 'Sổ ký tên handmade Save the date',
        'Thiết kế sổ ký tên + album ảnh cưới 2 in 1. Sản phẩm được làm 100% bằng tay từ ý tưởng đến thiết kế, lấy ý tưởng từ chủ đề đại dương lãng mạn và dịu dàng, sổ ký tên Save the date chắc chắn sẽ làm bạn và người chiêm ngưỡng bất ngờ và thích thú.',
        1100000.00, 1380000.00, 20, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P92', 'Sổ ký tên Our Story',
        'Sản phẩm là sổ ký tên kết hợp album ảnh cưới cực độc đáo. Tông màu xanh, nâu trầm chủ đạo, họa tiết Vintage cuốn hút và quyến rũ. Cuốn sổ ký tên được thiết kế sang trọng và bắt mắt, ấn tượng như một câu chuyện cổ tích có thật!',
        1100000.00, 1380000.00, 20, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P93', 'Sổ ký tên ngày cưới Let me love you',
        'Sổ ký tên đám cưới mua ở đâu? Khổ 31x31cm; 24 trang luôn bìa; các họa tiết vẽ tay artline in trên giấy mỹ thuật Tinki 250 gsm kết hợp làm album ảnh handmade độc đáo! Guestbook - sổ ký tên với...',
        180000.00, 319000.00, 0, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P94', 'Sổ ký tên Happy Light',
        'Sổ ký tên Happy Light Kích thước: 31x31cm Định lượng giấy 250gsm Số trang: 20 trang', 180000.00, 319000.00, 1,
        'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P95', 'Sổ ký tên Happy Forest',
        'Guestbook Happy Forest Định lượng giấy: 250gsm Số trang: 20 trang Kích thước 31x31cm', 180000.00, 319000.00, 1,
        'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P96', 'Sổ ký tên Tiny Love',
        'Guestbook Tiny Love Kích thước: 31cm x 31cm Định lượng giấy: 250gsm Số lượng trang: 20 trang', 180000.00,
        319000.00, 5, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P97', 'Album tự thiết kế Baby photo GIRL (27cm*',
        'Album tự thiết kế Baby photo màu hồng-món quà cho các bé gái và gia đình tại vietgiftcenter.com Khổ vuông 27cm*27cm, 64 trang luôn bìa, giấy bên trong 2 màu đen.',
        176000.00, 280000.00, 16, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P98', 'Guest Book Feeling good',
        'Guest book-sổ kí tên Feeling good Kích thước: 31x31cm, định lượng giấy: 250gsm, số lượng trang: 20 trang.',
        180000.00, 319000.00, 16, 'C02', NULL);
INSERT INTO `product` (`id`, `name`, `description`, `costPrice`, `sellingPrice`, `quantity`, `categoryId`,
                       `discountId`)
VALUES ('P99', 'Guestbook - sổ ký tên đám cưới Memory Bo',
        'Guestbook - sổ ký tên đám cưới Khổ: 31x31cm; 24 trang luôn bìa, được thiết kế đặc biệt dành cho ký tên ngày cưới. Hoặc bạn có thể dùng làm album ảnh dán DIY. Bìa guestbook được thiết kế với tông màu...',
        180000.00, 319000.00, 19, 'C02', NULL);

/* IMAGE */

INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I01', 'Thiệp handmade vintage Beauty ', 'images/products/.webp', 'P01');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I02', 'Thiệp handmade vintage Beauty ', 'images/products/.webp', 'P01');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I03', 'Thiệp handmade vintage Beauty ', 'images/products/.webp', 'P01');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I04', 'Thiệp handmade Film de Paris', 'images/products/.webp', 'P02');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I05', 'Thiệp handmade Film de Paris', 'images/products/.webp', 'P02');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I06', 'Thiệp handmade Film de Paris', 'images/products/.webp', 'P02');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I07', 'Thiệp chúc mừng Sweet Mint', 'images/products/.webp', 'P03');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I08', 'Thiệp chúc mừng Sweet Mint', 'images/products/.webp', 'P03');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I09', 'Thiệp chúc mừng Sweet Mint', 'images/products/.webp', 'P03');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I10', 'Thiệp chúc mừng Black & White', 'images/products/.webp', 'P04');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I100', 'Scrapbook Fly That Time', 'images/products/p44.webp', 'P43');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I101', 'Album ảnh handmade Fly Sweet M', 'images/products/p44_1.webp', 'P44');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I102', 'Album ảnh handmade Fly Sweet M', 'images/products/p44_2.webp', 'P44');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I103', 'Album ảnh handmade Fly Sweet M', 'images/products/p45.webp', 'P44');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I104', 'Album ảnh tự trang trí Love St', 'images/products/p45_1.webp', 'P45');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I105', 'Album ảnh tự trang trí Love St', 'images/products/p45_2.webp', 'P45');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I106', 'Album ảnh tự trang trí Love St', 'images/products/p46.webp', 'P45');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I107', 'Scrapbook Retro Clock', 'images/products/p46_1.webp', 'P46');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I108', 'Scrapbook Retro Clock', 'images/products/p46_2.webp', 'P46');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I109', 'Scrapbook Retro Clock', 'images/products/p47.webp', 'P46');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I11', 'Thiệp chúc mừng Black & White', 'images/products/p04.webp', 'P04');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I110', 'Scrapbook Vintage', 'images/products/p47_1.webp', 'P47');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I111', 'Scrapbook Vintage', 'images/products/p48.webp', 'P47');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I112', 'Scrapbook Lò Xo Handmade Phong', 'images/products/p48_1.webp', 'P48');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I113', 'Scrapbook Lò Xo Handmade Phong', 'images/products/p48_2.webp', 'P48');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I114', 'Scrapbook Lò Xo Handmade Phong', 'images/products/p49.webp', 'P48');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I115', 'Album ảnh handmade Blue Pastel', 'images/products/p49_1.webp', 'P49');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I116', 'Album ảnh handmade Blue Pastel', 'images/products/p49_2.webp', 'P49');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I117', 'Album ảnh handmade Blue Pastel', 'images/products/p50.webp', 'P49');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I118', 'Scrapbook My Boy For The Memor', 'images/products/p50_1.webp', 'P50');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I119', 'Scrapbook My Boy For The Memor', 'images/products/p50_2.webp', 'P50');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I12', 'Thiệp chúc mừng Black & White', 'images/products/p05.webp', 'P04');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I120', 'Scrapbook My Boy For The Memor', 'images/products/p51.webp', 'P50');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I121', 'Scrapbook Lò Xo Handmade Trang', 'images/products/p51_1.webp', 'P51');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I122', 'Scrapbook Lò Xo Handmade Trang', 'images/products/p51_2.webp', 'P51');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I123', 'Scrapbook Lò Xo Handmade Trang', 'images/products/p52.webp', 'P51');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I124', 'Scrapbook Film de Paris', 'images/products/p52_1.webp', 'P52');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I125', 'Scrapbook Film de Paris', 'images/products/p52_2.webp', 'P52');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I126', 'Scrapbook Film de Paris', 'images/products/p53.webp', 'P52');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I127', 'Scrapbook handmade Sweet Momen', 'images/products/p53_1.webp', 'P53');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I128', 'Scrapbook handmade Sweet Momen', 'images/products/p53_2.webp', 'P53');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I129', 'Scrapbook handmade Sweet Momen', 'images/products/p54.webp', 'P53');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I13', 'Thiệp handmade Amazing Carto', 'images/products/p05_1.webp', 'P05');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I130', 'SCRAPBOOK CHỦ ĐỀ CHO BÉ', 'images/products/p54_1.webp', 'P54');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I131', 'SCRAPBOOK CHỦ ĐỀ CHO BÉ', 'images/products/p54_2.webp', 'P54');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I132', 'SCRAPBOOK CHỦ ĐỀ CHO BÉ', 'images/products/p55.webp', 'P54');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I133', 'Fly album handmade bicycle', 'images/products/p55_1.webp', 'P55');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I134', 'Fly album handmade bicycle', 'images/products/p55_2.webp', 'P55');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I135', 'Fly album handmade bicycle', 'images/products/p56.webp', 'P55');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I136', 'Fly album handmade Blue Pastel', 'images/products/p56_1.webp', 'P56');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I137', 'Fly album handmade Blue Pastel', 'images/products/p56_2.webp', 'P56');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I138', 'Fly album handmade Blue Pastel', 'images/products/p57.webp', 'P56');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I139', 'Fly album Love (Xanh)', 'images/products/p57_1.webp', 'P57');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I14', 'Thiệp handmade Amazing Carto', 'images/products/p05_2.webp', 'P05');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I140', 'Fly album Love (Xanh)', 'images/products/p57_2.webp', 'P57');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I141', 'Fly album Love (Xanh)', 'images/products/p58.webp', 'P57');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I142', 'Fly album Sweet Moment', 'images/products/p58_1.webp', 'P58');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I143', 'Fly album Sweet Moment', 'images/products/p59.webp', 'P58');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I144', 'Fly album Retro Clock', 'images/products/p59_1.webp', 'P59');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I145', 'Fly album Retro Clock', 'images/products/p60.webp', 'P59');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I146', 'Scrapbook độc đáo cho tình yêu', 'images/products/p60_1.webp', 'P60');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I147', 'Scrapbook độc đáo cho tình yêu', 'images/products/p60_2.webp', 'P60');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I148', 'Scrapbook độc đáo cho tình yêu', 'images/products/p61.webp', 'P60');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I149', 'Album DIY Retro Clock', 'images/products/p61_1.webp', 'P61');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I15', 'Thiệp handmade Amazing Carto', 'images/products/p06.webp', 'P05');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I150', 'Album DIY Retro Clock', 'images/products/p61_2.webp', 'P61');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I151', 'Album DIY Retro Clock', 'images/products/p62.webp', 'P61');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I152', 'Scrapbook LIVE,LAUGH,LOVE', 'images/products/p62_1.webp', 'P62');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I153', 'Scrapbook LIVE,LAUGH,LOVE', 'images/products/p62_2.webp', 'P62');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I154', 'Scrapbook LIVE,LAUGH,LOVE', 'images/products/p63.webp', 'P62');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I155', 'Scrapbook Were Growing', 'images/products/p63_1.webp', 'P63');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I156', 'Scrapbook Were Growing', 'images/products/p63_2.webp', 'P63');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I157', 'Scrapbook Were Growing', 'images/products/p64.webp', 'P63');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I158', 'Scrapbook JUST BE ME', 'images/products/p64_1.webp', 'P64');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I159', 'Scrapbook JUST BE ME', 'images/products/p65.webp', 'P64');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I16', 'Thiệp handmade lớn Beauty & th', 'images/products/p06_1.webp', 'P06');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I160', 'SCRAPBOOK CHỦ ĐỀ TÌNH YÊU', 'images/products/p65_1.webp', 'P65');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I161', 'SCRAPBOOK CHỦ ĐỀ TÌNH YÊU', 'images/products/p66.webp', 'P65');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I162', 'Scrapbook MY LITTLE PRINCESS', 'images/products/p66_1.webp', 'P66');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I163', 'Scrapbook MY LITTLE PRINCESS', 'images/products/p66_2.webp', 'P66');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I164', 'Scrapbook MY LITTLE PRINCESS', 'images/products/p67.webp', 'P66');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I165', 'Album handmade bé trai MY LITT', 'images/products/p68.webp', 'P67');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I166', 'Album ảnh bé trai Wonderful My', 'images/products/p68_1.webp', 'P68');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I167', 'Album ảnh bé trai Wonderful My', 'images/products/p69.webp', 'P68');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I168', 'Scrapbook cao cấp My little pr', 'images/products/p69_1.webp', 'P69');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I169', 'Scrapbook cao cấp My little pr', 'images/products/p70.webp', 'P69');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I17', 'Thiệp handmade lớn Beauty & th', 'images/products/p06_2.webp', 'P06');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I170', 'Scrapbook handmade Darling Dau', 'images/products/p70_1.webp', 'P70');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I171', 'Scrapbook handmade Darling Dau', 'images/products/p71.webp', 'P70');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I172', 'Scrapbook cao cấp I am marvelo', 'images/products/p72.webp', 'P71');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I173', 'Scrapbook cao cấp My boy', 'images/products/p73.webp', 'P72');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I174', 'Album cưới handmade Beautiful ', 'images/products/p73_1.webp', 'P73');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I175', 'Album cưới handmade Beautiful ', 'images/products/p74.webp', 'P73');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I176', 'Album handmade scrapbook đẹp T', 'images/products/p74_1.webp', 'P74');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I177', 'Album handmade scrapbook đẹp T', 'images/products/p74_2.webp', 'P74');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I178', 'Album handmade scrapbook đẹp T', 'images/products/p75.webp', 'P74');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I179', 'Scrapbook cao cấp Were growing', 'images/products/p75_1.webp', 'P75');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I18', 'Thiệp handmade lớn Beauty & th', 'images/products/p07.webp', 'P06');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I180', 'Scrapbook cao cấp Were growing', 'images/products/p75_2.webp', 'P75');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I181', 'Scrapbook cao cấp Were growing', 'images/products/p76.webp', 'P75');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I182', 'Album ảnh handmade I am Marvel', 'images/products/p76_1.webp', 'P76');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I183', 'Album ảnh handmade I am Marvel', 'images/products/p76_2.webp', 'P76');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I184', 'Album ảnh handmade I am Marvel', 'images/products/p77.webp', 'P76');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I185', 'Flying album handmade Love Sto', 'images/products/p77_1.webp', 'P77');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I186', 'Flying album handmade Love Sto', 'images/products/p77_2.webp', 'P77');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I187', 'Flying album handmade Love Sto', 'images/products/p78.webp', 'P77');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I188', 'Flying album handmade Somewher', 'images/products/p78_1.webp', 'P78');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I189', 'Flying album handmade Somewher', 'images/products/p78_2.webp', 'P78');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I19', 'Thiệp da bò độc đáo', 'images/products/p07_1.webp', 'P07');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I190', 'Flying album handmade Somewher', 'images/products/p79.webp', 'P78');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I191', 'Flying album handmade A Moment', 'images/products/p79_1.webp', 'P79');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I192', 'Flying album handmade A Moment', 'images/products/p79_2.webp', 'P79');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I193', 'Flying album handmade A Moment', 'images/products/p80.webp', 'P79');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I194', 'Flying album vintage Memories', 'images/products/p80_1.webp', 'P80');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I195', 'Flying album vintage Memories', 'images/products/p80_2.webp', 'P80');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I196', 'Flying album vintage Memories', 'images/products/p81.webp', 'P80');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I197', 'Sổ ký tên đám cưới handmade', 'images/products/p81_1.webp', 'P81');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I198', 'Sổ ký tên đám cưới handmade', 'images/products/p81_2.webp', 'P81');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I199', 'Sổ ký tên đám cưới handmade', 'images/products/p82.webp', 'P81');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I20', 'Thiệp da bò độc đáo', 'images/products/p07_2.webp', 'P07');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I200', 'Exploding love box album handm', 'images/products/p82_1.webp', 'P82');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I201', 'Exploding love box album handm', 'images/products/p82_2.webp', 'P82');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I202', 'Exploding love box album handm', 'images/products/p83.webp', 'P82');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I203', 'Mini Love Card-Album Handmade', 'images/products/p83_1.webp', 'P83');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I204', 'Mini Love Card-Album Handmade', 'images/products/p83_2.webp', 'P83');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I205', 'Mini Love Card-Album Handmade', 'images/products/p84.webp', 'P83');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I206', 'ALBUM TỰ TRANG TRÍ (P,I) - SCR', 'images/products/p85.webp', 'P84');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I207', 'ALBUM TỰ TRANG TRÍ (P,II) - AL', 'images/products/p85_1.webp', 'P85');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I208', 'ALBUM TỰ TRANG TRÍ (P,II) - AL', 'images/products/p86.webp', 'P85');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I209', 'Album tự trang trí Vân gỗ trắn', 'images/products/p86_1.webp', 'P86');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I21', 'Thiệp da bò độc đáo', 'images/products/p08.webp', 'P07');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I210', 'Album tự trang trí Vân gỗ trắn', 'images/products/p86_2.webp', 'P86');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I211', 'Album tự trang trí Vân gỗ trắn', 'images/products/p87.webp', 'P86');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I212', 'Album DIY Vân gỗ Đỏ', 'images/products/p87_1.webp', 'P87');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I213', 'Album DIY Vân gỗ Đỏ', 'images/products/p87_2.webp', 'P87');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I214', 'Album DIY Vân gỗ Đỏ', 'images/products/p88.webp', 'P87');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I215', 'Album DIY Vân gỗ Pastel', 'images/products/p88_1.webp', 'P88');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I216', 'Album DIY Vân gỗ Pastel', 'images/products/p88_2.webp', 'P88');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I217', 'Album DIY Vân gỗ Pastel', 'images/products/p89.webp', 'P88');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I218', 'Album DIY Sọc nhỏ', 'images/products/p89_1.webp', 'P89');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I219', 'Album DIY Sọc nhỏ', 'images/products/p89_2.webp', 'P89');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I22', 'Thiệp dấu sáp mini', 'images/products/p08_1.webp', 'P08');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I220', 'Album DIY Sọc nhỏ', 'images/products/p90.webp', 'P89');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I221', 'Scrapbook handmade FOLIO', 'images/products/p90_1.webp', 'P90');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I222', 'Scrapbook handmade FOLIO', 'images/products/p90_2.webp', 'P90');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I223', 'Scrapbook handmade FOLIO', 'images/products/p91.webp', 'P90');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I224', 'Sổ ký tên handmade Save the da', 'images/products/p91_1.webp', 'P91');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I225', 'Sổ ký tên handmade Save the da', 'images/products/p91_2.webp', 'P91');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I226', 'Sổ ký tên handmade Save the da', 'images/products/p92.webp', 'P91');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I227', 'Sổ ký tên Our Story', 'images/products/p92_1.webp', 'P92');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I228', 'Sổ ký tên Our Story', 'images/products/p92_2.webp', 'P92');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I229', 'Sổ ký tên Our Story', 'images/products/p93.webp', 'P92');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I23', 'Thiệp dấu sáp mini', 'images/products/p08_2.webp', 'P08');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I230', 'Sổ ký tên ngày cưới Let me lov', 'images/products/p93_1.webp', 'P93');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I231', 'Sổ ký tên ngày cưới Let me lov', 'images/products/p94.webp', 'P93');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I232', 'Sổ ký tên Happy Light', 'images/products/p94_1.webp', 'P94');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I233', 'Sổ ký tên Happy Light', 'images/products/p94_2.webp', 'P94');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I234', 'Sổ ký tên Happy Light', 'images/products/p95.webp', 'P94');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I235', 'Sổ ký tên Happy Forest', 'images/products/p96.webp', 'P95');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I236', 'Sổ ký tên Tiny Love', 'images/products/p96_1.webp', 'P96');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I237', 'Sổ ký tên Tiny Love', 'images/products/p97.webp', 'P96');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I238', 'Album tự thiết kế Baby photo G', 'images/products/p97_1.webp', 'P97');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I239', 'Album tự thiết kế Baby photo G', 'images/products/p97_2.webp', 'P97');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I24', 'Thiệp dấu sáp mini', 'images/products/p09.webp', 'P08');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I240', 'Album tự thiết kế Baby photo G', 'images/products/p98.webp', 'P97');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I241', 'Guest Book Feeling good', 'images/products/p98_1.webp', 'P98');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I242', 'Guest Book Feeling good', 'images/products/p99.webp', 'P98');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I243', 'Guestbook - sổ ký tên đám cưới', 'images/products/p99_1.webp', 'P99');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I244', 'Guestbook - sổ ký tên đám cưới', 'images/products/p100.webp', 'P99');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I245', 'Album DIY gáy lò xo tiện dụng ', 'images/products/p100_1.webp', 'P100');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I246', 'Album DIY gáy lò xo tiện dụng ', 'images/products/p100_2.webp', 'P100');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I247', 'Album DIY gáy lò xo tiện dụng ', 'images/products/p101.webp', 'P100');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I248', 'Bình cắm hoa LYO', 'images/products/p101_1.webp', 'P101');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I249', 'Bình cắm hoa LYO', 'images/products/p101_2.webp', 'P101');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I25', 'Thiệp handmade Vintage Film', 'images/products/p09_1.webp', 'P09');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I250', 'Bình cắm hoa LYO', 'images/products/p102.webp', 'P101');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I251', 'Bình sứ trang trí Vintage', 'images/products/p102_1.webp', 'P102');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I252', 'Bình sứ trang trí Vintage', 'images/products/p102_2.webp', 'P102');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I253', 'Bình sứ trang trí Vintage', 'images/products/p103.webp', 'P102');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I254', 'Bình cắm hoa trang trí dây thừ', 'images/products/p103_1.webp', 'P103');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I255', 'Bình cắm hoa trang trí dây thừ', 'images/products/p103_2.webp', 'P103');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I256', 'Bình cắm hoa trang trí dây thừ', 'images/products/p104.webp', 'P103');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I257', 'Chai thủy tinh quấn thừng lớ', 'images/products/p104_1.webp', 'P104');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I258', 'Chai thủy tinh quấn thừng lớ', 'images/products/p104_2.webp', 'P104');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I259', 'Chai thủy tinh quấn thừng lớ', 'images/products/p105.webp', 'P104');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I26', 'Thiệp handmade Vintage Film', 'images/products/p09_2.webp', 'P09');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I260', 'Bình gốm cao giả cổ hoa văn vi', 'images/products/p105_1.webp', 'P105');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I261', 'Bình gốm cao giả cổ hoa văn vi', 'images/products/p105_2.webp', 'P105');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I262', 'Bình gốm cao giả cổ hoa văn vi', 'images/products/p106.webp', 'P105');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I263', 'Khay sứ giả cổ', 'images/products/p106_1.webp', 'P106');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I264', 'Khay sứ giả cổ', 'images/products/p106_2.webp', 'P106');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I265', 'Khay sứ giả cổ', 'images/products/p107.webp', 'P106');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I266', 'Giá để rượu vang gốm giả cổ', 'images/products/p107_1.webp', 'P107');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I267', 'Giá để rượu vang gốm giả cổ', 'images/products/p107_2.webp', 'P107');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I268', 'Giá để rượu vang gốm giả cổ', 'images/products/p108.webp', 'P107');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I269', 'Đế để rượu Nhân Sư Ai Cập', 'images/products/p108_1.webp', 'P108');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I27', 'Thiệp handmade Vintage Film', 'images/products/p10.webp', 'P09');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I270', 'Đế để rượu Nhân Sư Ai Cập', 'images/products/p108_2.webp', 'P108');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I271', 'Đế để rượu Nhân Sư Ai Cập', 'images/products/p109.webp', 'P108');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I272', 'Giá rượu Mèo Thần Ai Cập', 'images/products/p109_1.webp', 'P109');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I273', 'Giá rượu Mèo Thần Ai Cập', 'images/products/p110.webp', 'P109');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I274', 'Bình sứ Le Jardinier', 'images/products/p110_1.webp', 'P110');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I275', 'Bình sứ Le Jardinier', 'images/products/p111.webp', 'P110');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I276', 'Cốc vintage', 'images/products/p111_1.webp', 'P111');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I277', 'Cốc vintage', 'images/products/p111_2.webp', 'P111');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I278', 'Cốc vintage', 'images/products/p112.webp', 'P111');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I279', 'Ly sứ vintage phong cảnh châu ', 'images/products/p112_1.webp', 'P112');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I28', 'Thiệp handmade vintage vải bố', 'images/products/p10_1.webp', 'P10');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I280', 'Ly sứ vintage phong cảnh châu ', 'images/products/p112_2.webp', 'P112');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I281', 'Ly sứ vintage phong cảnh châu ', 'images/products/p113.webp', 'P112');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I282', 'Bình sứ xinh xắn Dream House', 'images/products/p113_1.webp', 'P113');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I283', 'Bình sứ xinh xắn Dream House', 'images/products/p113_2.webp', 'P113');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I284', 'Bình sứ xinh xắn Dream House', 'images/products/p114.webp', 'P113');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I285', 'Ly sứ starbucks coffee', 'images/products/p114_1.webp', 'P114');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I286', 'Ly sứ starbucks coffee', 'images/products/p114_2.webp', 'P114');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I287', 'Ly sứ starbucks coffee', 'images/products/p115.webp', 'P114');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I288', 'Ly sứ vintage street', 'images/products/p115_1.webp', 'P115');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I289', 'Ly sứ vintage street', 'images/products/p115_2.webp', 'P115');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I29', 'Thiệp handmade vintage vải bố', 'images/products/p10_2.webp', 'P10');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I290', 'Ly sứ vintage street', 'images/products/p116.webp', 'P115');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I291', 'Bình hoa gốm trắng GRID', 'images/products/p116_1.webp', 'P116');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I292', 'Bình hoa gốm trắng GRID', 'images/products/p116_2.webp', 'P116');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I293', 'Bình hoa gốm trắng GRID', 'images/products/p117.webp', 'P116');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I294', 'Bình hoa gốm giả cổ trang trí ', 'images/products/p117_1.webp', 'P117');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I295', 'Bình hoa gốm giả cổ trang trí ', 'images/products/p117_2.webp', 'P117');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I296', 'Bình hoa gốm giả cổ trang trí ', 'images/products/p118.webp', 'P117');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I297', 'Bình sứ giả cổ Victoria', 'images/products/p118_1.webp', 'P118');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I298', 'Bình sứ giả cổ Victoria', 'images/products/p119.webp', 'P118');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I299', 'Hộp đựng bút R102', 'images/products/p119_1.webp', 'P119');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I30', 'Thiệp handmade vintage vải bố', 'images/products/p11.webp', 'P10');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I300', 'Hộp đựng bút R102', 'images/products/p119_2.webp', 'P119');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I301', 'Hộp đựng bút R102', 'images/products/p120.webp', 'P119');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I302', 'Mèo thần tài R104', 'images/products/p120_1.webp', 'P120');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I303', 'Mèo thần tài R104', 'images/products/p120_2.webp', 'P120');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I304', 'Mèo thần tài R104', 'images/products/p121.webp', 'P120');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I305', 'Tượng Hươu trang trí R103', 'images/products/p121_1.webp', 'P121');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I306', 'Tượng Hươu trang trí R103', 'images/products/p121_2.webp', 'P121');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I307', 'Tượng Hươu trang trí R103', 'images/products/p122.webp', 'P121');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I308', 'Xe máy mô hình trang trí R101', 'images/products/p122_1.webp', 'P122');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I309', 'Xe máy mô hình trang trí R101', 'images/products/p122_2.webp', 'P122');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I31', 'Thiệp gỗ Jigsaws', 'images/products/p11_1.webp', 'P11');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I310', 'Xe máy mô hình trang trí R101', 'images/products/p123.webp', 'P122');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I311', 'Đèn bão trang trí Vintage', 'images/products/p123_1.webp', 'P123');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I312', 'Đèn bão trang trí Vintage', 'images/products/p123_2.webp', 'P123');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I313', 'Đèn bão trang trí Vintage', 'images/products/p124.webp', 'P123');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I314', 'Móc treo nữ trang vintage', 'images/products/p124_1.webp', 'P124');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I315', 'Móc treo nữ trang vintage', 'images/products/p125.webp', 'P124');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I316', 'Lọ hoa thủy tinh handmade', 'images/products/p125_1.webp', 'P125');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I317', 'Lọ hoa thủy tinh handmade', 'images/products/p126.webp', 'P125');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I318', 'Hoa lavender oải hương handmad', 'images/products/p126_1.webp', 'P126');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I319', 'Hoa lavender oải hương handmad', 'images/products/p126_2.webp', 'P126');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I32', 'Thiệp gỗ Jigsaws', 'images/products/p11_2.webp', 'P11');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I320', 'Hoa lavender oải hương handmad', 'images/products/p127.webp', 'P126');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I321', 'Hoa chậu handmade - Hoa hồng g', 'images/products/p127_1.webp', 'P127');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I322', 'Hoa chậu handmade - Hoa hồng g', 'images/products/p127_2.webp', 'P127');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I323', 'Hoa chậu handmade - Hoa hồng g', 'images/products/p128.webp', 'P127');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I324', 'Hộp nhạc piano pha lê khắc tê', 'images/products/p128_1.webp', 'P128');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I325', 'Hộp nhạc piano pha lê khắc tê', 'images/products/p128_2.webp', 'P128');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I326', 'Hộp nhạc piano pha lê khắc tê', 'images/products/p129.webp', 'P128');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I327', 'Hộp nhạc gỗ Piano', 'images/products/p129_1.webp', 'P129');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I328', 'Hộp nhạc gỗ Piano', 'images/products/p129_2.webp', 'P129');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I329', 'Hộp nhạc gỗ Piano', 'images/products/p130.webp', 'P129');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I33', 'Thiệp gỗ Jigsaws', 'images/products/p12.webp', 'P11');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I330', 'Hộp nhạc cổ điển camera', 'images/products/p130_1.webp', 'P130');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I331', 'Hộp nhạc cổ điển camera', 'images/products/p130_2.webp', 'P130');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I332', 'Hộp nhạc cổ điển camera', 'images/products/p131.webp', 'P130');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I333', 'Tượng trang trí phòng khách Th', 'images/products/p131_1.webp', 'P131');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I334', 'Tượng trang trí phòng khách Th', 'images/products/p131_2.webp', 'P131');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I335', 'Tượng trang trí phòng khách Th', 'images/products/p132.webp', 'P131');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I336', 'Tượng trang trí vintage không ', 'images/products/p132_1.webp', 'P132');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I337', 'Tượng trang trí vintage không ', 'images/products/p132_2.webp', 'P132');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I338', 'Tượng trang trí vintage không ', 'images/products/p133.webp', 'P132');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I339', 'Xe Vespa mô hình trang trí, ph', 'images/products/p133_1.webp', 'P133');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I34', 'Thiệp gỗ Other Half', 'images/products/p12_1.webp', 'P12');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I340', 'Xe Vespa mô hình trang trí, ph', 'images/products/p133_2.webp', 'P133');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I341', 'Xe Vespa mô hình trang trí, ph', 'images/products/p134.webp', 'P133');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I342', 'Thuyền gỗ vintage decor trang ', 'images/products/p134_1.webp', 'P134');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I343', 'Thuyền gỗ vintage decor trang ', 'images/products/p134_2.webp', 'P134');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I344', 'Thuyền gỗ vintage decor trang ', 'images/products/.webp', 'P134');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I35', 'Thiệp gỗ Other Half', 'images/products/p12_2.webp', 'P12');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I36', 'Thiệp gỗ Other Half', 'images/products/p13.webp', 'P12');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I37', 'Thiệp chúc mừng handmade Blue ', 'images/products/p13_1.webp', 'P13');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I38', 'Thiệp chúc mừng handmade Blue ', 'images/products/p13_2.webp', 'P13');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I39', 'Thiệp chúc mừng handmade Blue ', 'images/products/p14.webp', 'P13');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I40', 'Thiệp vintage Retro Clock', 'images/products/p14_1.webp', 'P14');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I41', 'Thiệp vintage Retro Clock', 'images/products/p14_2.webp', 'P14');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I42', 'Thiệp vintage Retro Clock', 'images/products/p15.webp', 'P14');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I43', 'Thiệp giấy carton handmade - T', 'images/products/p15_1.webp', 'P15');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I44', 'Thiệp giấy carton handmade - T', 'images/products/p15_2.webp', 'P15');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I45', 'Thiệp giấy carton handmade - T', 'images/products/p16.webp', 'P15');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I46', 'Thiệp tặng bạn thân - Thiệp vi', 'images/products/p16_1.webp', 'P16');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I47', 'Thiệp tặng bạn thân - Thiệp vi', 'images/products/p16_2.webp', 'P16');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I48', 'Thiệp tặng bạn thân - Thiệp vi', 'images/products/p17.webp', 'P16');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I49', 'Giấy viết thư cổ điển Vintage', 'images/products/p17_1.webp', 'P17');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I50', 'Giấy viết thư cổ điển Vintage', 'images/products/p17_2.webp', 'P17');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I51', 'Giấy viết thư cổ điển Vintage', 'images/products/p18.webp', 'P17');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I52', 'Khung ảnh đẹp Frame Triple', 'images/products/p18_1.webp', 'P18');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I53', 'Khung ảnh đẹp Frame Triple', 'images/products/p18_2.webp', 'P18');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I54', 'Khung ảnh đẹp Frame Triple', 'images/products/p19.webp', 'P18');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I55', 'Khung ảnh frame 6 in 1', 'images/products/p19_1.webp', 'P19');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I56', 'Khung ảnh frame 6 in 1', 'images/products/p19_2.webp', 'P19');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I57', 'Khung ảnh frame 6 in 1', 'images/products/p20.webp', 'P19');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I58', 'Khung ảnh gỗ 3 in 1', 'images/products/p20_1.webp', 'P20');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I59', 'Khung ảnh gỗ 3 in 1', 'images/products/p20_2.webp', 'P20');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I60', 'Khung ảnh gỗ 3 in 1', 'images/products/p21.webp', 'P20');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I61', 'Khung ảnh, tủ móc khóa, móc tr', 'images/products/p21_1.webp', 'P21');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I62', 'Khung ảnh, tủ móc khóa, móc tr', 'images/products/p22.webp', 'P21');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I63', 'Khung hình vintage triple cỡ l', 'images/products/p23.webp', 'P22');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I64', 'Khung ảnh handmade - thiệp han', 'images/products/p24.webp', 'P23');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I65', 'Khung ảnh kiểu Địa Trung Hải', 'images/products/p25.webp', 'P24');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I66', 'Khung ảnh vintage kiểu US Army', 'images/products/p26.webp', 'P25');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I67', 'Khung ảnh vintage trắng ngà', 'images/products/p27.webp', 'P26');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I68', 'Khung ảnh - móc treo FISH HOOK', 'images/products/p28.webp', 'P27');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I69', 'Khung ảnh gỗ và thạch cao Ivor', 'images/products/p28_1.webp', 'P28');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I70', 'Khung ảnh gỗ và thạch cao Ivor', 'images/products/p28_2.webp', 'P28');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I71', 'Khung ảnh gỗ và thạch cao Ivor', 'images/products/p29.webp', 'P28');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I72', 'Khung ảnh Hải Âu Mediterranea', 'images/products/p30.webp', 'P29');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I73', 'Khung ảnh Địa Trung Hải Kayak', 'images/products/p31.webp', 'P30');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I74', 'Khung ảnh vintage hoa văn vuôn', 'images/products/p32.webp', 'P31');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I75', 'Khung ảnh mèo Totoro', 'images/products/p32_1.webp', 'P32');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I76', 'Khung ảnh mèo Totoro', 'images/products/p32_2.webp', 'P32');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I77', 'Khung ảnh mèo Totoro', 'images/products/p33.webp', 'P32');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I78', 'Khung ảnh Staring time (lớn)', 'images/products/p33_1.webp', 'P33');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I79', 'Khung ảnh Staring time (lớn)', 'images/products/p33_2.webp', 'P33');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I80', 'Khung ảnh Staring time (lớn)', 'images/products/p34.webp', 'P33');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I81', 'Khung ảnh gỗ thông Rustic', 'images/products/p34_1.webp', 'P34');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I82', 'Khung ảnh gỗ thông Rustic', 'images/products/p34_2.webp', 'P34');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I83', 'Khung ảnh gỗ thông Rustic', 'images/products/p35.webp', 'P34');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I84', 'Khung ảnh Hải Âu Mediterranea', 'images/products/p36.webp', 'P35');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I85', 'Khung trang trí bàn hoa hồng s', 'images/products/p37.webp', 'P36');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I86', 'KHUNG ẢNH NGÔI NHÀ CỬA SỔ NÂU ', 'images/products/p37_1.webp', 'P37');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I87', 'KHUNG ẢNH NGÔI NHÀ CỬA SỔ NÂU ', 'images/products/p38.webp', 'P37');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I88', 'KHUNG ẢNH NGÔI NHÀ XE ĐẠP', 'images/products/p38_1.webp', 'P38');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I89', 'KHUNG ẢNH NGÔI NHÀ XE ĐẠP', 'images/products/p39.webp', 'P38');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I90', 'KHUNG ẢNH VÒNG ĐU QUAY VINTAGE', 'images/products/p40.webp', 'P39');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I91', 'Bì thư vintage Tem Việt', 'images/products/p40_1.webp', 'P40');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I92', 'Bì thư vintage Tem Việt', 'images/products/p40_2.webp', 'P40');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I93', 'Bì thư vintage Tem Việt', 'images/products/p41.webp', 'P40');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I94', 'Scrapbook That Time', 'images/products/p41_1.webp', 'P41');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I95', 'Scrapbook That Time', 'images/products/p41_2.webp', 'P41');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I96', 'Scrapbook That Time', 'images/products/p42.webp', 'P41');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I97', 'Scrapbook Sweet Mint', 'images/products/p42_1.webp', 'P42');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I98', 'Scrapbook Sweet Mint', 'images/products/p43.webp', 'P42');
INSERT INTO `image` (`id`, `name`, `path`, `productId`)
VALUES ('I99', 'Scrapbook Fly That Time', 'images/products/p43_1.webp', 'P43');


/* USER */
INSERT INTO `user` (`id`, `name`, `phoneNumber`, `email`, `password`, `createDate`, `status`, `roleId`)
VALUES ('u0', 'Admin', '0342156985', 'admin@gmail.com', 'admin', '2023-11-27 00:00:00', 'Bình Thường', 'r0');
INSERT INTO `user` (`id`, `name`, `phoneNumber`, `email`, `password`, `createDate`, `status`, `roleId`)
VALUES ('u1', 'Nguyễn Trung Kiên', '243685542', 'kien@gmail.com', 'kien123', '2023-11-27 00:00:00', 'Bình Thường',
        'r1');
INSERT INTO `user` (`id`, `name`, `phoneNumber`, `email`, `password`, `createDate`, `status`, `roleId`)
VALUES ('u2', 'Lung Bá Phệ', '145278563', 'phe@gmail.com', 'phe123', '2023-11-27 00:00:00', 'Bình Thường', 'r1');
INSERT INTO `user` (`id`, `name`, `phoneNumber`, `email`, `password`, `createDate`, `status`, `roleId`)
VALUES ('u3', 'Nguyễn Bá Huy', '348578921', 'huy@gmail.com', 'huy123', '2023-11-27 00:00:00', 'Bình Thường', 'r1');
INSERT INTO `user` (`id`, `name`, `phoneNumber`, `email`, `password`, `createDate`, `status`, `roleId`)
VALUES ('u4', 'Lâm Bá Thương', '124782369', 'thuong@gmail.com', 'thuong123', '2023-11-27 00:00:00', 'Bình Thường',
        'r1');
INSERT INTO `user` (`id`, `name`, `phoneNumber`, `email`, `password`, `createDate`, `status`, `roleId`)
VALUES ('u5', 'Nguyễn Trọng Nghĩa', '342578964', 'nghia@gmail.com', 'nghia123', '2023-11-27 00:00:00', 'Bình Thường',
        'r1');
INSERT INTO `user` (`id`, `name`, `phoneNumber`, `email`, `password`, `createDate`, `status`, `roleId`)
VALUES ('u6', 'Trần Văn Long', '248795354', 'long@gmail.com', 'long123', '2023-11-27 00:00:00', 'Bình Thường', 'r1');
INSERT INTO `user` (`id`, `name`, `phoneNumber`, `email`, `password`, `createDate`, `status`, `roleId`)
VALUES ('u7', 'Nguyễn Hải Bánh', '478545562', 'banh@gmail.com', 'banh123', '2023-11-28 00:00:00', 'Bình Thường', 'r1');
INSERT INTO `user` (`id`, `name`, `phoneNumber`, `email`, `password`, `createDate`, `status`, `roleId`)
VALUES ('u8', 'Lê Phú', '478523562', 'phu@gmail.com', 'phu123', '2023-11-28 00:00:00', 'Bình Thường', 'r1');
INSERT INTO `user` (`id`, `name`, `phoneNumber`, `email`, `password`, `createDate`, `status`, `roleId`)
VALUES ('u9', 'Trần Long Ân', '245251511', 'an@gmail.com', 'an123', '2023-11-29 00:00:00', 'Bình Thường', 'r1');
INSERT INTO `user` (`id`, `name`, `phoneNumber`, `email`, `password`, `createDate`, `status`, `roleId`)
VALUES ('u10', 'Lê Bá Phụng', '245278954', 'lebatrong2003@gmail.com', 'phung123', '2023-11-30 00:00:00', 'Bình Thường',
        'r1');

/* ORDER */
INSERT INTO `order` (`id`, `totalPrice`, `orderDate`, `status`, `address`, `shippingFee`, `userId`)
VALUES ('OD1', 218000.00, '2023-11-29 00:00:00', 'Đang giao', '29 Tô Vĩnh Diện , Đông Hòa ,Dĩ An , Bình Dương', 30.00,
        'u1');
INSERT INTO `order` (`id`, `totalPrice`, `orderDate`, `status`, `address`, `shippingFee`, `userId`)
VALUES ('OD10', 322000.00, '2023-12-01 00:00:00', 'Đang xử lý', '314 Âu Cơ, TT, Tân Châu, Tân Châu, An Giang', 30.00,
        'u9');
INSERT INTO `order` (`id`, `totalPrice`, `orderDate`, `status`, `address`, `shippingFee`, `userId`)
VALUES ('OD11', 78000.00, '2023-12-02 00:00:00', 'Thành công', '31 Trần Phú, P, Mộ Lao, Hà Đông, Hà Nội', 50.00, 'u6');
INSERT INTO `order` (`id`, `totalPrice`, `orderDate`, `status`, `address`, `shippingFee`, `userId`)
VALUES ('OD12', 117000.00, '2023-12-02 00:00:00', 'Đã hủy', '18 Phan Văn Trị, Khuê Trung, Cẩm Lệ, Đà Nẵng', 40.00,
        'u10');
INSERT INTO `order` (`id`, `totalPrice`, `orderDate`, `status`, `address`, `shippingFee`, `userId`)
VALUES ('OD13', 1103000.00, '2023-12-02 00:00:00', 'Đang xử lý', '312 Trường Chinh, Nhơn Hưng, An Nhơn, Bình Định',
        40.00, 'u2');
INSERT INTO `order` (`id`, `totalPrice`, `orderDate`, `status`, `address`, `shippingFee`, `userId`)
VALUES ('OD14', 104000.00, '2023-12-02 00:00:00', 'Đang xử lý',
        '416 Phạm Văn Đồng, Phường 11, Bình Thạnh, Thành phố Hồ Chí Minh', 30.00, 'u3');
INSERT INTO `order` (`id`, `totalPrice`, `orderDate`, `status`, `address`, `shippingFee`, `userId`)
VALUES ('OD2', 1235000.00, '2023-11-29 00:00:00', 'Đang giao',
        '416 Phạm Văn Đồng, Phường 11, Bình Thạnh, Thành phố Hồ Chí Minh', 30.00, 'u3');
INSERT INTO `order` (`id`, `totalPrice`, `orderDate`, `status`, `address`, `shippingFee`, `userId`)
VALUES ('OD3', 649000.00, '2023-11-30 00:00:00', 'Đang giao', '312 Trường Chinh, Nhơn Hưng, An Nhơn, Bình Định', 40.00,
        'u2');
INSERT INTO `order` (`id`, `totalPrice`, `orderDate`, `status`, `address`, `shippingFee`, `userId`)
VALUES ('OD4', 349000.00, '2023-11-30 00:00:00', 'Đang giao',
        '32 Đ, Mạc Đĩnh Chi, Đa Kao, Quận 1, Thành phố Hồ Chí Minh', 30.00, 'u4');
INSERT INTO `order` (`id`, `totalPrice`, `orderDate`, `status`, `address`, `shippingFee`, `userId`)
VALUES ('OD5', 117000.00, '2023-11-30 00:00:00', 'Đang giao',
        '312 Đường Võ Nguyên Giáp, Thiện Nghiệp, Thành phố Phan Thiết, Bình Thuận', 40.00, 'u5');
INSERT INTO `order` (`id`, `totalPrice`, `orderDate`, `status`, `address`, `shippingFee`, `userId`)
VALUES ('OD6', 780000.00, '2023-11-30 00:00:00', 'Đang giao', '31 Trần Phú, P, Mộ Lao, Hà Đông, Hà Nội', 50.00, 'u6');
INSERT INTO `order` (`id`, `totalPrice`, `orderDate`, `status`, `address`, `shippingFee`, `userId`)
VALUES ('OD7', 240000.00, '2023-12-01 00:00:00', 'Đang giao', '29 Tô Vĩnh Diện , Đông Hòa ,Dĩ An , Bình Dương', 30.00,
        'u1');
INSERT INTO `order` (`id`, `totalPrice`, `orderDate`, `status`, `address`, `shippingFee`, `userId`)
VALUES ('OD8', 649000.00, '2023-12-01 00:00:00', 'Đang giao', '15 Trường Chinh, Phước Trung, Bà Rịa, Bà Rịa - Vũng Tàu',
        30.00, 'u8');
INSERT INTO `order` (`id`, `totalPrice`, `orderDate`, `status`, `address`, `shippingFee`, `userId`)
VALUES ('OD9', 404000.00, '2023-12-01 00:00:00', 'Đang giao',
        '21 Võ Trường Toản, An Phú, Quận 2, Thành phố Hồ Chí Minh', 30.00, 'u7');


/* ORDER DETAILS */

INSERT INTO `order_details` (`orderId`, `productId`, `quantity`)
VALUES ('OD1', 'P01', 2);
INSERT INTO `order_details` (`orderId`, `productId`, `quantity`)
VALUES ('OD1', 'P05', 2);
INSERT INTO `order_details` (`orderId`, `productId`, `quantity`)
VALUES ('OD10', 'P111', 1);
INSERT INTO `order_details` (`orderId`, `productId`, `quantity`)
VALUES ('OD10', 'P37', 1);
INSERT INTO `order_details` (`orderId`, `productId`, `quantity`)
VALUES ('OD11', 'P24', 1);
INSERT INTO `order_details` (`orderId`, `productId`, `quantity`)
VALUES ('OD11', 'P66', 1);
INSERT INTO `order_details` (`orderId`, `productId`, `quantity`)
VALUES ('OD12', 'P01', 3);
INSERT INTO `order_details` (`orderId`, `productId`, `quantity`)
VALUES ('OD13', 'P30', 2);
INSERT INTO `order_details` (`orderId`, `productId`, `quantity`)
VALUES ('OD13', 'P40', 1);
INSERT INTO `order_details` (`orderId`, `productId`, `quantity`)
VALUES ('OD14', 'P35', 2);
INSERT INTO `order_details` (`orderId`, `productId`, `quantity`)
VALUES ('OD2', 'P07', 1);
INSERT INTO `order_details` (`orderId`, `productId`, `quantity`)
VALUES ('OD2', 'P115', 1);
INSERT INTO `order_details` (`orderId`, `productId`, `quantity`)
VALUES ('OD2', 'P90', 1);
INSERT INTO `order_details` (`orderId`, `productId`, `quantity`)
VALUES ('OD3', 'P50', 1);
INSERT INTO `order_details` (`orderId`, `productId`, `quantity`)
VALUES ('OD4', 'P58', 1);
INSERT INTO `order_details` (`orderId`, `productId`, `quantity`)
VALUES ('OD4', 'P94', 2);
INSERT INTO `order_details` (`orderId`, `productId`, `quantity`)
VALUES ('OD5', 'P24', 3);
INSERT INTO `order_details` (`orderId`, `productId`, `quantity`)
VALUES ('OD6', 'P10', 1);
INSERT INTO `order_details` (`orderId`, `productId`, `quantity`)
VALUES ('OD6', 'P23', 1);
INSERT INTO `order_details` (`orderId`, `productId`, `quantity`)
VALUES ('OD7', 'P66', 1);
INSERT INTO `order_details` (`orderId`, `productId`, `quantity`)
VALUES ('OD8', 'P45', 1);
INSERT INTO `order_details` (`orderId`, `productId`, `quantity`)
VALUES ('OD9', 'P100', 1);


/* RATE */

INSERT INTO `rate` (`productId`, `userId`, `starRatings`, `comment`, `createDate`)
VALUES ('P02', 'u1', 4, 'Sản phẩm tốt', '2023-11-29 00:00:00');
INSERT INTO `rate` (`productId`, `userId`, `starRatings`, `comment`, `createDate`)
VALUES ('P04', 'u1', 5, 'Thiếp đẹp mắt và rất phù hợp', '2023-12-03 00:00:00');
INSERT INTO `rate` (`productId`, `userId`, `starRatings`, `comment`, `createDate`)
VALUES ('P07', 'u4', 5, 'Sản phẩm chất liệu tốt và rất đẹp', '2023-12-01 00:00:00');
INSERT INTO `rate` (`productId`, `userId`, `starRatings`, `comment`, `createDate`)
VALUES ('P101', 'u7', 3, 'Sản phẩm ổn không quá xuất sắc!', '2023-12-02 00:00:00');
INSERT INTO `rate` (`productId`, `userId`, `starRatings`, `comment`, `createDate`)
VALUES ('P119', 'u9', 5, 'Không có gì để chê sản phẩm này !', '2023-12-03 00:00:00');
INSERT INTO `rate` (`productId`, `userId`, `starRatings`, `comment`, `createDate`)
VALUES ('P12', 'u5', 5, 'Khung ảnh đẹp và tốt lắm ! 10điểm cho shop', '2023-12-01 00:00:00');
INSERT INTO `rate` (`productId`, `userId`, `starRatings`, `comment`, `createDate`)
VALUES ('P124', 'u9', 5, 'Quá ưng ý với sản phẩm này!', '2023-12-03 00:00:00');
INSERT INTO `rate` (`productId`, `userId`, `starRatings`, `comment`, `createDate`)
VALUES ('P34', 'u3', 5, 'Sản phẩm quá đẹp rất hợp ý tôi!', '2023-11-29 00:00:00');


/* BannerItems */
CREATE TABLE `handmadestore`.`banner_items`
(
    `title`       varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `img_path`    text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`title`) USING BTREE

) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

/* Tips */
CREATE TABLE `handmadestore`.`tips`
(
    `title`       varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  NOT NULL,
    `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `img_path`    text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `video_link`  varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`title`) USING BTREE

) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

/* Insert data for Banner Items and Tips */
INSERT INTO `banner_items` (`title`, `description`, `img_path`)
VALUES ('KÍNH CHÀO QUÝ KHÁCH', 'Mỗi sản phẩm từ HandmadeStore là một phần trái tim của ai đó',
        'images/banner_items/item_1.jpg'),
       ('Độc - Đẹp - Bền - Giá Phù Hợp', 'Chế tạo những sản phẩm độc đáo, với tình yêu và sự tận tụy',
        'images/products/item_2.jpg'),
       ('CÙNG NHAU KHÁM PHÁ NÀO!', 'Những sản phẩm đang nóng lòng đợi bạn rinh về nè !', 'images/products/item_3.jpg');
INSERT INTO `tips` (`title`, `description`, `img_path`, `video_link`)
VALUES ('Cách cắm hoa khô đẹp trong 5 phút', 'Hoa khô hay còn gọi là hoa không tàn, hoa vĩnh cửu luôn có nét đẹp riêng,
Để tăng thêm sự độc đáo và giá trị thì cách cắm hoa...',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZ8lBiigy5MW1j56PFstMcdXypVGCGOI3rKQ&usqp=CAU',
        'https://youtu.be/t4Sjrj0MvUg'),
       ('Cách làm trang trí thiệp hoa khô handmade siêu dễ', 'Thiệp hoa khô tự nhiên có nét quyến rũ thú vị, thể hiện sự chỉnh chu của người tặng,
Tự tay làm chiếc thiệp hoa khô sẽ thật ý nghĩa...',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqeUKERx8fXxdyGuVP0PEfBoiHJr3FtIagLg&usqp=CAU',
        'https://youtu.be/eA_cUtEO6zA'),
       ('Hướng dẫn cách làm scrapbook album ảnh handmade siêu đơn giản', 'Scrapbook là một dạng nhật ký ảnh, album hình được làm, trang trí thủ công có nội dung ,
câu chuyện hoàn chỉnh,Thời gian, sự kiện được ghi chú...',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrTXzfl_2PiSjlmKrTX97ftDQdz_eZpWBThA&usqp=CAU',
        'https://youtu.be/U3kAyqvfWoc');
/* insert logo, background */
INSERT INTO `image` (`id`, `name`, `path`)
VALUES ('logo', 'Logo', 'images/logo.png');
INSERT INTO `image` (`id`, `name`, `path`)
VALUES ('bg', 'Background', 'images/background.jpg');