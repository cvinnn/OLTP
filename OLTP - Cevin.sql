CREATE SCHEMA `OLTP-CEVIN`;
USE `OLTP-CEVIN`;

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
('02b8c3ad43e0482dbb79f3af6f2851e9' ,'Hendra Wijaya' ,'hendra@gmail.com' ,'$2y$10$p1/V05bHYZOE4lsqTEaP8Orft7zt2C5al0BLz8xGJ0.mQh1d0Y5X6' ,'user' ,'1'),
('0d1e2f3g4h5i6j7k8l9m0n1o2p3q4r5s' ,'Gerry Pratama' ,'gerry@gmail.com' ,'$2y$10$M9Z7H3L2N1D8T6X5P4M0K9O2B5A4C6Y7W8G1F3R0A9J6U2D7K5T5G' ,'user' ,'1'),
('0h1i2j3k4l5m6n7o8p9q0r1s2t3u4v5w' ,'Kiki Pratama' ,'kiki.pratama@gmail.com' ,'$2y$10$Q9D7H3L2N1D8T6X5P4M0K9O2B5A4C6Y7W8G1F3R0A9J6U2D7K5T6K' ,'user' ,'1'),
('0j1k2l3m4n5o6p7q8r9s0t1u2v3w4x5t' ,'Mira Lesmana' ,'mira2@gmail.com' ,'$2y$10$S8F9H7J2M1L4T6N5X0K7D3P9G8O2V1B4W5C9R0A3E6Y2J8U5T7P3N' ,'user' ,'1'),
('0j1k2l3m4n5o6p7q8r9s0t1u2v3w4x5y' ,'Mira Lesmana' ,'mira@gmail.com' ,'$2y$10$S8F9H7J2M1L4T6N5X0K7D3P9G8O2V1B4W5C9R0A3E6Y2J8U5T7P3N' ,'user' ,'1');

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
('3e8d3840-17b0-11ef-9b89-0897987d' ,'02b8c3ad43e0482dbb79f3af6f2851e9' ,'Jalan Kemanggisan No. 40' ,'Jakarta' ,'Sumatera Utara' ,'Indonesia' ,'77452' ,'08858682342' ,'completed'),
('3e8ec94a-17b0-11ef-9b89-0897987d' ,'0d1e2f3g4h5i6j7k8l9m0n1o2p3q4r5s' ,'Jalan Kuningan No. 12' ,'Medan' ,'Jawa Timur' ,'Indonesia' ,'27069' ,'08464637498' ,'confirmed'),
('3e8ed813-17b0-11ef-9b89-0897987d' ,'0h1i2j3k4l5m6n7o8p9q0r1s2t3u4v5w' ,'Jalan Veteran No. 69' ,'Surabaya' ,'Jawa Timur' ,'Indonesia' ,'83348' ,'08183791622' ,'waiting'),
('3e8f0e2b-17b0-11ef-9b89-0897987d' ,'0j1k2l3m4n5o6p7q8r9s0t1u2v3w4x5t' ,'Jalan Veteran No. 23' ,'Medan' ,'Sumatera Utara' ,'Indonesia' ,'57028' ,'08162523016' ,'completed'),
('3e8f1979-17b0-11ef-9b89-0897987d' ,'0j1k2l3m4n5o6p7q8r9s0t1u2v3w4x5y' ,'Jalan Kramat Pulo No. 90' ,'Yogyakarta' ,'Jawa Tengah' ,'Indonesia' ,'66018' ,'08670102246' ,'confirmed');

