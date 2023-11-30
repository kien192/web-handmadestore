----------------DATABASE

CREATE TABLE category (
id varchar(6),
name nvarchar(40)
CONSTRAINT pk_category PRIMARY KEY (id)

)

CREATE TABLE product (
id varchar(6) not null ,
name Nvarchar(40),
description text,
costPrice decimal,
sellingPrice decimal,
quantity int,
[status] Nvarchar(15),
categoryId varchar(6) not null,
discountId varchar(6) ,
CONSTRAINT pk_product PRIMARY KEY (id) ,
 CONSTRAINT fk_product1 FOREIGN KEY (categoryId) references dbo.category(id)

 )

 
CREATE TABLE [role] (
id varchar(6),
name nvarchar(15),

CONSTRAINT pk_role PRIMARY KEY (id),

)


 CREATE TABLE [user] (
id varchar(6) not null ,
name Nvarchar(40),
phoneNumber varchar(12),
email varchar(30),
password varchar(30),
createDate datetime,
[status] varchar(10),
roleId varchar(6) not null,
CONSTRAINT pk_user PRIMARY KEY (id) ,
 CONSTRAINT fk_user FOREIGN KEY (roleId) references dbo.role(id)

 )


CREATE TABLE [image] (
id varchar(6),
name nvarchar(40),
filePath text,
productId varchar(6)
CONSTRAINT pk_image PRIMARY KEY (id),
CONSTRAINT fk_image FOREIGN KEY (productId) references dbo.product(id)

)


CREATE TABLE discount (
id varchar(6),
name nvarchar(30),
startDate DATETIME,
endDate DATETIME,
percentageOff DECIMAL default 0
CONSTRAINT pk_discount PRIMARY KEY (id),
)


CREATE TABLE order_details (
orderId varchar(6),
productId nvarchar(6),
quantity INT,
CONSTRAINT pk_od PRIMARY KEY (orderId,productId)

)


CREATE TABLE [order] (
id varchar(6),
totalPrice decimal,
orderDate datetime,
[status] nvarchar(20),
[address] nvarchar(80) ,
shippingFee decimal,
userId varchar(6)

CONSTRAINT pk_order PRIMARY KEY (id) ,
 CONSTRAINT fk_order FOREIGN KEY (userId) REFERENCES dbo.user(id)


)

CREATE TABLE rate (
productId varchar(6),
userId varchar(6),
starRatings int,
comment text,
createDate dateTime default CURRENT_TIMESTAMP

CONSTRAINT pk_order PRIMARY KEY (productId, userId) ,
)

--INSERT VALUES PRODUCT

INSERT INTO product 
VALUES ('P01', N'Thiệp HandMade vintage Beauty & the White', 'Mẫu thiệp BEAUTY & THE WHITE được lấy cảm hứng từ câu chuyện Beauty & the Beast, nét đẹp từ sự tương phản;
Kích thước lớn hơn thông thường: 11x18cm, gồm bì thư, giấy viết thông điệp và thiệp;
Chủ đề có sẵn: chúc mừng sinh nhật, valentine, 8/3, 20/10, 20/11;
Liên lạc ngay với Craft & More Vietnam nếu bạn muốn làm thiệp theo chủ đề riêng;
Thiệp làm handmade tỉ mỉ với vật liệu giấy cứng, giấy mỹ thuật, hoa lá cỏ khô... rất thân thiện môi trường;
Tùy biến kích thước, câu chữ, logo cho nhóm, công ty, đoàn thể...
Lưu ý: Thiệp được làm thủ công-handmade với các vật liệu hoa, lá, cỏ, giấy... nên các chi tiết có thể khác đôi chút cho từng sản phẩm nhưng phong cách (concept) luôn thống nhất theo các mẫu.',
50000, 70000,35, N'Có sẵn', 'C01', 'DC01')

INSERT INTO product VALUES ('P02',N'Thiệp handmade Film de Paris','Mẫu thiệp chúc mừng FILM de PARIS đậm chất retro, vintage hoài cổ;
Kích thước lớn hơn thông thường: 11x18cm, gồm bì thư, giấy viết thông điệp và thiệp;
Chủ đề có sẵn: chúc mừng sinh nhật, valentine, 8/3, 20/10, 20/11;
Liên lạc ngay với Craft & More Vietnam nếu bạn muốn làm thiệp theo chủ đề riêng;
Thiệp làm handmade tỉ mỉ với vật liệu giấy cứng, giấy mỹ thuật, hoa lá cỏ khô... rất thân thiện môi trường;
Tùy biến kích thước, câu chữ, logo cho nhóm, công ty, đoàn thể...
Lưu ý: Thiệp được làm thủ công-handmade với các vật liệu hoa, lá, cỏ, giấy...
nên các chi tiết có thể khác đôi chút cho từng sản phẩm nhưng phong cách (concept) luôn thống nhất theo các mẫu.',55000,70000,21,N'Còn hàng',
'C01', 'DC01')

