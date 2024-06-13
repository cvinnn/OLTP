CREATE SCHEMA `OLTP-BAHAR`;
USE `OLTP-BAHAR`;

CREATE TABLE users (
    uuid CHAR(32) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('owner', 'manager', 'user') NOT NULL,
    status TINYINT(1) NOT NULL
);			

CREATE TABLE Shipping (
    uuid VARCHAR(32) NOT NULL PRIMARY KEY,
    user_id VARCHAR(32) NOT NULL,
    alamat VARCHAR(255) NOT NULL,
    kota VARCHAR(100) NOT NULL,
    provinsi VARCHAR(100) NOT NULL,
    negara VARCHAR(100) NOT NULL,
    kode_pos VARCHAR(20) NOT NULL,
    nomor_telepon VARCHAR(20) NOT NULL,
    `status` VARCHAR(20) NOT NULL, -- Kolom status baru
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(uuid)
);												

CREATE TABLE transaction (
    uuid VARCHAR(32) PRIMARY KEY,
    shipping_uuid VARCHAR(32) NOT NULL,
    total_amount INT NOT NULL,
    payment_type VARCHAR(20) NOT NULL,
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`shipping_uuid`) REFERENCES `Shipping`(`uuid`)
);		

CREATE TABLE Category
(
    Category_id INT NOT NULL PRIMARY KEY,
    Category_Name VARCHAR(255) NOT NULL
);		

CREATE TABLE Product
(
    Nama_Product VARCHAR(255) NOT NULL,
    Price INT NOT NULL,
    ItemID VARCHAR(255) PRIMARY KEY NOT NULL,
    Img_Detail_1 VARCHAR(255),
    Img_Detail_2 VARCHAR(255),
    Img_Detail_3 VARCHAR(255),
    Description TEXT NOT NULL,
    Stock INT NOT NULL,
    CategoryID INT NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES Category(Category_id)
);					

CREATE TABLE transaction_detail (
    id CHAR(32) PRIMARY KEY,
    trxid CHAR(36) NOT NULL,
    item CHAR(36) NOT NULL,
    qty INT NOT NULL,
    subtotal INT NOT NULL,
    FOREIGN KEY (trxid) REFERENCES transaction(uuid),
    FOREIGN KEY (item) REFERENCES Product(ItemID)
);														

CREATE TABLE Cart (
    uuid CHAR(32) PRIMARY KEY,
    userId CHAR(32),
    total INT,
    datentime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (userId) REFERENCES users(uuid)
);				

CREATE TABLE CartDetails (
    uuid CHAR(32) NOT NULL,
    productId CHAR(36),
    cartId CHAR(32), 
    qty INT NOT NULL,
    subTotal BIGINT,
    PRIMARY KEY (uuid),
    FOREIGN KEY (cartId) REFERENCES Cart(uuid)
);				

INSERT INTO `users`
(`uuid`,
`name`,
`email`,
`password`,
`role`,
`status`)
VALUES
('1a2b3c4d5e6f7g8h9i0j1k2l3m4n5o6o' ,'Deni Hidayat' ,'deni2@gmail.com' ,'$2y$10$MJ2rEPEqk9yZAKml1mhlJuo.LUkc2nV.YKrXZXtsoJ3o4xQmFv1qi' ,'user' ,'1'),
('1a2b3c4d5e6f7g8h9i0j1k2l3m4n5o6p' ,'Deni Hidayat' ,'deni@gmail.com' ,'$2y$10$MJ2rEPEqk9yZAKml1mhlJuo.LUkc2nV.YKrXZXtsoJ3o4xQmFv1qi' ,'user' ,'1'),
('1e2f3g4h5i6j7k8l9m0n1o2p3q4r5s6t' ,'Hani Wijaya' ,'hani.wijaya@gmail.com' ,'$2y$10$N9A7H3L2N1D8T6X5P4M0K9O2B5A4C6Y7W8G1F3R0A9J6U2D7K5T5H' ,'user' ,'1'),
('1i2j3k4l5m6n7o8p9q0r1s2t3u4v5w6x' ,'Lia Pratama' ,'lia.pratama@gmail.com' ,'$2y$10$R9E7H3L2N1D8T6X5P4M0K9O2B5A4C6Y7W8G1F3R0A9J6U2D7K5T6L' ,'user' ,'1'),
('1k2l3m4n5o6p7q8r9s0t1u2v3w4x5y6o' ,'Nurjanah' ,'nurjanah2@gmail.com' ,'$2y$10$T7H9J1L3V6D8P5N2B0O4K9M1C6X3Y2W7A5R8E0J4U2G9P6L8K1V7D' ,'user' ,'1');