INSERT INTO `transaction`
(`uuid`,
`shipping_uuid`,
`total_amount`,
`payment_type`)
VALUES
('5a9fd87f-17b6-11ef-9b89-0897987d' ,'3e8d3840-17b0-11ef-9b89-0897987d' ,'1139000' ,'qris'),
('5aa15985-17b6-11ef-9b89-0897987d' ,'3e8ec94a-17b0-11ef-9b89-0897987d' ,'3299000' ,'bank_transfer'),
('5aa160f0-17b6-11ef-9b89-0897987d' ,'3e8ed813-17b0-11ef-9b89-0897987d' ,'7797000' ,'bank_transfer'),
('5aa1aa9d-17b6-11ef-9b89-0897987d' ,'3e8f0e2b-17b0-11ef-9b89-0897987d' ,'5836000' ,'qris'),
('5aa1af20-17b6-11ef-9b89-0897987d' ,'3e8f1979-17b0-11ef-9b89-0897987d' ,'10608300' ,'bank_transfer');

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
('FurniCrafts Meja Nakas Nixie Pink White' ,'569500' ,'00205a4d-fb8b-4424-b349-95f97fc19e94' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/12/4-214-13.png' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/12/4-214-13.png' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/12/WEB-2-470-13.png' ,'Dimensi nakas : 48 x 40 x 47 cm
Material : mdf, metal
Finishing : high gloss' ,'481' ,'4'),
('FurniCrafts Leben Folding Training Table Mocha Oak' ,'3299000' ,'0021b071-64be-49c3-9b93-843cb4e02efb' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/10/Meja-Sano-White-27-20-10.jpg' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/10/web-banner-700-x-700-px-1-02-12.jpg' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/10/web-banner-700-x-700-px-1-03-12.jpg' ,'Deskripsi Produk :
 
Size Meja  : – 140x80x75 Cm
Material : Daun Meja: Keramik,
Kaki Meja: Besi dilapisi serbuk epoksi
Warna  Meja  : White Glossy
-DESIGN MEJA MINIMALIS, KOKOH DAN MEWAH DENGAN MOTIF MARBLE -BAHAN SINTERED STONE SANGAT TAHAN TERHADAP PANAS, CAIRAN KIMIA, DLL' ,'171' ,'2'),
('FurniCrafts Meja Tamu Evelyn Square 80x80x42 AT-CT19 Stone White /Gold Hairline Leg' ,'2599000' ,'002bcfd0-3a9e-4e9b-9333-f0eb788a3c2c' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2024/01/WEB-2-140-12.png' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2024/01/WEB-3-156-12.png' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2024/01/WEB-193-12.png' ,'No Description' ,'356' ,'1'),
('FurniCrafts Meja Gaming Ryzen' ,'1459000' ,'063c161b-009d-45d7-b616-bbde68b4df05' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/05/Ryzen-1-1-11.jpg' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/05/Ryzen-2-1-11.jpg' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/05/Ryzen-3-1-11.jpg' ,'Detail Produk & Spesifikasi

Material : MDF PB ,E1
Finishing : Melamine
Dimensi : 110 x 60 x 75 cm
Warna  : Balck' ,'262' ,'3'),
('FurniCrafts Meja Kerja Manager Leben 1608 Mocha Oak' ,'3536100' ,'06f588bb-97c1-49c2-9de1-93f14a1d252f' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/03/leben-manager-desk-16-12.jpg' ,'https://play.google.com/store/apps/details?id=appinventor.ai_bobitetsuya.atria5&pcampaignid=web_share' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/03/leben-manager-desk-16-12.jpg' ,'Detail Produk & Spesifikasi

Desain moderen dan elegan
Dimensi produk : 160 x 80 x 75 cm
Material : Melamine, Metal Leg, Cable Hole, Modesty' ,'327' ,'3');

INSERT INTO `transaction_detail`
(`id`,
`trxid`,
`item`,
`qty`,
`subtotal`)
VALUES
('4071f20a-17bc-11ef-9b89-0897987d' ,'5a9fd87f-17b6-11ef-9b89-0897987d' ,'00205a4d-fb8b-4424-b349-95f97fc19e94' ,'2' ,'1139000'),
('407369b9-17bc-11ef-9b89-0897987d' ,'5aa15985-17b6-11ef-9b89-0897987d' ,'0021b071-64be-49c3-9b93-843cb4e02efb' ,'1' ,'3299000'),
('40737690-17bc-11ef-9b89-0897987d' ,'5aa160f0-17b6-11ef-9b89-0897987d' ,'002bcfd0-3a9e-4e9b-9333-f0eb788a3c2c' ,'3' ,'7797000'),
('40739cb6-17bc-11ef-9b89-0897987d' ,'5aa1aa9d-17b6-11ef-9b89-0897987d' ,'063c161b-009d-45d7-b616-bbde68b4df05' ,'4' ,'5836000'),
('4073a6a7-17bc-11ef-9b89-0897987d' ,'5aa1af20-17b6-11ef-9b89-0897987d' ,'06f588bb-97c1-49c2-9de1-93f14a1d252f' ,'3' ,'10608300');

INSERT INTO `cart`
(`uuid`,
`userId`,
`total`)
VALUES
('1d192695227911ef877d0897987d70ff' ,'02b8c3ad43e0482dbb79f3af6f2851e9' ,'1139000'),
('1d1aaa61227911ef877d0897987d70ff' ,'0d1e2f3g4h5i6j7k8l9m0n1o2p3q4r5s' ,'32990000'),
('1d1ac345227911ef877d0897987d70ff' ,'0h1i2j3k4l5m6n7o8p9q0r1s2t3u4v5w' ,'20792000'),
('1d1adcc5227911ef877d0897987d70ff' ,'0j1k2l3m4n5o6p7q8r9s0t1u2v3w4x5t' ,'14590000'),
('1d1aecb8227911ef877d0897987d70ff' ,'0j1k2l3m4n5o6p7q8r9s0t1u2v3w4x5y' ,'21216600');

INSERT INTO `cartdetails`
(`uuid`,
`productId`,
`cartId`,
`qty`,
`subTotal`)
VALUES
('494a4869227c11ef877d0897987d70ff' ,'00205a4d-fb8b-4424-b349-95f97fc19e94' ,'1d192695227911ef877d0897987d70ff' ,'2' ,'1139000'),
('494be774227c11ef877d0897987d70ff' ,'0021b071-64be-49c3-9b93-843cb4e02efb' ,'1d1aaa61227911ef877d0897987d70ff' ,'10' ,'32990000'),
('494c0701227c11ef877d0897987d70ff' ,'002bcfd0-3a9e-4e9b-9333-f0eb788a3c2c' ,'1d1ac345227911ef877d0897987d70ff' ,'8' ,'20792000'),
('494c203e227c11ef877d0897987d70ff' ,'063c161b-009d-45d7-b616-bbde68b4df05' ,'1d1adcc5227911ef877d0897987d70ff' ,'10' ,'14590000'),
('494c3b89227c11ef877d0897987d70ff' ,'06f588bb-97c1-49c2-9de1-93f14a1d252f' ,'1d1aecb8227911ef877d0897987d70ff' ,'6' ,'21216600');