INSERT INTO product VALUES ('P03',N'Thiệp chúc mừng Sweet Mint','Mẫu thiệp SWEET MINT - ngọt ngào như viên kẹo bạc hà!
Kích thước lớn hơn thông thường: 11x18cm, gồm bì thư, giấy viết thông điệp và thiệp;
Chủ đề có sẵn: chúc mừng sinh nhật, valentine, 8/3, 20/10, 20/11;
Liên lạc ngay với Craft & More Vietnam nếu bạn muốn làm thiệp theo chủ đề riêng;
Thiệp làm handmade tỉ mỉ với vật liệu giấy cứng, giấy mỹ thuật, hoa lá cỏ khô... rất thân thiện môi trường;
Tùy biến kích thước, câu chữ, logo cho nhóm, công ty, đoàn thể...
Lưu ý: Thiệp được làm thủ công-handmade với các vật liệu hoa, lá, cỏ, giấy... nên các chi tiết có thể khác đôi chút cho từng sản phẩm nhưng phong cách (concept) luôn thống nhất theo các mẫu.',50000,70000,24,N'Còn hàng','C01','DC01')
INSERT INTO product VALUES ('P04',N'Thiệp chúc mừng Black & White','Trắng - đen luôn có nét đẹp riêng, mẫu thiệp mang đậm phong cách vintage, hoài cổ & màu sắc tối giản nhưng cá tính với nền là giấy kraft cứng đen kết hợp die cut được sắp xếp hài hòa.
Kích thước: 11x14cm.
Gồm bì thư, giấy viết thông điệp và thiệp.
Thiệp được làm handmade tỉ mỉ, chỉn chu.
Thiệp phù hợp với nhiều dịp tặng 14/2 Valentine, 8/3, 20/10, 20/11, Noel Giáng Sinh...',24000,39000,15,N'Còn hàng','C01','DC01')
INSERT INTO product VALUES ('P05',N'Thiệp handmade Amazing Carton','Mẫu thiệp AMAZING CARTON cảm hứng từ những tấm bìa cứng thô ráp!
Kích thước: 9x14cm;
Chủ đề có sẵn: chúc mừng sinh nhật, valentine, 8/3, 20/10, 20/11;
Liên lạc ngay với Craft & More Vietnam nếu bạn muốn làm thiệp theo chủ đề riêng;
Thiệp làm handmade tỉ mỉ với vật liệu giấy cứng, giấy mỹ thuật, hoa lá cỏ khô... rất thân thiện môi trường;
Tùy biến kích thước, câu chữ, logo cho nhóm, công ty, đoàn thể...
Lưu ý: Thiệp được làm thủ công-handmade với các vật liệu hoa, lá, cỏ, giấy... nên các chi tiết có thể khác đôi chút cho từng sản phẩm nhưng phong cách (concept) luôn thống nhất theo các mẫu.',24000,39000,5,N'Còn hàng','C01','DC01')
INSERT INTO product VALUES ('P06',N'Thiệp handmade lớn Beauty & the White','Kích thước 11x18cm
Chất liệu giấy mỹ thuật cao cấp
Chủ đề đa dạng, tùy biến
Phù hợp với hầu hết các đối tượng, các dịp như 8/3, 20/10, 20/11, sinh nhật, chúc mừng...',50000,70000,13,N'Còn hàng','C01','DC01')
INSERT INTO product VALUES ('P07',N'Thiệp da bò độc đáo','Kích thước: 10x13.5cm

- Chất liệu da bò chọn lọc, charm đồng, giấy dó

- Tùy biến theo ý riêng: theo mục đích tặng (sinh nhật, 20/11, 20/10, 8/3, valentine 14/2, giáng sinh v.v...) hoặc thay đổi hoàn toàn thông điệp theo ý riêng.',30000,50000,19,N'Còn hàng','C01','DC01')
INSERT INTO product VALUES ('P08',N'Thiệp dấu sáp mini','Thiệp mini đơn giản nhưng đẹp!

Thiệp làm & đóng sáp thủ công handmade;

Kích thước 6x9cm, gồm giấy viết thông điệp bên trong thiệp;

Vật liệu: giấy craft, sáp đóng dấu, dây thừng, giấy mỹ thuật',7000,19000,40,N'Còn hàng','C01','DC01')
INSERT INTO product VALUES ('P09',N'Thiệp handmade Vintage Film','Kích thước: 10x14.5cm

- Chất liệu giấy mỹ thuật đặc biệt, charm đồng

- Sản phẩm gồm thiệp, tấm giấy ghi thông điệp, bì thư vintage

- Tùy biến theo ý riêng: theo mục đích tặng (sinh nhật, 20/11, 20/10, 8/3, valentine 14/2, giáng sinh v.v...) hoặc thay đổi hoàn toàn 
thông điệp theo ý riêng.',15000,39000,50,N'Còn hàng','C01','DC01')

INSERT INTO product VALUES ('P10',N'Thiệp handmade vintage vải bố','- Kích thước: 10x14.5cm

- Chất liệu vải bố nâu, charm đồng, giấy dó

- Tùy biến theo ý riêng: theo mục đích tặng (sinh nhật, 20/11, 20/10, 8/3, valentine 14/2, giáng sinh v.v...) hoặc thay đổi hoàn 
toàn thông điệp theo ý riêng.',18500,39000,34,N'Còn hàng','C01','DC01')
INSERT INTO product VALUES ('P11',N'Thiệp gỗ Jigsaws','Khắc thông điệp theo ý riêng

- Kích thước: 10x14.5cm

- Chất liệu gỗ polywood

- Sản phẩm gồm thiệp, tấm giấy ghi thông điệp, bì thư vintage

- Tùy biến theo ý riêng: theo mục đích tặng (sinh nhật, 20/11, 20/10, 8/3, valentine 14/2, giáng sinh v.v...) hoặc thay đổi hoàn toàn thông
điệp theo ý riêng.',20100,39000,49,N'Còn hàng','C01','DC01')

INSERT INTO product VALUES ('P12',N'Thiệp gỗ Other Half','- Kích thước: 10x14.5cm

- Chất liệu gỗ polywood

- Sản phẩm gồm thiệp, tấm giấy ghi thông điệp, bì thư vintage

- Tùy biến theo ý riêng: theo mục đích tặng (sinh nhật, 20/10, 8/3, valentine 14/2, giáng sinh, annivesary...) hoặc thay đổi hoàn toàn thông điệp
theo ý riêng.',17800,39000,40,N'Còn hàng','C01','DC01')

INSERT INTO product VALUES ('P13',N'Thiệp chúc mừng handmade Blue Pastel','- Kích thước: 10x14.5cm

- Chất liệu giấy mỹ thuật đặc biệt, charm đồng

- Sản phẩm gồm thiệp, tấm giấy ghi thông điệp, bì thư vintage

- Tùy biến theo ý riêng: theo mục đích tặng (sinh nhật, 20/11, 20/10, 8/3, valentine 14/2, giáng sinh v.v...) hoặc thay đổi hoàn toàn thông điệp
theo ý riêng.',23000,39000,37,N'Còn hàng','C01','DC01')

INSERT INTO product VALUES ('P14',N'Thiệp vintage Retro Clock','- Kích thước: 10x14.5cm

- Chất liệu giấy mỹ thuật đặc biệt, charm đồng

- Sản phẩm gồm thiệp, tấm giấy ghi thông điệp, bì thư vintage

- Tùy biến theo ý riêng: theo mục đích tặng (sinh nhật, 20/11, 20/10, 8/3, valentine 14/2, giáng sinh v.v...) hoặc thay đổi hoàn toàn thông điệp 
theo ý riêng.',17000,30000,25,N'Còn hàng','C01','DC01')

INSERT INTO product VALUES ('P15',N'Thiệp giấy carton handmade - Thiệp chúc mừng sinh nhật','Thiệp làm handmade tỉ mỉ lấy cảm hứng từ những tấm carton thô ráp, kết hợp với hoa lá cỏ khô tạo thành mẫu thiệp đẹp, độc đáo.

Có thể thay đổi chủ đề theo yêu cầu.

Kích thước: 11x14cm.',28900,49000,19,N'Còn hàng','C01','DC01')
INSERT INTO product VALUES ('P16',N'Thiệp tặng bạn thân - Thiệp vintage retro',
'Thiệp tặng bạn thân - Thiệp vintage retro Là một trong những mẫu thiệp
handmade cổ điển, HeadQuarter giúp bạn trở về lại với những giá trị tinh thần mà nhiều khi sống giữa thời đại công nghệ chúng...'
,16500,49000,11,N'Còn hàng','C01','DC01')
INSERT INTO product VALUES ('P17',N'Giấy viết thư cổ điển Vintage',
'- Giấy viết thư cổ điển hoa văn vintage Mang dáng dấp cổ điển độc đáo, những tờ giấy viết thư đầy cảm xúc sẽ là của bạn với những thiết kế độc đáo,
cổ điển Vintage lạ mắt. Giấy viết thư...',17900,35000,34,N'Còn hàng','C01','DC01')
INSERT INTO product VALUES ('P18',N'Khung ảnh đẹp Frame Triple','
Bộ khung ảnh ba đẹp Bộ ba khung ảnh thiết kế với gỗ mộc mạc, mang phong cách Vintage độc đáo, thiết kế bộ ba, sử dụng trang trí được cả hai mặt tương
đương với 6 bức hình. Khung ảnh bộ...',145000,377000,20,N'Còn hàng','C01','DC01')
INSERT INTO product VALUES ('P19',N'Khung ảnh frame 6 in 1',
'Khung ảnh frame gỗ trang trí Cực xinh xắn và tiện dụng với bộ khung ảnh frame theo phong cách Vintage ấn tượng: + Bộ sản phẩm 
tiện dụng với bộ khung gỗ, gắn móc khóa, đồng hồ và khung ảnh kích thước 53...',950000,1337000,10,N'Còn hàng','C01','DC01')
INSERT INTO product VALUES ('P20',N'Khung ảnh gỗ 3 in 1',
'Thiết kế cực sang trọng với màu trắng làm chủ đạo, phù hợp với mọi không gian trong căn nhà bạn',475000,630000,10,N'Còn hàng','C01','DC01')
INSERT INTO product VALUES ('P21',N'Khung ảnh, tủ móc khóa, móc treo 3 in 1','Kích thước: 21x28cm;
Chất liệu: gỗ;',134000,347000,0,N'Ngưng bán','C01','DC01')
INSERT INTO product VALUES ('P22',N'Khung hình vintage triple cỡ lớn','Kích thước khung 57x31cm; cỡ hình 10x15cm; trọng lượng 1.38kg;
Chất liệu: gỗ, thiết kế hoài cổ, vintage, cá tính.',376000,519000,6,N'Còn hàng','C01','DC01')
INSERT INTO product VALUES ('P23',N'Khung ảnh handmade - thiệp handmade đẹp 2 in 1',
'Sản phẩm được thiết kế cá tính và đậm chất Vintage cổ xưa sẽ là sản phẩm độc đáo dành cho bạn có nhu cầu lưu giữ những tấm ảnh "hay ho" hay 
ghi lại khoảnh khắc đáng nhớ. Bạn có thể dán hình hoặc câu chữ yêu thích đặt vào khung hình.',13000,29000,0,N'Ngưng bán','C01','DC01')
INSERT INTO product VALUES ('P24',N'Khung ảnh kiểu Địa Trung Hải',
'Mang nắng, gió và biển Địa Trung Hải vào thiết kế không gian của bạn đơn giản chỉ với chiếc khung ảnh này. Kích thước: 19 x 23cm; 
Chất liệu: gỗ thông đẹp và bền bỉ.',106000,189000,24,N'Còn hàng','C01','DC01')
INSERT INTO product VALUES ('P25',N'Khung ảnh vintage kiểu US Army',
'Bằng chất liệu kim loại, gỗ cùng một chút sáng tạo, khung ảnh US Army sẽ là điểm nhấn cho không gian thêm phần khác lạ.
Kích thước khung 1 x 23 x 28cm; cỡ hình 10 x 15cm;',98000,167000,21,N'Còn hàng','C01','DC01')
INSERT INTO product VALUES ('P26',N'Khung ảnh vintage trắng ngà',
'Khung hình thiết kế đơn giản, đẹp, tinh tế, nhẹ nhàng với tông màu trắng. Kích thước lần lượt cho các khổ ảnh 9x9cm giá 105k;
9x13cm giá 162k; 10x15cm giá 173k; 13x18cm giá 197k.',88000,97000,16,N'Còn hàng','C01','DC01')
INSERT INTO product VALUES ('P27',N'Khung ảnh - móc treo FISH HOOK','Kích thước: 55x4x20cm;
Chất liệu: gỗ, dây thừng
Khung 3 ảnh 6x9cm được làm thủ công tỉ mỉ',204000,379000,0,N'Ngưng bán','C01','DC01')
INSERT INTO product VALUES ('P28',N'Khung ảnh gỗ và thạch cao Ivory Vintage','Khung ảnh gỗ và thạch cao Ivory Vintage ấn tượng Chất liệu gỗ và thạch 
cao hòa quyện cùng sự sáng tạo độc đáo đã cho ra đời sản phẩm khung ảnh độc đáo Ivory Vintage. Kích thước sản phẩm: 4 x...'
,219000,349000,5,N'Còn hàng','C01','DC01')
INSERT INTO product VALUES ('P29',N'Khung ảnh Hải  u Mediterranean','Chất liệu: gỗ;
Kích thước khung 18x23cm; khổ hình 10x15cm;',101000,189000,1,N'Tạm hết hàng','C01','DC01')
INSERT INTO product VALUES ('P30',N'Khung ảnh Địa Trung Hải Kayak',
'Thiết kế thuyền kayak độc đáo, hiện đại và khác biệt, chiếc khung ảnh Địa Trung Hải này như một chút biến tấu cho không gian của bạn thêm sự mới lạ.
Kích thước sản phẩm: 15 x 26cm, được làm bằng chất liệu: gỗ, thừng, thạch cao, sò biển...',96000,167000,0,N'Tạm hết hàng','C01','DC01')
INSERT INTO product VALUES ('P31',N'Khung ảnh vintage hoa văn vuông','
Cổ điển và ấn tượng, chiếc khung ảnh Vintage mang hơi thở hoài cổ nhẹ nhàng và ấn tượng. Chất liệu: gỗ, kích thước khung 18 x 22cm; cỡ hình 10 x 15cm.'
,104000,150000,0,N'Ngưng bán','C01','DC01')
INSERT INTO product VALUES ('P32',N'Khung ảnh mèo Totoro',
'Khung ảnh mèo Totoro Mang nét mộc mạc đơn sơ nhưng cực kì xinh xắn, với khung ảnh mèo Totoro, sự đơn giản từ chiếc khung ảnh có thể làm nổi bật 
lên tấm hình mà bạn muốn trưng cho không...',65000,84000,3,N'Còn hàng','C01','DC01')
INSERT INTO product VALUES ('P33',N'Khung ảnh Staring time (lớn)',
'Khung ảnh gỗ đẹp Staring time Không chỉ là chiếc khung ảnh gỗ, mà nó còn là kỉ vật thời gian gắn bó với rất nhiều người, do đó, một chiếc khung ảnh
luôn là món đồ vật được trân trọng,...',145000,212000,2,N'Còn hàng','C01','DC01')
INSERT INTO product VALUES ('P34',N'Khung ảnh gỗ thông Rustic',
'Khung ảnh Rustic cỡ lớn Những điều ý nghĩa, những kỷ niệm đẹp hãy lưu lại và trân trọng điều đó bởi đó là những điều sẽ đi suốt cuộc đời của bạn.
Chính vì thể hãy giữ cho những bức...',179000,227000,15,N'Còn hàng','C01','DC01')
INSERT INTO product VALUES ('P35',N'Khung ảnh Hải  u Mediterranean',
'Quà tặng khung ảnh Hải  u Mediterranean Chất liệu: gỗ; Kích thước khung 18x23cm; khổ hình 10x15cm; '
,125000,189000,13,N'Còn hàng','C01','DC01')
INSERT INTO product VALUES ('P36',N'Khung trang trí bàn hoa hồng sứ C-rose frame',
'Phong cách "mộc" ấn tượng cho khung trang trí để bàn C-rose. Ngoài việc trang trí, khung trang trí còn là điểm nhấn phong thủy độc đáo cho nội thất 
của bạn. Khung trang trí để bàn hoa hồng Kích thước:13,9 x...',241000,317000,18,N'Còn hàng','C01','DC01')
INSERT INTO product VALUES ('P37',N'KHUNG ẢNH NGÔI NHÀ CỬA SỔ N U (NGANG)','KÍCH THƯỚC: 24.5 * 20.5cm
Chất liệu: Gỗ',178000,240000,4,N'Còn hàng','C01','DC01')
INSERT INTO product VALUES ('P38',N'KHUNG ẢNH NGÔI NHÀ XE ĐẠP','KÍCH THƯỚC: 19*26.5cm
Chất liệu: Gỗ',178000,240000,1,N'Tạm hết hàng','C01','DC01')
INSERT INTO product VALUES ('P39',N'KHUNG ẢNH VÒNG ĐU QUAY VINTAGE','Khung ảnh vòng đu quay vintage 2
Kích thước: 33 x 18.5 cm
Chất liệu: kim loại',450000,780000,14,N'Còn hàng','C01','DC01')
INSERT INTO product VALUES ('P40',N'Bì thư vintage Tem Việt', 'BÌ THƯ VINTAGE CỔ ĐIỂN  Bao thư với phong cách vintage thích hợp cho bạn nếu yêu thích
những phong cách retro đặc biệt ấn tượng này. Bạn có thể sử dụng để làm quà tặng hoặc để trang trí đều...',19000,35000,12,N'Còn hàng','C01','DC01')
INSERT INTO product VALUES ('P41',N'Scrapbook That Time','- Kích thước 21x21x5cm;

- Trang trí được 30-50 ảnh đủ các kích thước 4x6cm đến 13x18cm;

- Sản phẩm được làm thủ công, chăm chút từng chi tiết nhỏ; scrapbook có phong cách, màu sắc đậm chất vintage, hoài cổ rất được yêu thích;

- Scrapbook có thể thiết kế, tùy biến chủ đề theo ý riêng.',450000,649000,10,N'Còn hàng','C01','DC01')
INSERT INTO product VALUES ('P42',N'Scrapbook Sweet Mint','- Kích thước 21x21x5cm

- Trang trí được 30-50 ảnh đủ các kích thước 4x6cm đến 13x18cm

- Sản phẩm được làm thủ công, chăm chút từng chi tiết nhỏ

- Scrapbook có thể thiết kế, tùy biến chủ đề theo ý riêng',450000,649000,8,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P43',N'Scrapbook Fly That Time','- Kích thước 14.5 x 21.5 x 5cm

- Trang trí được 30 ảnh 6x9cm

- Sản phẩm được làm handmade tỉ mỉ từng chi tiết nhỏ',104000,329000,13,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P44',N'Album ảnh handmade Fly Sweet Mint'   ,'- Sản phẩm được làm handmade chăm chút tỉ mỉ

- Kích thước 14.5 x 21.5 x 5cm

- Trang trí được 30 hình 6x9cm

- Có thể tùy biến, thiết kế chủ đề theo yêu cầu riêng',104000,329000,16,N'Còn hàng','C02','DC01')

INSERT INTO product VALUES ('P45',N'Album ảnh tự trang trí Love Story (Xanh)','Màu xanh Vintage huyền bí cùng thiết kế theo phong cách Vintage đầy 
bí ẩn sẽ làm cuốn album của bạn thêm thu hút và độc đáo.',147000,220000,24,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P46',N'Scrapbook Retro Clock','- Màu sắc: Nâu - trắng.

- Kích thước: 20 x 20cm.

- Chất liệu: Giấy cứng cao cấp, được trang trí hoàn toàn bằng tay (100% handmade).

- Số trang: 11, có thể dán được 40-60 hình các size khác nhau.',402000,649000,1,N'Tạm hết hàng','C02','DC01')
INSERT INTO product VALUES ('P47',N'Scrapbook Vintage','Scrapbook handmade cao cấp đậm chất vintage Just be me Quyển scrapbook (một dạng 
sổ ảnh handmade) được làm thủ công với thiết kế hoàn toàn khác biệt, chắc chắn, chứa được nhiều hình hơn so với các scrapbook khác. Màu...'
,1350000,1620000,4,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P48',N'Scrapbook Lò Xo Handmade Phong Cách Retro Độc Đáo', '✔ Kích thước: 20 x 21cm

️ ✔ Các size ảnh: 4x6, 6x9, 9x12

️ ✔ 16 trang giấy cứng và các họa tiết trang trí ấn tượng.

️ ✔ Tối đa 47 tấm hình. Có nhiều lớp được xếp chồng lên nhau và kéo thả để hiển thị hình ảnh.',400000,549000,9,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P49',N'Album ảnh handmade Blue Pastel','Màu sắc chủ đạo: Trắng - Xanh Rustic/Pastel nhẹ nhàng.

- Kích thước: 20 x 20cm.

- Chất liệu: Giấy cứng cao cấp, được trang trí hoàn toàn bằng tay (100% handmade).

- Số trang: 11, có thể dán được 40-60 hình các size khác nhau.',400000,649000,14,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P50',N'Scrapbook My Boy For The Memories','Scrapbook thường được xem là món quà đặc biệt không chỉ với thiết kế mà 
còn giá trị của tinh thần lẫn vật chất của nó. Sản phẩm thành công và được nhiều người yêu thích vì những ý nghĩa...',400000,549000,14,
N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P51',N'Scrapbook Lò Xo Handmade Trang Trí Độc Lạ'',- Kích thước: 9,5 x 21cm

- Các size ảnh phù hợp: 4x6, 6x9, 9x12

- Giấy cứng và các họa tiết trang trí ấn tượng.

- Tối đa 47 tấm hình. Có nhiều lớp được xếp chồng lên nhau và kéo thả để hình ảnh vô cùng độc lạ.',400000,549000,14,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P52',N'Scrapbook Film de Paris','Scrapbook handmade Film de Paris độc đáo và ấn tượng với phiên bản Blue siêu quyến rũ.
Scrapbook dùng làm album ảnh lưu trữ những kỉ niệm đẹp.  - Kích thước: 21 x 21cm - Có thể trang trí 50 hình lớn nhỏ - Chất liệu:...',
450000,649000,16,N'Còn hàng','C02','DC01')

INSERT INTO product VALUES ('P53',N'Scrapbook handmade Sweet Moments','- Màu sắc: vàng lúa mạch.

- Kích thước: 20 x 20cm.

- Chất liệu: Giấy cứng cao cấp, được trang trí hoàn toàn bằng tay (100% handmade).

- Số trang: 11, có thể dán được 40-60 hình các size khác nhau.',450000,649000,12,N'Còn hàng','C02','DC01')

INSERT INTO product VALUES ('P54',N'SCRAPBOOK CHỦ ĐỀ CHO BÉ','Scrapbook chủ đề cho bé trai và bé gái Bạn băn khoăn về việc lưu giữ hình ảnh của bé con
sao cho vừa đẹp, vừa ý nghĩa, dễ thương mà vẫn độc đáo và khác biệt. Bạn không chỉ muốn đơn thuần...',500000,629000,8,N'Còn hàng','C02','DC01')

INSERT INTO product VALUES ('P55',N'Fly album handmade bicycle','Fly album handmade bicycle Chất liệu: giấy cứng cao cấp; Làm bằng tay hoàn toàn
(100% handmade); Kích thước: 14.5*21.5 cm; Số trang: 14, Dán được được 30 hình khổ 6x9 cm. ',
210000,329000,9,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P56',N'Fly album handmade Blue Pastel','- Chất liệu: giấy cứng cao cấp;
- Làm bằng tay hoàn toàn (100% handmade);
- Kích thước: 14 cm*23 cm;
- Số trang: 15, Dán được được 32 hình khổ 6 x 9cm.',210000,329000,20,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P57',N'Fly album Love (Xanh)','Phiên bản độc quyền mang phong cách riêng của Craft & More. 
Mang màu sắc cùng thiết kế bí ẩn, fly album handmade Love có thể trang trí trên bàn làm việc, bàn học, không gian. Sản phẩm có hộp đựng vô cùng xinh 
xắn.',210000,329000,17,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P58',N'Fly album Sweet Moment','Nếu fly album Anchor với tông màu hồng xin xắn dành riêng cho mùa xuân thì fly 
album Sweet Moment lại khơi gợi nét nhẹ nhàng, lãng đãng của mùa thu dịu dàng.
Sản phẩm vừa là cuốn album ảnh "độc", vừa là vật trang trí cực lãng mạn cho không gian.',210000,329000,6,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P59',N'Fly album Retro Clock','- Chất liệu: giấy cứng cao cấp;
- Làm bằng tay hoàn toàn (100% handmade);
- Kích thước: 14 cm*23 cm;
- Số trang: 15, Dán được được 32 hình khổ 6 x 9cm.',210000,329000,11,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P60',N'Scrapbook độc đáo cho tình yêu THE JOURNEY OF LOVE','- Màu sắc: Nâu trầm.

- Kích thước: 21 x 21cm, gồm 11 trang giấy trang trí sẵn.

- Sản phẩm mang thông điệp và màu sắc trung tính, có thể dùng làm quà tặng, album trang trí cho cả nam lẫn nữ.

- Sản phẩm có 2 mẫu khác nhau. Vui lòng chọn mẫu khi đặt hàng.',400000,649000,9,N'Còn hàng','C02','DC01')

INSERT INTO product VALUES ('P61',N'Album DIY Retro Clock',
'Thiết kế mang dáng vẻ cổ điển cùng lối trang trí đơn giản nhưng mang lại nét sang trọng, nhẹ nhàng cùng chi tiết bánh răng, đồng hồ, poscard,...'
,145000,222000,0,N'Tạm hết hàng','C02','DC01')
INSERT INTO product VALUES ('P62',N'Scrapbook LIVE.LAUGH.LOVE',
'Scrapbook với chất liệu giấy cứng, khổ: 20*20 cm; có thể trang trí khoảng 50 hình lớn nhỏ.',400000,649000,38,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P63',N'Scrapbook We are Growing',
'Quà handmade cho bé, cho tuổi trẻ - scrapbook We are  Growing - Sweet Laughing  
Album ảnh handmade có thiết kế ấn tượng tông màu nâu mang nét hoài cổ cá tính. Album phù hợp ghi dấu những chặng đường phát triển...'
,550000,699000,25,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P64',N'Scrapbook JUST BE ME',
'Scrapbook JUST BE ME Album ảnh có kích thước: 20x20cm; dán được 30-40 ảnh. Scrapbook được thiết kế ấn tượng theo phong cách VINTAGE, RETRO. 
Bạn có thể thêm bớt giấy tùy theo số lượng hình. Album được tặng thêm một số phụ...',500000,679000,19,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P65',N'SCRAPBOOK CHỦ ĐỀ TÌNH YÊU',
'Để giúp bạn dễ dàng hơn trong việc lựa chọn, ở bài viết này, Craft & More sẽ giới thiệu đến bạn một số mẫu Scrapbook theo chủ đề Tình yêu.
Click vào tên sản phẩm để biết thêm nhiều thông...',400000,649000,24,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P66',N'Scrapbook MY LITTLE PRINCESS',  
'Scrapbook độc đáo cho bé yêu - bé gái: MY LITTLE PRINCESS Album ảnh handmade có kích thước: 21*21 cm; giấy cao cấp, dán được khoảng trên 50 hình 
lớn nhỏ. Album được trang trí sẵn rất cá tính nhưng dịu dàng với tông màu hồng...',400000,649000,35,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P67',N'Album handmade bé trai MY LITTLE PRINCE','Scrapbook bé trai MY LITTLE PRINCE   Album ảnh handmade dành riêng
cho bé trai, tông màu xanh mạnh mẽ, cá tính - món quà độc đáo cho chàng hoàng tử bé của bạn; khổ: 21*21 cm; dán được 50 hình.
Album làm...',400000,649000,32,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P68',N'Album ảnh bé trai Wonderful My boy','Scrapbook cho bé trai WONDERFUL - MY BOY Album ảnh handmade cho bé trai đậm chất vintage,
là dạng kết hợp trang trí sẵn và tự làm (DIY): bìa và 3 trang bên trong trang trí sẵn; các trang còn lại trống (blank) để...',
500000,679000,15,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P69',N'Scrapbook cao cấp My little princess','Scrapbook handmade cao cấp My little princess Album được bằng tay 
với nhiều chi tiết tinh xảo. Scrapbook có thể dán hơn 150 hình với khích thước khác nhau. Kích thước: 20x20cm. 
Like Facebook của chúng tôi để được cập nhật nhanh nhất thông...',1400000,1620000,6,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P70',N'Scrapbook handmade Darling Daughter','- Chất liệu: giấy cứng cao cấp;
- Khổ: 20*20 cm;
- Album gáy còng, có thể dễ dàng thêm bớt trang tùy thích. Sản phẩm có thể đựng được 50-60 hình lớn nhỏ.',500000,679000,4,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P71',N'Scrapbook cao cấp I am marvelous',
'Scrapbook cao cấp I am marvelous Album đươc làm hoàn toàn bằng tay tỉ mỉ, chất liệu giấy mỹ thuật cao cấp; kích thước: 20x20cm.
Like Facebook của chúng tôi ngay các bạn nhé!',1400000,1620000,22,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P72',N'Scrapbook cao cấp My boy',
'Scrapbook handmade cao cấp My boy Album được làm hoàn toàn bằng tay rất tỉ mỉ. Kích thước: 20x20cm; 
Scrapbook có thể dán được hơn 150 hình với khích thước khác nhau. Chất liệu: giấy mỹ thuật cao cấp. Like ngay Facebook...'
,1400000,1620000,21,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P73',N'Album cưới handmade Beautiful In White',
'Album cưới handmade - scrapbook chủ đề TÌNH YÊU Beautiful In White Album handmade Beautiful in White đúng như tên gọi,
được thiết kế thanh thoát, giản dị, lãng mạn với tông trắng chủ đạo. Các trang nền bên trong có hoa văn,...',400000,649000,19,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P74',N'Album handmade scrapbook đẹp Together Forever',
'Album handmade scrapbook đẹp Together Forever   Làm bằng tay hoàn toàn, tĩ mĩ từng chi tiết nhỏ nhất! 20 trang giấy chuyên dụng được trang trí đặc sắc
; Chủ đề tình yêu: TOGETHER FOREVER; Chứa khoảng...',520000,729000,18,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P75',N'Scrapbook cao cấp We are growing',
'Scrapbook cao cấp làm album ảnh đẹp cho bé và gia đình Sự ra đời của cuốn album scrapbook cao cấp We are growing là một sự đột phá trong cách
trang trí, lưu giữ kỉ niệm bằng album. Bằng những trang giấy nghệ...'
,1400000,1620000,0,N'Ngưng bán','C02','DC01')
INSERT INTO product VALUES ('P76',N'Album ảnh handmade I am Marvelous',
'Lưu giữ những khoảnh khắc đáng nhớ bằng scrapbook I am Marvelous  Scrapbook I am Marvelous sẽ là nơi lý tưởng để bạn có thể lưu 

giữ những kỉ niệm hạnh phúc và đáng nhớ bên gia đình của mình. Những tấm hình...',500000,679000,12,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P77',N'Flying album handmade Love Story',
'Album ảnh handmade có thể kéo dài -flying album Chất liệu: giấy cứng cao cấp; Làm bằng tay hoàn toàn (100% handmade);
Kích thước: 14.5*21.5 cm; Số trang: 14, đựng được 30 hình khổ 6*9 cm và 1 hình 9*12cm Like facebook Craft & More để...'
,210000,329000,20,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P78',N'Flying album handmade Somewhere in time','Flying album handmade tỉ mỉ Chất liệu: giấy cứng cao cấp;
Làm bằng tay hoàn toàn (100% handmade); Kích thước: 14.5*21.5 cm; Số trang: 14, đựng được 30 hình khổ 6*9 cm và 1 hình 9x12cm. Món quà tặng độc 
đáo cho những người yêu...',210000,329000,20,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P79',N'Flying album handmade A Moment in Time','Món quà tặng độc đáo cho những người yêu thương,
hay cho chính bạn!',210000,329000,20,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P80',N'Flying album vintage Memories',
'Album ảnh bay handmade (flying album) Memories   Chất liệu: giấy cứng cao cấp; Làm bằng tay hoàn toàn (100% handmade); 
Kích thước: 14.5*21.5 cm; Số trang: 14, đựng được 30 hình khổ 6*9 cm và 1 hình 9*12cm.',210000,329000,25,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P81',N'Sổ ký tên đám cưới handmade','Sổ ký tên đám cưới handmade phong cách vintage Album cưới handmade dùng để 
ký tên và dán hình trang trí tiệc cưới được làm bằng tay hoàn toàn. Sổ có tối thiểu 3 trang hình và 3 trang ký tên, chứa khoảng 10-15 hình;'
,970000,1129000,34,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P82',N'Exploding love box album handmade','Chất liệu: Giấy cứng hoa văn cao cấp

Kích thước:  9 x 13cm, cao 6cm, chứa được khoảng 29 tấm hình 6 x 9cm.',310000,449000,0,N'Tạm hết hàng','C02','DC01')
INSERT INTO product VALUES ('P83',N'Mini Love Card-Album Handmade','Chất liệu: giấy cứng cao cấp; bền bỉ theo thời gian
Kích thước: 7.5*12 cm;
Chủ đề đa dạng, được thiết kế và thực hiện tại  HeadQuarter',56000,109000,14,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P84',N'ALBUM TỰ TRANG TRÍ (P.I) - SCRAPBOOK','Khác với 5-10 năm trước đây, làm album handmade không chỉ là một phạm
trù xa lạ mà còn khá khó khăn cho người làm bởi sự hạn chế về nguồn cung cấp và nơi bán các loại nguyên vật liệu....',500000,679000,31,N'Còn hàng',
'C02','DC01')
INSERT INTO product VALUES ('P85',N'ALBUM TỰ TRANG TRÍ (P.II) - ALBUM DIY','Bài trước, chúng ta đã tìm hiểu qua Scrapbook, bài tiếp theo này Craft & 
More xin giới thiệu tiếp đến Album ảnh DIY Album DIY (DO IT YOURSELF) Album DIY vượt trội hơn Scrapbook về số lượng ảnh được lưu trữ,...',145000,
220000,30,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P86',N'Album tự trang trí Vân gỗ trắng','Album thiết kế tối giản với màu sơn trắng Vintage cổ điển, họa tiết dấu mộc cổ
độc đáo như một nét chấm phá hoàn hảo cho cuốn album ảnh lưu bút độc đáo của bản thân.',140000,220000,30,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P87',N'Album DIY Vân gỗ Đỏ','Màu sắc chủ đạo: Nâu, vàng, đỏ được phối hợp khéo léo theo phong cách Vintage tinh tế. Thiết
kế không bao giờ lỗi thời, tối giản tới mức thấp nhất mọi nét trang trí cầu kì trên sản phẩm.',140000,220000,30,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P88',N'Album DIY Vân gỗ Pastel','Màu chủ đạo: tông màu trắng + xanh Pastel dịu nhẹ. Thiết kế nhẹ nhàng và đầy ngẫu hứng,
họa tiết vân gỗ quen thuộc nhưng vẫn gây cảm giác lạ mắt rất riêng cho sản phẩm.',140000,220000,30,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P89',N'Album DIY Sọc nhỏ','Họa tiết sọc xinh xắn, nhẹ nhàng, album gồm 60 trang với 2 màu nâu - đen đơn giản, 100% trang
giấy trống cho bạn thỏa sức sáng tạo.',140000,220000,19,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P90',N'Scrapbook handmade FOLIO','Mẫu scrapbook đẹp với việc sắp xếp khéo léo nhiều tấm thẻ thành một quyển sổ ảnh, 
kết hợp việc phối màu sắc, hoa văn tạo nên tổng thể một quyển scrapbook handmade đậm chất retro. Scrapbook có kích thước A5,...',
230000,479000,18,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P91',N'Sổ ký tên handmade Save the date','Thiết kế sổ ký tên + album ảnh cưới 2 in 1. Sản phẩm được làm 100% bằng tay
từ ý tưởng đến thiết kế, lấy ý tưởng từ chủ đề đại dương lãng mạn và dịu dàng, sổ ký tên Save the date chắc chắn sẽ làm bạn và người chiêm ngưỡng 
bất ngờ và thích thú.',1100000,1380000,20,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P92',N'Sổ ký tên Our Story','Sản phẩm là sổ ký tên kết hợp album ảnh cưới cực độc đáo. Tông màu xanh, nâu trầm chủ đạo,
họa tiết Vintage cuốn hút và quyến rũ. Cuốn sổ ký tên được thiết kế sang trọng và bắt mắt, ấn tượng như một câu chuyện cổ tích có thật!',1100000,
1380000,20,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P93',N'Sổ ký tên ngày cưới Let me love you','Sổ ký tên đám cưới mua ở đâu? Khổ 31x31cm; 24 trang luôn bìa; các họa tiết
vẽ tay artline in trên giấy mỹ thuật Tinki 250 gsm kết hợp làm album ảnh handmade độc đáo! Guestbook - sổ ký tên với...',180000,319000,0,N'Ngưng bán',
'C02','DC01')
INSERT INTO product VALUES ('P94',N'Sổ ký tên Happy Light','Sổ ký tên Happy Light Kích thước: 31x31cm Định lượng giấy 250gsm Số trang: 20 trang' ,
180000,319000,1,N'Tạm hết hàng','C02','DC01')
INSERT INTO product VALUES ('P95',N'Sổ ký tên Happy Forest','Guestbook Happy Forest Định lượng giấy: 250gsm Số trang: 20 trang Kích thước 31x31cm'
,180000,319000,1,N'Tạm hết hàng','C02','DC01')
INSERT INTO product VALUES ('P96',N'Sổ ký tên Tiny Love','Guestbook Tiny Love Kích thước: 31cm x 31cm Định lượng giấy: 250gsm Số lượng trang: 20 
trang',180000,319000,5,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P97',N'Album tự thiết kế Baby photo GIRL (27cm*27cm)','Album tự thiết kế Baby photo màu hồng-món quà cho các bé gái 
và gia đình tại vietgiftcenter.com   Khổ vuông 27cm*27cm, 64 trang luôn bìa, giấy bên trong 2 màu đen.',176000,280000,16,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P98',N'Guest Book Feeling good','Guest book-sổ kí tên Feeling good Kích thước: 31x31cm, định lượng giấy: 250gsm,
số lượng trang: 20 trang.',180000,319000,16,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P99',N'Guestbook - sổ ký tên đám cưới Memory Book','Guestbook - sổ ký tên đám cưới Khổ: 31x31cm; 24 trang luôn bìa
được thiết kế đặc biệt dành cho ký tên ngày cưới. Hoặc bạn có thể dùng làm album ảnh dán DIY. Bìa guestbook được thiết kế với tông màu...',180000,
319000,19,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P100',N'Album DIY gáy lò xo tiện dụng Paris Je Táime','Album tự trang trí gáy lò xo tiện dụng Paris Je Táime Kích thước
vừa phải,tiện dụng: 17*18cm; Bìa giấy cứng cáp, 2 màu đen và nâu; có ruy băng vải buộc chắc chắn...',78000,125000,27,N'Còn hàng','C02','DC01')
INSERT INTO product VALUES ('P101',N'Bình cắm hoa LYON','Bình cắm hoa LYON trang trí, Kích thước 12cm đường kính x 20cm cao, chất liệu: thiếc không gỉ',
350000,404000,10,N'Còn hàng','C05','DC01')
INSERT INTO product VALUES ('P102',N'Bình sứ trang trí Vintage','Bình sứ trang trí đẹp nhẹ nhàng phù hợp trang trí shop, studio, quán cafe, nhà hàng,
phòng khách',95000,163000,10,N'Còn hàng','C05','DC01')
INSERT INTO product VALUES ('P103',N'Bình cắm hoa trang trí dây thừng','Bình cắm hoa trang trí dây thừng
kích thước: 14cm đường kính x 19,5cm cao
Chất liệu thiếc được sơn chống gỉ.',280000,404000,10,N'Còn hàng','C05','DC01')
INSERT INTO product VALUES ('P104',N'Chai thủy tinh quấn thừng lớn','Chai (lọ) thủy tinh quấn thừng xinh xắn dùng cắm hoa cực đẹp Với chai thủy tinh,
sợi thừng nhỏ, Cổ & Cũ đã giúp thổi hồn vào sản phẩm một cách tinh tế và điệu đà, sản phẩm "chất" và "mộc" một...',89000,119000,10,
N'Còn hàng','C05','DC01')
INSERT INTO product VALUES ('P105',N'Bình gốm cao giả cổ hoa văn vintage','Chất liệu: sứ; hoa văn vintage cổ điển;
Kích thước: chân bình 15.5 cm; miệng bình 26 cm; cao 28 cm.',320000,545000,10,N'Còn hàng','C05','DC01')
INSERT INTO product VALUES ('P106',N'Khay sứ giả cổ','Chất liệu: sứ màu xanh ngọc;
Kích thước: cao 27cm, dài gồm tay cầm 43 cm, dài mặt trong khay 31cm, rộng 22cm, đường kính đáy khay 13cm.',690000,924000,7,N'Còn hàng','C05','DC01')
INSERT INTO product VALUES ('P107',N'Giá để rượu vang gốm giả cổ','Chất liệu: gốm;
Kích thước: 18x30cm.',310000,499000,14,N'Còn hàng','C05','DC01')
INSERT INTO product VALUES ('P108',N'Đế để rượu Nhân Sư Ai Cập','Kích thước: 31x11x17cm;
Chất liệu: thạch cao, nhựa tổng hợp.',340000,562000,20,N'Còn hàng','C05','DC01')
INSERT INTO product VALUES ('P109',N'Giá rượu Mèo Thần Ai Cập','Kích thước: 23x26x10cm;
Chất liệu: thạch cao và nhựa tổng hợp.',340000,562000,20,N'Còn hàng','C05','DC01')
INSERT INTO product VALUES ('P110',N'Bình sứ Le Jardinier','Chất liệu gốm sứ
Kích thước: 12.5 x 5.3 x 6.5cm
Dùng trang trí, cắm hoa,...',23000,52000,35,N'Còn hàng','C05','DC01')
INSERT INTO product VALUES ('P111',N'Cốc vintage','Chất liệu; gốm sứ
Kích thước: 8,5cm x 7,7cm
Dung tích: 300ml',45000,69000,0,N'Ngưng bán','C05','DC01')
INSERT INTO product VALUES ('P112',N'Ly sứ vintage phong cảnh châu âu', 'Cao 11.5cm; Đường kính 8cm; dung tích 300ml.',59000,89000,0,
N'Ngưng bán','C05','DC01')
INSERT INTO product VALUES ('P113',N'Bình sứ xinh xắn Dream House','Dung tích: 200ml;
Kích thước: 8x10cm.',70000,105000,0,N'Ngưng bán','C05','DC01')
INSERT INTO product VALUES ('P114',N'Ly sứ starbucks coffee','Dung tích 300ml;
Ly cao 8.5cm; đường kính 7.5cm;',23000,45000,0,N'Ngưng bán','C05','DC01')
INSERT INTO product VALUES ('P115',N'Ly sứ vintage street','Cao 9cm; đường kính 7cm; có nắp.',84000,115000,12,N'Còn hàng','C05','DC01')
INSERT INTO product VALUES ('P116',N'Bình hoa gốm trắng GRID','Kích thước 20x25cm;',395000,532000,15,N'Còn hàng','C05','DC01')
INSERT INTO product VALUES ('P117',N'Bình hoa gốm giả cổ trang trí nâu cao cổ tròn','Kích thước: 17x38 cm;',400000,509000,0,N'Ngưng bán','C05','DC01')
INSERT INTO product VALUES ('P118',N'Bình sứ giả cổ Victoria','Bình sứ trang trí đẹp nhẹ nhàng mang phong cách vintage phù hợp trang trí
quán cafe, studio, shop,...',240000,395000,2,N'Còn hàng','C05','DC01')
INSERT INTO product VALUES ('P119',N'Hộp đựng bút R102','kích thước :16.5x7x21 (cm)

Kích thước thuyền :21×4.5×16(cm)

Chất liệu :  Sắt sơn tĩnh điện, chống rỉ sét, mài mòn.

Giúp cho phòng làm việc trở nên gọn gàng, hiện đại hơn, từ đó mà không gian trở nên thoải mái, làm việc cũng hiệu quả hơn.',
90000,170000,6,N'Còn hàng','C05','DC01')
INSERT INTO product VALUES ('P120',N'Mèo thần tài R104','Mèo thần tài R104  với thiết kế góc cạnh hiện đại, được làm từ gốm sứ cao cấp, 
tráng men sáng bóng, màu sắc tươi tắn, sắc nét mang đến may mắn, bình an và tài lộc vô biên cho gia chủ. Mèo thần tài cũng rất phù hợ
p để làm quà tặng dịp mừng khai trương, tân gia, thăng quan tiến chức,…',290000,400000,20,N'Còn hàng','C05','DC01')
INSERT INTO product VALUES ('P121',N'Tượng Hươu trang trí R103','Từ xa xưa, hình ảnh hươu nai trang trí đã được các tầng lớp quý tộc vô 
cùng ưa chuộng. Bởi họ quan niệm rằng, hươu nai biểu tượng cho sự sung túc và giàu có. Do hươu là loài vật sống rất lâu năm nên việc trưng
bày hình ảnh của loài vật này còn mang ý nghĩa may mắn và trường thọ. Đặt tượng hươu trang trí trong nhà sẽ mang đến cho gia đình một cuộc sống
bình an, mạnh khỏe. Đặc biệt, hỗ trợ cực tốt cho gia chủ trên con đường làm ăn kinh doanh, phát tài phát lộc, gặp nhiều may mắn và thuận lợi trong 
công việc.',550000,649999,19,N'Còn hàng','C05','DC01')
INSERT INTO product VALUES ('P122',N'Xe máy mô hình trang trí R101','Kích thước :15 x 5.5 x 9.5 (cm)

Chất liệu : sắt phủ sơn tĩnh điện, chống rỉ sét, mài mòn.

Phù hợp để trang trí bàn làm việc, văn phòng, Studio , giúp cho không gian thêm phần thanh lịch, hiện đại.',75000,135000,27,
N'Còn hàng','C05','DC01')
INSERT INTO product VALUES ('P123',N'Đèn bão trang trí Vintage','Đèn bão vintage trang trí nhà cửa Đèn bão được phủ một lớp sơn đồng, bạc đậm
chất retro. Đèn bão thời trước đây dùng trong các trường hợp không có điện, ngày nay khi mọi thứ trở nên hiện đại,...',140000,192000,4,N'Còn hàng',
'C05','DC01')
INSERT INTO product VALUES ('P124',N'Móc treo nữ trang vintage','Kích thước: 25x16cm 
Chất liệu: gỗ, kim loại',100000,152000,4,N'Còn hàng','C05','DC01')
INSERT INTO product VALUES ('P125',N'Lọ hoa thủy tinh handmade','LỌ HOA THỦY TINH HANDMADE Được chăm chút tỉ mỉ từng cánh hoa, chậu hoa handmade 
thủy tinh sẽ là một món quà tặng xinh xắn hay làm căn phòng của bạn dễ thương hơn bao giờ hết. Lọ hoa thủy...',89000,120000,0,N'Ngưng bán','C05','DC01')

INSERT INTO product VALUES ('P126',N'Hoa lavender oải hương handmade trang trí nhà cửa','Chất liệu foam, giấy, dây kẽm.
Màu sắc đa dạng ',15000,35000,0,N'Ngưng bán','C05','DC01')
INSERT INTO product VALUES ('P127',N'Hoa chậu handmade - Hoa hồng giấy','Hoa chậu handmade - Hoa hồng giấy Hoa handmade chậu thủy tinh quấn thừng 
nhỏ xinh, dễ thương khi sử dụng làm quà tặng, người nhận có thể dùng trang trí kệ, bàn. Ưu điểm của hoa handmade là hình thức đẹp không...',101000,
157000,19,N'Còn hàng','C05','DC01')
INSERT INTO product VALUES ('P128',N'Hộp nhạc piano pha lê khắc tên','Hộp nhạc dây cót piano pha lê khắc tên Thiết kế mới lạ, sang trọng, được làm 
từ nhựa trong acrylic bạn sẽ nhìn được chuyển động đang chạy trong hộp nhạc trông rất thú vị. Làm đồ decor trong nhà, bàn làm...',510000,559000,25,
N'Còn hàng','C05','DC01')
INSERT INTO product VALUES ('P129',N'Hộp nhạc gỗ Piano','Màu sắc trắng, hồng
Khắc tên laser',510000,559000,33,N'Còn hàng','C05','DC01')

INSERT INTO product VALUES ('P130',N'Hộp nhạc cổ điển camera','Kích thước:12x6x7,5cm
Chất liệu: gỗ
Thiết kế tỉ mỉ, khéo léo
Mẫu mã thịnh hành 
Thích hợp làm quà tặng sinh nhật, valentine, noel, 8/3, 20/10,..',220000,250000,14,N'Còn hàng','C05','DC01')

INSERT INTO product VALUES ('P131',N'Tượng trang trí phòng khách Thinker','Chất liệu: đá sa thạch bền chắc, thân thiện với môi trường và an toàn với người sử dụng.
Kích thước: cao 23cm x ngang 12,5cm.
Màu sắc: như hình.
Bảo quản: Không được rửa bằng nước hay bất kì dung dịch nào. Khi tượng bám bụi, hãy dùng khăn mềm  lau nhẹ nhàng.',190000,249000,19,N'Còn hàng','C05','DC01')

INSERT INTO product VALUES ('P132',N'Tượng trang trí vintage không thấy - không nghe -không nói','Kích thước 11x12 cao 32cm
Chất liệu : Đá Composite cao cấp
Màu sắc giả đá tự nhiên',260000,406000,27,N'Còn hàng','C05','DC01')


INSERT INTO product VALUES ('P133',N'Xe Vespa mô hình trang trí, phụ kiện chụp ảnh', 'Mô hình xe Vespa chất liệu kim loại

- Kích thước 12x7.5cm, nhỏ xinh siêu cute

- Xe Vespa trang trí, làm đồ decor sưu tập, phụ kiện chụp ảnh',108000,152000,19,N'Còn hàng','C05','DC01')

INSERT INTO product VALUES ('P134',N'Thuyền gỗ vintage decor trang trí, phụ kiện chụp ảnh','Có 3 kích thước 27cm; 34cm và 42cm
Chất liệu gỗ theo phong cách Địa Trung Hải.',88000,149000,16,N'Còn hàng','C05','DC01')

INSERT INTO product VALUES ('P135',N'Vòng hoa Giáng sinh kim nỉ Holly','Mỗi quả bóng và lá nhựa ruồi được nỉ riêng bằng 100% len với màu sắc Giáng sinh truyền thống

Vòng hoa dài 135cm và cụm lá nhựa ruồi ở giữa có kích thước khoảng. 11 x 11 cm',113000,200000,16,N'Còn hàng','C05','DC01')



INSERT INTO product VALUES ('P136',N'Cây thông Noel Macrame','Tôi đã làm cây macrame này bằng dây bông màu xanh nhạt.

Nó được làm trên một chiếc nhẫn bằng đồng 25 mm và có thêm 10 hạt gỗ và một ngôi sao/bông tuyết bằng gỗ ở trên cùng.

Tổng số đo bao gồm vòng và tua là khoảng. 30cm x 11cm',113000,200000,0,N'Ngưng bán','C05','DC01')



--INSERT VALUE IMAGE
INSERT INTO [image] VALUES ('I01',N'Thiệp handmade vintage Beauty & the White','views\products\images\.webp','P01')
INSERT INTO [image] VALUES ('I02',N'Thiệp handmade vintage Beauty & the White','views\products\images\.webp','P01')
INSERT INTO [image] VALUES ('I03',N'Thiệp handmade vintage Beauty & the White','views\products\images\.webp','P01')
INSERT INTO [image] VALUES ('I04',N'Thiệp handmade Film de Paris','views\products\images\.webp','P02')
INSERT INTO [image] VALUES ('I05',N'Thiệp handmade Film de Paris','views\products\images\.webp','P02')
INSERT INTO [image] VALUES ('I06',N'Thiệp handmade Film de Paris','views\products\images\.webp','P02')
INSERT INTO [image] VALUES ('I07',N'Thiệp chúc mừng Sweet Mint','views\products\images\.webp','P03')
INSERT INTO [image] VALUES ('I08',N'Thiệp chúc mừng Sweet Mint','views\products\images\.webp','P03')
INSERT INTO [image] VALUES ('I09',N'Thiệp chúc mừng Sweet Mint','views\products\images\.webp','P03')
INSERT INTO [image] VALUES ('I10',N'Thiệp chúc mừng Black & White','views\products\images\.webp','P04')
INSERT INTO [image] VALUES ('I11',N'Thiệp chúc mừng Black & White','views\products\images\.webp','P04')
INSERT INTO [image] VALUES ('I12',N'Thiệp chúc mừng Black & White','views\products\images\p04.webp','P04')
INSERT INTO [image] VALUES ('I13',N'Thiệp handmade Amazing Carton','views\products\images\p05.webp','P05')
INSERT INTO [image] VALUES ('I14',N'Thiệp handmade Amazing Carton','views\products\images\p05_1.webp','P05')
INSERT INTO [image] VALUES ('I15',N'Thiệp handmade Amazing Carton','views\products\images\p05_2.webp','P05')
INSERT INTO [image] VALUES ('I16',N'Thiệp handmade lớn Beauty & the White','views\products\images\p06.webp','P06')
INSERT INTO [image] VALUES ('I17',N'Thiệp handmade lớn Beauty & the White','views\products\images\p06_1.webp','P06')
INSERT INTO [image] VALUES ('I18',N'Thiệp handmade lớn Beauty & the White','views\products\images\p06_2.webp','P06')
INSERT INTO [image] VALUES ('I19',N'Thiệp da bò độc đáo','views\products\images\p07.webp','P07')
INSERT INTO [image] VALUES ('I20',N'Thiệp da bò độc đáo','views\products\images\p07_1.webp','P07')
INSERT INTO [image] VALUES ('I21',N'Thiệp da bò độc đáo','views\products\images\p07_2.webp','P07')
INSERT INTO [image] VALUES ('I22',N'Thiệp dấu sáp mini','views\products\images\p08.webp','P08')
INSERT INTO [image] VALUES ('I23',N'Thiệp dấu sáp mini','views\products\images\p08_1.webp','P08')
INSERT INTO [image] VALUES ('I24',N'Thiệp dấu sáp mini','views\products\images\p08_2.webp','P08')
INSERT INTO [image] VALUES ('I25',N'Thiệp handmade Vintage Film','views\products\images\p09.webp','P09')
INSERT INTO [image] VALUES ('I26',N'Thiệp handmade Vintage Film','views\products\images\p09_1.webp','P09')
INSERT INTO [image] VALUES ('I27',N'Thiệp handmade Vintage Film','views\products\images\p09_2.webp','P09')
INSERT INTO [image] VALUES ('I28',N'Thiệp handmade vintage vải bố','views\products\images\p10.webp','P10')
INSERT INTO [image] VALUES ('I29',N'Thiệp handmade vintage vải bố','views\products\images\p10_1.webp','P10')
INSERT INTO [image] VALUES ('I30',N'Thiệp handmade vintage vải bố','views\products\images\p10_2.webp','P10')
INSERT INTO [image] VALUES ('I31',N'Thiệp gỗ Jigsaws','views\products\images\p11.webp','P11')
INSERT INTO [image] VALUES ('I32',N'Thiệp gỗ Jigsaws','views\products\images\p11_1.webp','P11')
INSERT INTO [image] VALUES ('I33',N'Thiệp gỗ Jigsaws','views\products\images\p11_2.webp','P11')
INSERT INTO [image] VALUES ('I34',N'Thiệp gỗ Other Half','views\products\images\p12.webp','P12')
INSERT INTO [image] VALUES ('I35',N'Thiệp gỗ Other Half','views\products\images\p12_1.webp','P12')
INSERT INTO [image] VALUES ('I36',N'Thiệp gỗ Other Half','views\products\images\p12_2.webp','P12')
INSERT INTO [image] VALUES ('I37',N'Thiệp chúc mừng handmade Blue Pastel','views\products\images\p13.webp','P13')
INSERT INTO [image] VALUES ('I38',N'Thiệp chúc mừng handmade Blue Pastel','views\products\images\p13_1.webp','P13')
INSERT INTO [image] VALUES ('I39',N'Thiệp chúc mừng handmade Blue Pastel','views\products\images\p13_2.webp','P13')
INSERT INTO [image] VALUES ('I40',N'Thiệp vintage Retro Clock','views\products\images\p14.webp','P14')
INSERT INTO [image] VALUES ('I41',N'Thiệp vintage Retro Clock','views\products\images\p14_1.webp','P14')
INSERT INTO [image] VALUES ('I42',N'Thiệp vintage Retro Clock','views\products\images\p14_2.webp','P14')
INSERT INTO [image] VALUES ('I43',N'Thiệp giấy carton handmade - Thiệp chúc mừng sinh nhật','views\products\images\p15.webp','P15')
INSERT INTO [image] VALUES ('I44',N'Thiệp giấy carton handmade - Thiệp chúc mừng sinh nhật','views\products\images\p15_1.webp','P15')
INSERT INTO [image] VALUES ('I45',N'Thiệp giấy carton handmade - Thiệp chúc mừng sinh nhật','views\products\images\p15_2.webp','P15')
INSERT INTO [image] VALUES ('I46',N'Thiệp tặng bạn thân - Thiệp vintage retro','views\products\images\p16.webp','P16')
INSERT INTO [image] VALUES ('I47',N'Thiệp tặng bạn thân - Thiệp vintage retro','views\products\images\p16_1.webp','P16')
INSERT INTO [image] VALUES ('I48',N'Thiệp tặng bạn thân - Thiệp vintage retro','views\products\images\p16_2.webp','P16')
INSERT INTO [image] VALUES ('I49',N'Giấy viết thư cổ điển Vintage','views\products\images\p17.webp','P17')
INSERT INTO [image] VALUES ('I50',N'Giấy viết thư cổ điển Vintage','views\products\images\p17_1.webp','P17')
INSERT INTO [image] VALUES ('I51',N'Giấy viết thư cổ điển Vintage','views\products\images\p17_2.webp','P17')
INSERT INTO [image] VALUES ('I52',N'Khung ảnh đẹp Frame Triple','views\products\images\p18.webp','P18')
INSERT INTO [image] VALUES ('I53',N'Khung ảnh đẹp Frame Triple','views\products\images\p18_1.webp','P18')
INSERT INTO [image] VALUES ('I54',N'Khung ảnh đẹp Frame Triple','views\products\images\p18_2.webp','P18')
INSERT INTO [image] VALUES ('I55',N'Khung ảnh frame 6 in 1','views\products\images\p19.webp','P19')
INSERT INTO [image] VALUES ('I56',N'Khung ảnh frame 6 in 1','views\products\images\p19_1.webp','P19')
INSERT INTO [image] VALUES ('I57',N'Khung ảnh frame 6 in 1','views\products\images\p19_2.webp','P19')
INSERT INTO [image] VALUES ('I58',N'Khung ảnh gỗ 3 in 1','views\products\images\p20.webp','P20')
INSERT INTO [image] VALUES ('I59',N'Khung ảnh gỗ 3 in 1','views\products\images\p20_1.webp','P20')
INSERT INTO [image] VALUES ('I60',N'Khung ảnh gỗ 3 in 1','views\products\images\p20_2.webp','P20')
INSERT INTO [image] VALUES ('I61',N'Khung ảnh, tủ móc khóa, móc treo 3 in 1','views\products\images\p21.webp','P21')
INSERT INTO [image] VALUES ('I62',N'Khung ảnh, tủ móc khóa, móc treo 3 in 1','views\products\images\p21_1.webp','P21')
INSERT INTO [image] VALUES ('I63',N'Khung hình vintage triple cỡ lớn','views\products\images\p22.webp','P22')
INSERT INTO [image] VALUES ('I64',N'Khung ảnh handmade - thiệp handmade đẹp 2 in 1','views\products\images\p23.webp','P23')
INSERT INTO [image] VALUES ('I65',N'Khung ảnh kiểu Địa Trung Hải','views\products\images\p24.webp','P24')
INSERT INTO [image] VALUES ('I66',N'Khung ảnh vintage kiểu US Army','views\products\images\p25.webp','P25')
INSERT INTO [image] VALUES ('I67',N'Khung ảnh vintage trắng ngà','views\products\images\p26.webp','P26')
INSERT INTO [image] VALUES ('I68',N'Khung ảnh - móc treo FISH HOOK','views\products\images\p27.webp','P27')
INSERT INTO [image] VALUES ('I69',N'Khung ảnh gỗ và thạch cao Ivory Vintage','views\products\images\p28.webp','P28')
INSERT INTO [image] VALUES ('I70',N'Khung ảnh gỗ và thạch cao Ivory Vintage','views\products\images\p28_1.webp','P28')
INSERT INTO [image] VALUES ('I71',N'Khung ảnh gỗ và thạch cao Ivory Vintage','views\products\images\p28_2.webp','P28')
INSERT INTO [image] VALUES ('I72',N'Khung ảnh Hải Âu Mediterranean','views\products\images\p29.webp','P29')
INSERT INTO [image] VALUES ('I73',N'Khung ảnh Địa Trung Hải Kayak','views\products\images\p30.webp','P30')
INSERT INTO [image] VALUES ('I74',N'Khung ảnh vintage hoa văn vuông','views\products\images\p31.webp','P31')
INSERT INTO [image] VALUES ('I75',N'Khung ảnh mèo Totoro','views\products\images\p32.webp','P32')
INSERT INTO [image] VALUES ('I76',N'Khung ảnh mèo Totoro','views\products\images\p32_1.webp','P32')
INSERT INTO [image] VALUES ('I77',N'Khung ảnh mèo Totoro','views\products\images\p32_2.webp','P32')
INSERT INTO [image] VALUES ('I78',N'Khung ảnh Staring time (lớn)','views\products\images\p33.webp','P33')
INSERT INTO [image] VALUES ('I79',N'Khung ảnh Staring time (lớn)','views\products\images\p33_1.webp','P33')
INSERT INTO [image] VALUES ('I80',N'Khung ảnh Staring time (lớn)','views\products\images\p33_2.webp','P33')
INSERT INTO [image] VALUES ('I81',N'Khung ảnh gỗ thông Rustic','views\products\images\p34.webp','P34')
INSERT INTO [image] VALUES ('I82',N'Khung ảnh gỗ thông Rustic','views\products\images\p34_1.webp','P34')
INSERT INTO [image] VALUES ('I83',N'Khung ảnh gỗ thông Rustic','views\products\images\p34_2.webp','P34')
INSERT INTO [image] VALUES ('I84',N'Khung ảnh Hải Âu Mediterranean','views\products\images\p35.webp','P35')
INSERT INTO [image] VALUES ('I85',N'Khung trang trí bàn hoa hồng sứ C-rose frame','views\products\images\p36.webp','P36')
INSERT INTO [image] VALUES ('I86',N'KHUNG ẢNH NGÔI NHÀ CỬA SỔ NÂU (NGANG)','views\products\images\p37.webp','P37')
INSERT INTO [image] VALUES ('I87',N'KHUNG ẢNH NGÔI NHÀ CỬA SỔ NÂU (NGANG)','views\products\images\p37_1.webp','P37')
INSERT INTO [image] VALUES ('I88',N'KHUNG ẢNH NGÔI NHÀ XE ĐẠP','views\products\images\p38.webp','P38')
INSERT INTO [image] VALUES ('I89',N'KHUNG ẢNH NGÔI NHÀ XE ĐẠP','views\products\images\p38_1.webp','P38')
INSERT INTO [image] VALUES ('I90',N'KHUNG ẢNH VÒNG ĐU QUAY VINTAGE','views\products\images\p39.webp','P39')
INSERT INTO [image] VALUES ('I91',N'Bì thư vintage Tem Việt','views\products\images\p40.webp','P40')
INSERT INTO [image] VALUES ('I92',N'Bì thư vintage Tem Việt','views\products\images\p40_1.webp','P40')
INSERT INTO [image] VALUES ('I93',N'Bì thư vintage Tem Việt','views\products\images\p40_2.webp','P40')
INSERT INTO [image] VALUES ('I94',N'Scrapbook That Time','views\products\images\p41.webp','P41')
INSERT INTO [image] VALUES ('I95',N'Scrapbook That Time','views\products\images\p41_1.webp','P41')
INSERT INTO [image] VALUES ('I96',N'Scrapbook That Time','views\products\images\p41_2.webp','P41')
INSERT INTO [image] VALUES ('I97',N'Scrapbook Sweet Mint','views\products\images\p42.webp','P42')
INSERT INTO [image] VALUES ('I98',N'Scrapbook Sweet Mint','views\products\images\p42_1.webp','P42')
INSERT INTO [image] VALUES ('I99',N'Scrapbook Fly That Time','views\products\images\p43.webp','P43')
INSERT INTO [image] VALUES ('I100',N'Scrapbook Fly That Time','views\products\images\p43_1.webp','P43')
INSERT INTO [image] VALUES ('I101',N'Album ảnh handmade Fly Sweet Mint','views\products\images\p44.webp','P44')
INSERT INTO [image] VALUES ('I102',N'Album ảnh handmade Fly Sweet Mint','views\products\images\p44_1.webp','P44')
INSERT INTO [image] VALUES ('I103',N'Album ảnh handmade Fly Sweet Mint','views\products\images\p44_2.webp','P44')
INSERT INTO [image] VALUES ('I104',N'Album ảnh tự trang trí Love Story (Xanh)','views\products\images\p45.webp','P45')
INSERT INTO [image] VALUES ('I105',N'Album ảnh tự trang trí Love Story (Xanh)','views\products\images\p45_1.webp','P45')
INSERT INTO [image] VALUES ('I106',N'Album ảnh tự trang trí Love Story (Xanh)','views\products\images\p45_2.webp','P45')
INSERT INTO [image] VALUES ('I107',N'Scrapbook Retro Clock','views\products\images\p46.webp','P46')
INSERT INTO [image] VALUES ('I108',N'Scrapbook Retro Clock','views\products\images\p46_1.webp','P46')
INSERT INTO [image] VALUES ('I109',N'Scrapbook Retro Clock','views\products\images\p46_2.webp','P46')
INSERT INTO [image] VALUES ('I110',N'Scrapbook Vintage','views\products\images\p47.webp','P47')
INSERT INTO [image] VALUES ('I111',N'Scrapbook Vintage','views\products\images\p47_1.webp','P47')
INSERT INTO [image] VALUES ('I112',N'Scrapbook Lò Xo Handmade Phong Cách Retro Độc Đáo','views\products\images\p48.webp','P48')
INSERT INTO [image] VALUES ('I113',N'Scrapbook Lò Xo Handmade Phong Cách Retro Độc Đáo','views\products\images\p48_1.webp','P48')
INSERT INTO [image] VALUES ('I114',N'Scrapbook Lò Xo Handmade Phong Cách Retro Độc Đáo','views\products\images\p48_2.webp','P48')
INSERT INTO [image] VALUES ('I115',N'Album ảnh handmade Blue Pastel','views\products\images\p49.webp','P49')
INSERT INTO [image] VALUES ('I116',N'Album ảnh handmade Blue Pastel','views\products\images\p49_1.webp','P49')
INSERT INTO [image] VALUES ('I117',N'Album ảnh handmade Blue Pastel','views\products\images\p49_2.webp','P49')
INSERT INTO [image] VALUES ('I118',N'Scrapbook My Boy For The Memories','views\products\images\p50.webp','P50')
INSERT INTO [image] VALUES ('I119',N'Scrapbook My Boy For The Memories','views\products\images\p50_1.webp','P50')
INSERT INTO [image] VALUES ('I120',N'Scrapbook My Boy For The Memories','views\products\images\p50_2.webp','P50')
INSERT INTO [image] VALUES ('I121',N'Scrapbook Lò Xo Handmade Trang Trí Độc Lạ','views\products\images\p51.webp','P51')
INSERT INTO [image] VALUES ('I122',N'Scrapbook Lò Xo Handmade Trang Trí Độc Lạ','views\products\images\p51_1.webp','P51')
INSERT INTO [image] VALUES ('I123',N'Scrapbook Lò Xo Handmade Trang Trí Độc Lạ','views\products\images\p51_2.webp','P51')
INSERT INTO [image] VALUES ('I124',N'Scrapbook Film de Paris','views\products\images\p52.webp','P52')
INSERT INTO [image] VALUES ('I125',N'Scrapbook Film de Paris','views\products\images\p52_1.webp','P52')
INSERT INTO [image] VALUES ('I126',N'Scrapbook Film de Paris','views\products\images\p52_2.webp','P52')
INSERT INTO [image] VALUES ('I127',N'Scrapbook handmade Sweet Moments','views\products\images\p53.webp','P53')
INSERT INTO [image] VALUES ('I128',N'Scrapbook handmade Sweet Moments','views\products\images\p53_1.webp','P53')
INSERT INTO [image] VALUES ('I129',N'Scrapbook handmade Sweet Moments','views\products\images\p53_2.webp','P53')
INSERT INTO [image] VALUES ('I130',N'SCRAPBOOK CHỦ ĐỀ CHO BÉ','views\products\images\p54.webp','P54')
INSERT INTO [image] VALUES ('I131',N'SCRAPBOOK CHỦ ĐỀ CHO BÉ','views\products\images\p54_1.webp','P54')
INSERT INTO [image] VALUES ('I132',N'SCRAPBOOK CHỦ ĐỀ CHO BÉ','views\products\images\p54_2.webp','P54')
INSERT INTO [image] VALUES ('I133',N'Fly album handmade bicycle','views\products\images\p55.webp','P55')
INSERT INTO [image] VALUES ('I134',N'Fly album handmade bicycle','views\products\images\p55_1.webp','P55')
INSERT INTO [image] VALUES ('I135',N'Fly album handmade bicycle','views\products\images\p55_2.webp','P55')
INSERT INTO [image] VALUES ('I136',N'Fly album handmade Blue Pastel','views\products\images\p56.webp','P56')
INSERT INTO [image] VALUES ('I137',N'Fly album handmade Blue Pastel','views\products\images\p56_1.webp','P56')
INSERT INTO [image] VALUES ('I138',N'Fly album handmade Blue Pastel','views\products\images\p56_2.webp','P56')
INSERT INTO [image] VALUES ('I139',N'Fly album Love (Xanh)','views\products\images\p57.webp','P57')
INSERT INTO [image] VALUES ('I140',N'Fly album Love (Xanh)','views\products\images\p57_1.webp','P57')
INSERT INTO [image] VALUES ('I141',N'Fly album Love (Xanh)','views\products\images\p57_2.webp','P57')
INSERT INTO [image] VALUES ('I142',N'Fly album Sweet Moment','views\products\images\p58.webp','P58')
INSERT INTO [image] VALUES ('I143',N'Fly album Sweet Moment','views\products\images\p58_1.webp','P58')
INSERT INTO [image] VALUES ('I144',N'Fly album Retro Clock','views\products\images\p59.webp','P59')
INSERT INTO [image] VALUES ('I145',N'Fly album Retro Clock','views\products\images\p59_1.webp','P59')
INSERT INTO [image] VALUES ('I146',N'Scrapbook độc đáo cho tình yêu THE JOURNEY OF LOVE','views\products\images\p60.webp','P60')
INSERT INTO [image] VALUES ('I147',N'Scrapbook độc đáo cho tình yêu THE JOURNEY OF LOVE','views\products\images\p60_1.webp','P60')
INSERT INTO [image] VALUES ('I148',N'Scrapbook độc đáo cho tình yêu THE JOURNEY OF LOVE','views\products\images\p60_2.webp','P60')
INSERT INTO [image] VALUES ('I149',N'Album DIY Retro Clock','views\products\images\p61.webp','P61')
INSERT INTO [image] VALUES ('I150',N'Album DIY Retro Clock','views\products\images\p61_1.webp','P61')
INSERT INTO [image] VALUES ('I151',N'Album DIY Retro Clock','views\products\images\p61_2.webp','P61')
INSERT INTO [image] VALUES ('I152',N'Scrapbook LIVE.LAUGH.LOVE','views\products\images\p62.webp','P62')
INSERT INTO [image] VALUES ('I153',N'Scrapbook LIVE.LAUGH.LOVE','views\products\images\p62_1.webp','P62')
INSERT INTO [image] VALUES ('I154',N'Scrapbook LIVE.LAUGH.LOVE','views\products\images\p62_2.webp','P62')
INSERT INTO [image] VALUES ('I155',N'Scrapbook We are Growing','views\products\images\p63.webp','P63')
INSERT INTO [image] VALUES ('I156',N'Scrapbook We are Growing','views\products\images\p63_1.webp','P63')
INSERT INTO [image] VALUES ('I157',N'Scrapbook We are Growing','views\products\images\p63_2.webp','P63')
INSERT INTO [image] VALUES ('I158',N'Scrapbook JUST BE ME','views\products\images\p64.webp','P64')
INSERT INTO [image] VALUES ('I159',N'Scrapbook JUST BE ME','views\products\images\p64_1.webp','P64')
INSERT INTO [image] VALUES ('I160',N'SCRAPBOOK CHỦ ĐỀ TÌNH YÊU','views\products\images\p65.webp','P65')
INSERT INTO [image] VALUES ('I161',N'SCRAPBOOK CHỦ ĐỀ TÌNH YÊU','views\products\images\p65_1.webp','P65')
INSERT INTO [image] VALUES ('I162',N'Scrapbook MY LITTLE PRINCESS','views\products\images\p66.webp','P66')
INSERT INTO [image] VALUES ('I163',N'Scrapbook MY LITTLE PRINCESS','views\products\images\p66_1.webp','P66')
INSERT INTO [image] VALUES ('I164',N'Scrapbook MY LITTLE PRINCESS','views\products\images\p66_2.webp','P66')
INSERT INTO [image] VALUES ('I165',N'Album handmade bé trai MY LITTLE PRINCE','views\products\images\p67.webp','P67')
INSERT INTO [image] VALUES ('I166',N'Album ảnh bé trai Wonderful My boy','views\products\images\p68.webp','P68')
INSERT INTO [image] VALUES ('I167',N'Album ảnh bé trai Wonderful My boy','views\products\images\p68_1.webp','P68')
INSERT INTO [image] VALUES ('I168',N'Scrapbook cao cấp My little princess','views\products\images\p69.webp','P69')
INSERT INTO [image] VALUES ('I169',N'Scrapbook cao cấp My little princess','views\products\images\p69_1.webp','P69')
INSERT INTO [image] VALUES ('I170',N'Scrapbook handmade Darling Daughter','views\products\images\p70.webp','P70')
INSERT INTO [image] VALUES ('I171',N'Scrapbook handmade Darling Daughter','views\products\images\p70_1.webp','P70')
INSERT INTO [image] VALUES ('I172',N'Scrapbook cao cấp I am marvelous','views\products\images\p71.webp','P71')
INSERT INTO [image] VALUES ('I173',N'Scrapbook cao cấp My boy','views\products\images\p72.webp','P72')
INSERT INTO [image] VALUES ('I174',N'Album cưới handmade Beautiful In White','views\products\images\p73.webp','P73')
INSERT INTO [image] VALUES ('I175',N'Album cưới handmade Beautiful In White','views\products\images\p73_1.webp','P73')
INSERT INTO [image] VALUES ('I176',N'Album handmade scrapbook đẹp Together Forever','views\products\images\p74.webp','P74')
INSERT INTO [image] VALUES ('I177',N'Album handmade scrapbook đẹp Together Forever','views\products\images\p74_1.webp','P74')
INSERT INTO [image] VALUES ('I178',N'Album handmade scrapbook đẹp Together Forever','views\products\images\p74_2.webp','P74')
INSERT INTO [image] VALUES ('I179',N'Scrapbook cao cấp We are growing','views\products\images\p75.webp','P75')
INSERT INTO [image] VALUES ('I180',N'Scrapbook cao cấp We are growing','views\products\images\p75_1.webp','P75')
INSERT INTO [image] VALUES ('I181',N'Scrapbook cao cấp We are growing','views\products\images\p75_2.webp','P75')
INSERT INTO [image] VALUES ('I182',N'Album ảnh handmade I am Marvelous','views\products\images\p76.webp','P76')
INSERT INTO [image] VALUES ('I183',N'Album ảnh handmade I am Marvelous','views\products\images\p76_1.webp','P76')
INSERT INTO [image] VALUES ('I184',N'Album ảnh handmade I am Marvelous','views\products\images\p76_2.webp','P76')
INSERT INTO [image] VALUES ('I185',N'Flying album handmade Love Story','views\products\images\p77.webp','P77')
INSERT INTO [image] VALUES ('I186',N'Flying album handmade Love Story','views\products\images\p77_1.webp','P77')
INSERT INTO [image] VALUES ('I187',N'Flying album handmade Love Story','views\products\images\p77_2.webp','P77')
INSERT INTO [image] VALUES ('I188',N'Flying album handmade Somewhere in time','views\products\images\p78.webp','P78')
INSERT INTO [image] VALUES ('I189',N'Flying album handmade Somewhere in time','views\products\images\p78_1.webp','P78')
INSERT INTO [image] VALUES ('I190',N'Flying album handmade Somewhere in time','views\products\images\p78_2.webp','P78')
INSERT INTO [image] VALUES ('I191',N'Flying album handmade A Moment in Time','views\products\images\p79.webp','P79')
INSERT INTO [image] VALUES ('I192',N'Flying album handmade A Moment in Time','views\products\images\p79_1.webp','P79')
INSERT INTO [image] VALUES ('I193',N'Flying album handmade A Moment in Time','views\products\images\p79_2.webp','P79')
INSERT INTO [image] VALUES ('I194',N'Flying album vintage Memories','views\products\images\p80.webp','P80')
INSERT INTO [image] VALUES ('I195',N'Flying album vintage Memories','views\products\images\p80_1.webp','P80')
INSERT INTO [image] VALUES ('I196',N'Flying album vintage Memories','views\products\images\p80_2.webp','P80')
INSERT INTO [image] VALUES ('I197',N'Sổ ký tên đám cưới handmade','views\products\images\p81.webp','P81')
INSERT INTO [image] VALUES ('I198',N'Sổ ký tên đám cưới handmade','views\products\images\p81_1.webp','P81')
INSERT INTO [image] VALUES ('I199',N'Sổ ký tên đám cưới handmade','views\products\images\p81_2.webp','P81')
INSERT INTO [image] VALUES ('I200',N'Exploding love box album handmade','views\products\images\p82.webp','P82')
INSERT INTO [image] VALUES ('I201',N'Exploding love box album handmade','views\products\images\p82_1.webp','P82')
INSERT INTO [image] VALUES ('I202',N'Exploding love box album handmade','views\products\images\p82_2.webp','P82')
INSERT INTO [image] VALUES ('I203',N'Mini Love Card-Album Handmade','views\products\images\p83.webp','P83')
INSERT INTO [image] VALUES ('I204',N'Mini Love Card-Album Handmade','views\products\images\p83_1.webp','P83')
INSERT INTO [image] VALUES ('I205',N'Mini Love Card-Album Handmade','views\products\images\p83_2.jpg','P83')
INSERT INTO [image] VALUES ('I206',N'ALBUM TỰ TRANG TRÍ (P.I) - SCRAPBOOK','views\products\images\p84.webp','P84')
INSERT INTO [image] VALUES ('I207',N'ALBUM TỰ TRANG TRÍ (P.II) - ALBUM DIY','views\products\images\p85.webp','P85')
INSERT INTO [image] VALUES ('I208',N'ALBUM TỰ TRANG TRÍ (P.II) - ALBUM DIY','views\products\images\p85_1.webp','P85')
INSERT INTO [image] VALUES ('I209',N'Album tự trang trí Vân gỗ trắng','views\products\images\p86.webp','P86')
INSERT INTO [image] VALUES ('I210',N'Album tự trang trí Vân gỗ trắng','views\products\images\p86_1.webp','P86')
INSERT INTO [image] VALUES ('I211',N'Album tự trang trí Vân gỗ trắng','views\products\images\p86_2.webp','P86')
INSERT INTO [image] VALUES ('I212',N'Album DIY Vân gỗ Đỏ','views\products\images\p87.webp','P87')
INSERT INTO [image] VALUES ('I213',N'Album DIY Vân gỗ Đỏ','views\products\images\p87_1.webp','P87')
INSERT INTO [image] VALUES ('I214',N'Album DIY Vân gỗ Đỏ','views\products\images\p87_2.webp','P87')
INSERT INTO [image] VALUES ('I215',N'Album DIY Vân gỗ Pastel','views\products\images\p88.webp','P88')
INSERT INTO [image] VALUES ('I216',N'Album DIY Vân gỗ Pastel','views\products\images\p88_1.webp','P88')
INSERT INTO [image] VALUES ('I217',N'Album DIY Vân gỗ Pastel','views\products\images\p88_2.webp','P88')
INSERT INTO [image] VALUES ('I218',N'Album DIY Sọc nhỏ','views\products\images\p89.webp','P89')
INSERT INTO [image] VALUES ('I219',N'Album DIY Sọc nhỏ','views\products\images\p89_1.webp','P89')
INSERT INTO [image] VALUES ('I220',N'Album DIY Sọc nhỏ','views\products\images\p89_2.webp','P89')
INSERT INTO [image] VALUES ('I221',N'Scrapbook handmade FOLIO','views\products\images\p90.webp','P90')
INSERT INTO [image] VALUES ('I222',N'Scrapbook handmade FOLIO','views\products\images\p90_1.webp','P90')
INSERT INTO [image] VALUES ('I223',N'Scrapbook handmade FOLIO','views\products\images\p90_2.webp','P90')
INSERT INTO [image] VALUES ('I224',N'Sổ ký tên handmade Save the date','views\products\images\p91.webp','P91')
INSERT INTO [image] VALUES ('I225',N'Sổ ký tên handmade Save the date','views\products\images\p91_1.webp','P91')
INSERT INTO [image] VALUES ('I226',N'Sổ ký tên handmade Save the date','views\products\images\p91_2.webp','P91')
INSERT INTO [image] VALUES ('I227',N'Sổ ký tên Our Story','views\products\images\p92.webp','P92')
INSERT INTO [image] VALUES ('I228',N'Sổ ký tên Our Story','views\products\images\p92_1.webp','P92')
INSERT INTO [image] VALUES ('I229',N'Sổ ký tên Our Story','views\products\images\p92_2.webp','P92')
INSERT INTO [image] VALUES ('I230',N'Sổ ký tên ngày cưới Let me love you','views\products\images\p93.webp','P93')
INSERT INTO [image] VALUES ('I231',N'Sổ ký tên ngày cưới Let me love you','views\products\images\p93_1.webp','P93')
INSERT INTO [image] VALUES ('I232',N'Sổ ký tên Happy Light','views\products\images\p94.webp','P94')
INSERT INTO [image] VALUES ('I233',N'Sổ ký tên Happy Light','views\products\images\p94_1.webp','P94')
INSERT INTO [image] VALUES ('I234',N'Sổ ký tên Happy Light','views\products\images\p94_2.webp','P94')
INSERT INTO [image] VALUES ('I235',N'Sổ ký tên Happy Forest','views\products\images\p95.webp','P95')
INSERT INTO [image] VALUES ('I236',N'Sổ ký tên Tiny Love','views\products\images\p96.webp','P96')
INSERT INTO [image] VALUES ('I237',N'Sổ ký tên Tiny Love','views\products\images\p96_1.webp','P96')
INSERT INTO [image] VALUES ('I238',N'Album tự thiết kế Baby photo GIRL (27cm*27cm)','views\products\images\p97.webp','P97')
INSERT INTO [image] VALUES ('I239',N'Album tự thiết kế Baby photo GIRL (27cm*27cm)','views\products\images\p97_1.webp','P97')
INSERT INTO [image] VALUES ('I240',N'Album tự thiết kế Baby photo GIRL (27cm*27cm)','views\products\images\p97_2.webp','P97')
INSERT INTO [image] VALUES ('I241',N'Guest Book Feeling good','views\products\images\p98.webp','P98')
INSERT INTO [image] VALUES ('I242',N'Guest Book Feeling good','views\products\images\p98_1.webp','P98')
INSERT INTO [image] VALUES ('I243',N'Guestbook - sổ ký tên đám cưới Memory Book','views\products\images\p99.webp','P99')
INSERT INTO [image] VALUES ('I244',N'Guestbook - sổ ký tên đám cưới Memory Book','views\products\images\p99_1.webp','P99')
INSERT INTO [image] VALUES ('I245',N'Album DIY gáy lò xo tiện dụng Paris Je Táime','views\products\images\p100.webp','P100')
INSERT INTO [image] VALUES ('I246',N'Album DIY gáy lò xo tiện dụng Paris Je Táime','views\products\images\p100_1.webp','P100')
INSERT INTO [image] VALUES ('I247',N'Album DIY gáy lò xo tiện dụng Paris Je Táime','views\products\images\p100_2.webp','P100')
INSERT INTO [image] VALUES ('I248',N'Bình cắm hoa LYON','views\products\images\p101.webp','P101')
INSERT INTO [image] VALUES ('I249',N'Bình cắm hoa LYON','views\products\images\p101_1.webp','P101')
INSERT INTO [image] VALUES ('I250',N'Bình cắm hoa LYON','views\products\images\p101_2.webp','P101')
INSERT INTO [image] VALUES ('I251',N'Bình sứ trang trí Vintage','views\products\images\p102.webp','P102')
INSERT INTO [image] VALUES ('I252',N'Bình sứ trang trí Vintage','views\products\images\p102_1.webp','P102')
INSERT INTO [image] VALUES ('I253',N'Bình sứ trang trí Vintage','views\products\images\p102_2.webp','P102')
INSERT INTO [image] VALUES ('I254',N'Bình cắm hoa trang trí dây thừng','views\products\images\p103.webp','P103')
INSERT INTO [image] VALUES ('I255',N'Bình cắm hoa trang trí dây thừng','views\products\images\p103_1.webp','P103')
INSERT INTO [image] VALUES ('I256',N'Bình cắm hoa trang trí dây thừng','views\products\images\p103_2.webp','P103')
INSERT INTO [image] VALUES ('I257',N'Chai thủy tinh quấn thừng lớn','views\products\images\p104.webp','P104')
INSERT INTO [image] VALUES ('I258',N'Chai thủy tinh quấn thừng lớn','views\products\images\p104_1.webp','P104')
INSERT INTO [image] VALUES ('I259',N'Chai thủy tinh quấn thừng lớn','views\products\images\p104_2.webp','P104')
INSERT INTO [image] VALUES ('I260',N'Bình gốm cao giả cổ hoa văn vintage','views\products\images\p105.webp','P105')
INSERT INTO [image] VALUES ('I261',N'Bình gốm cao giả cổ hoa văn vintage','views\products\images\p105_1.webp','P105')
INSERT INTO [image] VALUES ('I262',N'Bình gốm cao giả cổ hoa văn vintage','views\products\images\p105_2.webp','P105')
INSERT INTO [image] VALUES ('I263',N'Khay sứ giả cổ','views\products\images\p106.webp','P106')
INSERT INTO [image] VALUES ('I264',N'Khay sứ giả cổ','views\products\images\p106_1.webp','P106')
INSERT INTO [image] VALUES ('I265',N'Khay sứ giả cổ','views\products\images\p106_2.webp','P106')
INSERT INTO [image] VALUES ('I266',N'Giá để rượu vang gốm giả cổ','views\products\images\p107.webp','P107')
INSERT INTO [image] VALUES ('I267',N'Giá để rượu vang gốm giả cổ','views\products\images\p107_1.webp','P107')
INSERT INTO [image] VALUES ('I268',N'Giá để rượu vang gốm giả cổ','views\products\images\p107_2.webp','P107')
INSERT INTO [image] VALUES ('I269',N'Đế để rượu Nhân Sư Ai Cập','views\products\images\p108.webp','P108')
INSERT INTO [image] VALUES ('I270',N'Đế để rượu Nhân Sư Ai Cập','views\products\images\p108_1.webp','P108')
INSERT INTO [image] VALUES ('I271',N'Đế để rượu Nhân Sư Ai Cập','views\products\images\p108_2.webp','P108')
INSERT INTO [image] VALUES ('I272',N'Giá rượu Mèo Thần Ai Cập','views\products\images\p109.webp','P109')
INSERT INTO [image] VALUES ('I273',N'Giá rượu Mèo Thần Ai Cập','views\products\images\p109_1.webp','P109')
INSERT INTO [image] VALUES ('I274',N'Bình sứ Le Jardinier','views\products\images\p110.webp','P110')
INSERT INTO [image] VALUES ('I275',N'Bình sứ Le Jardinier','views\products\images\p110_1.webp','P110')
INSERT INTO [image] VALUES ('I276',N'Cốc vintage','views\products\images\p111.webp','P111')
INSERT INTO [image] VALUES ('I277',N'Cốc vintage','views\products\images\p111_1.webp','P111')
INSERT INTO [image] VALUES ('I278',N'Cốc vintage','views\products\images\p111_2.webp','P111')
INSERT INTO [image] VALUES ('I279',N'Ly sứ vintage phong cảnh châu Âu','views\products\images\p112.webp','P112')
INSERT INTO [image] VALUES ('I280',N'Ly sứ vintage phong cảnh châu Âu','views\products\images\p112_1.webp','P112')
INSERT INTO [image] VALUES ('I281',N'Ly sứ vintage phong cảnh châu Âu','views\products\images\p112_2.webp','P112')
INSERT INTO [image] VALUES ('I282',N'Bình sứ xinh xắn Dream House','views\products\images\p113.webp','P113')
INSERT INTO [image] VALUES ('I283',N'Bình sứ xinh xắn Dream House','views\products\images\p113_1.webp','P113')
INSERT INTO [image] VALUES ('I284',N'Bình sứ xinh xắn Dream House','views\products\images\p113_2.webp','P113')
INSERT INTO [image] VALUES ('I285',N'Ly sứ starbucks coffee','views\products\images\p114.webp','P114')
INSERT INTO [image] VALUES ('I286',N'Ly sứ starbucks coffee','views\products\images\p114_1.webp','P114')
INSERT INTO [image] VALUES ('I287',N'Ly sứ starbucks coffee','views\products\images\p114_2.webp','P114')
INSERT INTO [image] VALUES ('I288',N'Ly sứ vintage street','views\products\images\p115.webp','P115')
INSERT INTO [image] VALUES ('I289',N'Ly sứ vintage street','views\products\images\p115_1.webp','P115')
INSERT INTO [image] VALUES ('I290',N'Ly sứ vintage street','views\products\images\p115_2.webp','P115')
INSERT INTO [image] VALUES ('I291',N'Bình hoa gốm trắng GRID','views\products\images\p116.webp','P116')
INSERT INTO [image] VALUES ('I292',N'Bình hoa gốm trắng GRID','views\products\images\p116_1.webp','P116')
INSERT INTO [image] VALUES ('I293',N'Bình hoa gốm trắng GRID','views\products\images\p116_2.webp','P116')
INSERT INTO [image] VALUES ('I294',N'Bình hoa gốm giả cổ trang trí nâu cao cổ tròn','views\products\images\p117.webp','P117')
INSERT INTO [image] VALUES ('I295',N'Bình hoa gốm giả cổ trang trí nâu cao cổ tròn','views\products\images\p117_1.webp','P117')
INSERT INTO [image] VALUES ('I296',N'Bình hoa gốm giả cổ trang trí nâu cao cổ tròn','views\products\images\p117_2.webp','P117')
INSERT INTO [image] VALUES ('I297',N'Bình sứ giả cổ Victoria','views\products\images\p118.webp','P118')
INSERT INTO [image] VALUES ('I298',N'Bình sứ giả cổ Victoria','views\products\images\p118_1.webp','P118')
INSERT INTO [image] VALUES ('I299',N'Hộp đựng bút R102','views\products\images\p119.jpg','P119')
INSERT INTO [image] VALUES ('I300',N'Hộp đựng bút R102','views\products\images\p119_1.jpg','P119')
INSERT INTO [image] VALUES ('I301',N'Hộp đựng bút R102','views\products\images\p119_2.jpg','P119')
INSERT INTO [image] VALUES ('I302',N'Mèo thần tài R104','views\products\images\p120.jpg','P120')
INSERT INTO [image] VALUES ('I303',N'Mèo thần tài R104','views\products\images\p120_1.jpg','P120')
INSERT INTO [image] VALUES ('I304',N'Mèo thần tài R104','views\products\images\p120_2.jpg','P120')
INSERT INTO [image] VALUES ('I305',N'Tượng Hươu trang trí R103','views\products\images\p121.jpg','P121')
INSERT INTO [image] VALUES ('I306',N'Tượng Hươu trang trí R103','views\products\images\p121_1.jpg','P121')
INSERT INTO [image] VALUES ('I307',N'Tượng Hươu trang trí R103','views\products\images\p121_2.jpg','P121')
INSERT INTO [image] VALUES ('I308',N'Xe máy mô hình trang trí R101','views\products\images\p122.jpg','P122')
INSERT INTO [image] VALUES ('I309',N'Xe máy mô hình trang trí R101','views\products\images\p122_1.jpg','P122')
INSERT INTO [image] VALUES ('I310',N'Xe máy mô hình trang trí R101','views\products\images\p122_2.jpg','P122')
INSERT INTO [image] VALUES ('I311',N'Đèn bão trang trí Vintage','views\products\images\p123.webp','P123')
INSERT INTO [image] VALUES ('I312',N'Đèn bão trang trí Vintage','views\products\images\p123_1.webp','P123')
INSERT INTO [image] VALUES ('I313',N'Đèn bão trang trí Vintage','views\products\images\p123_2.webp','P123')
INSERT INTO [image] VALUES ('I314',N'Móc treo nữ trang vintage','views\products\images\p124.webp','P124')
INSERT INTO [image] VALUES ('I315',N'Móc treo nữ trang vintage','views\products\images\p124_1.webp','P124')
INSERT INTO [image] VALUES ('I316',N'Lọ hoa thủy tinh handmade','views\products\images\p125.webp','P125')
INSERT INTO [image] VALUES ('I317',N'Lọ hoa thủy tinh handmade','views\products\images\p125_1.webp','P125')
INSERT INTO [image] VALUES ('I318',N'Hoa lavender oải hương handmade trang trí nhà cửa','views\products\images\p126.webp','P126')
INSERT INTO [image] VALUES ('I319',N'Hoa lavender oải hương handmade trang trí nhà cửa','views\products\images\p126_1.webp','P126')
INSERT INTO [image] VALUES ('I320',N'Hoa lavender oải hương handmade trang trí nhà cửa','views\products\images\p126_2.webp','P126')
INSERT INTO [image] VALUES ('I321',N'Hoa chậu handmade - Hoa hồng giấy','views\products\images\p127.webp','P127')
INSERT INTO [image] VALUES ('I322',N'Hoa chậu handmade - Hoa hồng giấy','views\products\images\p127_1.webp','P127')
INSERT INTO [image] VALUES ('I323',N'Hoa chậu handmade - Hoa hồng giấy','views\products\images\p127_2.webp','P127')
INSERT INTO [image] VALUES ('I324',N'Hộp nhạc piano pha lê khắc tên','views\products\images\p128.webp','P128')
INSERT INTO [image] VALUES ('I325',N'Hộp nhạc piano pha lê khắc tên','views\products\images\p128_1.webp','P128')
INSERT INTO [image] VALUES ('I326',N'Hộp nhạc piano pha lê khắc tên','views\products\images\p128_2.webp','P128')
INSERT INTO [image] VALUES ('I327',N'Hộp nhạc gỗ Piano','views\products\images\p129.webp','P129')
INSERT INTO [image] VALUES ('I328',N'Hộp nhạc gỗ Piano','views\products\images\p129_1.webp','P129')
INSERT INTO [image] VALUES ('I329',N'Hộp nhạc gỗ Piano','views\products\images\p129_2.webp','P129')
INSERT INTO [image] VALUES ('I330',N'Hộp nhạc cổ điển camera','views\products\images\p130.webp','P130')
INSERT INTO [image] VALUES ('I331',N'Hộp nhạc cổ điển camera','views\products\images\p130_1.webp','P130')
INSERT INTO [image] VALUES ('I332',N'Hộp nhạc cổ điển camera','views\products\images\p130_2.webp','P130')
INSERT INTO [image] VALUES ('I333',N'Tượng trang trí phòng khách Thinker','views\products\images\p131.webp','P131')
INSERT INTO [image] VALUES ('I334',N'Tượng trang trí phòng khách Thinker','views\products\images\p131_1.webp','P131')
INSERT INTO [image] VALUES ('I335',N'Tượng trang trí phòng khách Thinker','views\products\images\p131_2.webp','P131')
INSERT INTO [image] VALUES ('I336',N'Tượng trang trí vintage không thấy - không nghe -không nói','views\products\images\p132.webp','P132')
INSERT INTO [image] VALUES ('I337',N'Tượng trang trí vintage không thấy - không nghe -không nói','views\products\images\p132_1.webp','P132')
INSERT INTO [image] VALUES ('I338',N'Tượng trang trí vintage không thấy - không nghe -không nói','views\products\images\p132_2.webp','P132')
INSERT INTO [image] VALUES ('I339',N'Xe Vespa mô hình trang trí, phụ kiện chụp ảnh','views\products\images\p133.webp','P133')
INSERT INTO [image] VALUES ('I340',N'Xe Vespa mô hình trang trí, phụ kiện chụp ảnh','views\products\images\p133_1.webp','P133')
INSERT INTO [image] VALUES ('I341',N'Xe Vespa mô hình trang trí, phụ kiện chụp ảnh','views\products\images\p133_2.webp','P133')
INSERT INTO [image] VALUES ('I342',N'Thuyền gỗ vintage decor trang trí, phụ kiện chụp ảnh','views\products\images\p134.webp','P134')
INSERT INTO [image] VALUES ('I343',N'Thuyền gỗ vintage decor trang trí, phụ kiện chụp ảnh','views\products\images\p134_1.webp','P134')
INSERT INTO [image] VALUES ('I344',N'Thuyền gỗ vintage decor trang trí, phụ kiện chụp ảnh','views\products\images\p134_2.webp','P134')