INSERT INTO `shipping`
(`uuid`,
`user_id`,
`alamat`,
`kota`,
`provinsi`,
`negara`,
`kode_pos`,
`nomor_telepon`,
`status`)
VALUES
('3e8f4e55-17b0-11ef-9b89-0897987d' ,'1a2b3c4d5e6f7g8h9i0j1k2l3m4n5o6o' ,'Jalan Setiabudi No. 62' ,'Jakarta' ,'Jawa Timur' ,'Indonesia' ,'53292' ,'08509079342' ,'completed'),
('3e8f56d8-17b0-11ef-9b89-0897987d' ,'1a2b3c4d5e6f7g8h9i0j1k2l3m4n5o6p' ,'Jalan Gandaria No. 40' ,'Medan' ,'Jawa Timur' ,'Indonesia' ,'92008' ,'08628399488' ,'waiting'),
('3e8f5f7d-17b0-11ef-9b89-0897987d' ,'1e2f3g4h5i6j7k8l9m0n1o2p3q4r5s6t' ,'Jalan Melawai No. 83' ,'Yogyakarta' ,'Jawa Timur' ,'Indonesia' ,'87417' ,'08442456197' ,'confirmed'),
('3e8f6805-17b0-11ef-9b89-0897987d' ,'1i2j3k4l5m6n7o8p9q0r1s2t3u4v5w6x' ,'Jalan Diponegoro No. 7' ,'Jakarta' ,'Jawa Timur' ,'Indonesia' ,'90608' ,'08812743320' ,'confirmed'),
('3e8f706a-17b0-11ef-9b89-0897987d' ,'1k2l3m4n5o6p7q8r9s0t1u2v3w4x5y6o' ,'Jalan Pahlawan No. 12' ,'Semarang' ,'Jawa Tengah' ,'Indonesia' ,'65650' ,'08659097893' ,'confirmed');

INSERT INTO `transaction`
(`uuid`,
`shipping_uuid`,
`total_amount`,
`payment_type`)
VALUES
('5aa1c4fc-17b6-11ef-9b89-0897987d' ,'3e8f4e55-17b0-11ef-9b89-0897987d' ,'7136600' ,'qris'),
('5aa1c88a-17b6-11ef-9b89-0897987d' ,'3e8f56d8-17b0-11ef-9b89-0897987d' ,'3355200' ,'bank_transfer'),
('5aa1cc24-17b6-11ef-9b89-0897987d' ,'3e8f5f7d-17b0-11ef-9b89-0897987d' ,'7635000' ,'bank_transfer'),
('5aa1cfaf-17b6-11ef-9b89-0897987d' ,'3e8f6805-17b0-11ef-9b89-0897987d' ,'170000000' ,'qris'),
('5aa1d33f-17b6-11ef-9b89-0897987d' ,'3e8f706a-17b0-11ef-9b89-0897987d' ,'2215000' ,'bank_transfer');

INSERT INTO `category`
(`Category_id`,
`Category_Name`)
VALUES
('1' ,'ruangtamu'),
('2' ,'ruangkerja'),
('3' ,'ruangtidur'),
('4' ,'ruangdapur');

INSERT INTO `product`
(`Nama_Product`,
`Price`,
`ItemID`,
`Img_Detail_1`,
`Img_Detail_2`,
`Img_Detail_3`,
`Description`,
`Stock`,
`CategoryID`)
VALUES
('FurniCrafts Kursi Kantor Sandaran Rendah Shivier' ,'1784150' ,'0d732f96-290e-47a7-b8d7-d7f08a354f9e' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/04/Shivier-Mid-Chair-Black_24007928-12.jpg' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/04/Shivier-Mid-Chair-Black-4-12.jpg' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/04/Shivier-Mid-Chair-Black-3-12.jpg' ,'Detail Produk & Spesifikasi

Tuas pengatur tinggi dudukan
Dengan penopang lengan
Dimensi produk : 58×63×80 ketinggian bisa mencapai (96)cm
Material : High Back Swivel Chairs; Frame: Iron Chromed material; Back&Seat:38#density foam elasticity PU upholstered; Armrest:Iron chromed; Mechanism:Tilt function; Base:Iron' ,'438' ,'3'),
('FurniCrafts Meja Tamu Samping Persegi Lois 59x59x40 NS2068-1 Walnut/Black' ,'559200' ,'0ecbff21-2377-4850-b0e6-d61e937c3f24' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/03/Lois-end-table-12-12.jpg' ,'https://play.google.com/store/apps/details?id=appinventor.ai_bobitetsuya.atria5&pcampaignid=web_share' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/03/Lois-end-table-12-12.jpg' ,'Detail Produk & Spesifikasi

Desain modern
Dimensi produk :59 x 59 x 40 cm
Material : TOP TABLE MDF PB FINISHING MELAMINE,KAKI METAL' ,'335' ,'1'),
('FurniCrafts Chest Drawer Kazumi 1007 AX-KB46 102x40x76Cm Pink White' ,'2545000' ,'0edb2388-0c20-4f00-923a-bdf2f98d3e8c' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2024/01/WEB-2024-01-24T084146.655-12.png' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2024/01/NEW-Web-banner-700-x-700-px-1-03-12.jpg' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2024/01/NEW-Web-banner-700-x-700-px-1-02-12.jpg' ,'Detail Produk & Spesifikasi
Ukuran : 102x40x76Cm
Warna : Pink White
Material : Mdf+Pb Fin. Painting with Melamin (E1)' ,'221' ,'4'),
('FurniCrafts Kitchen L Shape Coklat' ,'34000000' ,'0f4ff0b0-83c4-464e-9b5c-ef63f034f171' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/03/6350b51f-5fff-4dcb-ad0d-15295402d636-12.jpg' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/03/1cc61e15-2e6e-442b-b3f1-a6c71a6f125f-12.jpg' ,'https://play.google.com/store/apps/details?id=appinventor.ai_bobitetsuya.atria5&pcampaignid=web_share' ,'Detail Product :
Ukuran : Kitchen L Shape : 300×60
kitchen Island/meja Bar  : 160×60
Material : – Kabinet Bawah : Playwood Finising HPL Wood Grain ( Motif Kayu ) dan laci SoftClose
– Kabinet Atas : Playwood Finising HPL Wood Grain ( Motif Kayu ) Pintu Tempred Glass Frame Alumunium
– Shelving : Playwood Finising HPL Wood Grain ( Motif Kayu )
–   kitchen Sink .
 
FREE Kirim dan FREE Instal JABODETABEK KOTA
NOTE :  HANYA DISPLAY Only kunjungui toko kami di JAKARTA ATRIA FURNITURE PURI INDAH
– jl. lingkar luar barat no 108 kembangan selatan 0215800757 KEMBANGAN SELATAN JAKARTA BARAT' ,'112' ,'4'),
('FurniCrafts Tempat Tidur SUYO Metal Bed Single 9020 AT-MB07 Gray/Oak' ,'2215000' ,'129347eb-8781-4a3c-937e-3be69ccf58dd' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/06/Suyo-1-12.jpg' ,'https://play.google.com/store/apps/details?id=appinventor.ai_bobitetsuya.atria5&pcampaignid=web_share' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/06/Suyo-1-12.jpg' ,'Detail Produk & Spesifikasi

Dimensi produk           : 97 x 80 x 210 cm
Ukuran Mattress         : 90×200 cm
Material                        : Mdf+Pb Fin. Melamin (E1) +  Frame Metal Fin. Painting
Warna                            : Gray / Oak' ,'407' ,'4');

INSERT INTO `transaction_detail`
(`id`,
`trxid`,
`item`,
`qty`,
`subtotal`)
VALUES
('4073e83a-17bc-11ef-9b89-0897987d' ,'5aa1c4fc-17b6-11ef-9b89-0897987d' ,'0d732f96-290e-47a7-b8d7-d7f08a354f9e' ,'4' ,'7136600'),
('4073eda1-17bc-11ef-9b89-0897987d' ,'5aa1c88a-17b6-11ef-9b89-0897987d' ,'0ecbff21-2377-4850-b0e6-d61e937c3f24' ,'6' ,'3355200'),
('4073f4e0-17bc-11ef-9b89-0897987d' ,'5aa1cc24-17b6-11ef-9b89-0897987d' ,'0edb2388-0c20-4f00-923a-bdf2f98d3e8c' ,'3' ,'7635000'),
('4073fa27-17bc-11ef-9b89-0897987d' ,'5aa1cfaf-17b6-11ef-9b89-0897987d' ,'0f4ff0b0-83c4-464e-9b5c-ef63f034f171' ,'5' ,'170000000'),
('4073fef0-17bc-11ef-9b89-0897987d' ,'5aa1d33f-17b6-11ef-9b89-0897987d' ,'129347eb-8781-4a3c-937e-3be69ccf58dd' ,'1' ,'2215000');

INSERT INTO `cart`
(`uuid`,
`userId`,
`total`)
VALUES
('1d1b4b58227911ef877d0897987d70ff' ,'1a2b3c4d5e6f7g8h9i0j1k2l3m4n5o6o' ,'12489050'),
('1d1b580e227911ef877d0897987d70ff' ,'1a2b3c4d5e6f7g8h9i0j1k2l3m4n5o6p' ,'2796000'),
('1d1b64cc227911ef877d0897987d70ff' ,'1e2f3g4h5i6j7k8l9m0n1o2p3q4r5s6t' ,'12725000'),
('1d1b750f227911ef877d0897987d70ff' ,'1i2j3k4l5m6n7o8p9q0r1s2t3u4v5w6x' ,'238000000'),
('1d1b8064227911ef877d0897987d70ff' ,'1k2l3m4n5o6p7q8r9s0t1u2v3w4x5y6o' ,'13290000');

INSERT INTO `cartdetails`
(`uuid`,
`productId`,
`cartId`,
`qty`,
`subTotal`)
VALUES
('494cf77d227c11ef877d0897987d70ff' ,'0d732f96-290e-47a7-b8d7-d7f08a354f9e' ,'1d1b4b58227911ef877d0897987d70ff' ,'7' ,'12489050'),
('494d14dd227c11ef877d0897987d70ff' ,'0ecbff21-2377-4850-b0e6-d61e937c3f24' ,'1d1b580e227911ef877d0897987d70ff' ,'5' ,'2796000'),
('494d32b3227c11ef877d0897987d70ff' ,'0edb2388-0c20-4f00-923a-bdf2f98d3e8c' ,'1d1b64cc227911ef877d0897987d70ff' ,'5' ,'12725000'),
('494d4b63227c11ef877d0897987d70ff' ,'0f4ff0b0-83c4-464e-9b5c-ef63f034f171' ,'1d1b750f227911ef877d0897987d70ff' ,'7' ,'238000000'),
('494d69bd227c11ef877d0897987d70ff' ,'129347eb-8781-4a3c-937e-3be69ccf58dd' ,'1d1b8064227911ef877d0897987d70ff' ,'6' ,'13290000');


