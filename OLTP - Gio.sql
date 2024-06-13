CREATE SCHEMA `OLTP-GIO`;
USE `OLTP-GIO`;

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
('2j3k4l5m6n7o8p9q0r1s2t3u4v5w6x7y' ,'Miko Pratama' ,'miko.pratama@gmail.com' ,'$2y$10$S9F7H3L2N1D8T6X5P4M0K9O2B5A4C6Y7W8G1F3R0A9J6U2D7K5T6M' ,'user' ,'1'),
('2p3q4r5s6t7u8v9w0x1y2z3a4b5c6d7e' ,'Santi Nurhalimah' ,'santi@gmail.com' ,'$2y$10$Y9L7H3L2N1D8T6X5P4M0K9O2B5A4C6Y7W8G1F3R0A9J6U2D7K5T5S' ,'user' ,'1'),
('2t3u4v5w6x7y8z9a0b1c2d3e4f5g6h7i' ,'Winda Pratama' ,'winda.pratama@gmail.com' ,'$2y$10$C9P7H3L2N1D8T6X5P4M0K9O2B5A4C6Y7W8G1F3R0A9J6U2D7K5T6W' ,'user' ,'1'),
('2v3w4x5y6z7a8b9c0d1e2f3g4h5i6j7k' ,'Yulia Andini' ,'yulia@gmail.com' ,'$2y$10$E9R7H3L2N1D8T6X5P4M0K9O2B5A4C6Y7W8G1F3R0A9J6U2D7K5T4Y' ,'user' ,'1'),
('2v3w4x5y6z7a8b9c0d1e2f3g4h5i6j7s' ,'Yunita Safitri' ,'yunita2@gmail.com' ,'$2y$10$E9R7H3J2L1D8T6X5P4M0K9O2B5A4C6Y7W8G1F3R0A9J6U2D7K5T4Y' ,'user' ,'1'),
('2l3m4n5o6p7q8r9s0t1u2v3w4x5y6z7a' ,'Omar Dani' ,'omar@gmail.com' ,'$2y$10$U9F7H2J1L6V4D8N5X3T0K9M8O2Y1P6B3W7C5R0A4J8U6E2G9K5T4L' ,'manager' ,'1');

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
('17431487-17b1-11ef-9b89-0897987d' ,'2j3k4l5m6n7o8p9q0r1s2t3u4v5w6x7y' ,'Jalan Sudirman No. 35' ,'Bandung' ,'Sumatera Utara' ,'Indonesia' ,'61233' ,'08991959289' ,'waiting'),
('2p3q4r5s6t7u8v9w0x1y2z3a4b5c6d7e' ,'2p3q4r5s6t7u8v9w0x1y2z3a4b5c6d7e' ,'Jalan Gajah Mada No. 47' ,'Yogyakarta' ,'Jawa Barat' ,'Indonesia' ,'25925' ,'08807653306' ,'confirmed'),
('2t3u4v5w6x7y8z9a0b1c2d3e4f5g6h7i' ,'2t3u4v5w6x7y8z9a0b1c2d3e4f5g6h7i' ,'Jalan Tambak Bayan No. 81' ,'Semarang' ,'Jawa Tengah' ,'Indonesia' ,'22339' ,'08562163167' ,'waiting'),
('2v3w4x5y6z7a8b9c0d1e2f3g4h5i6j7k' ,'2v3w4x5y6z7a8b9c0d1e2f3g4h5i6j7k' ,'Jalan Tambak Bayan No. 78' ,'Yogyakarta' ,'Jawa Tengah' ,'Indonesia' ,'25782' ,'08502721971' ,'shipping'),
('2v3w4x5y6z7a8b9c0d1e2f3g4h5i6j7s' ,'2v3w4x5y6z7a8b9c0d1e2f3g4h5i6j7s' ,'Jalan Gatot Subroto No. 65' ,'Bandung' ,'DKI Jakarta' ,'Indonesia' ,'52446' ,'08936605184' ,'waiting');

INSERT INTO `transaction`
(`uuid`,
`shipping_uuid`,
`total_amount`,
`payment_type`)
VALUES
('8dfb336b-17bb-11ef-a3d9-005056c0' ,'17431487-17b1-11ef-9b89-0897987d' ,'10236000' ,'qris'),
('8dfb4497-17bb-11ef-a3d9-005056c0' ,'2p3q4r5s6t7u8v9w0x1y2z3a4b5c6d7e' ,'7198200' ,'qris'),
('8dfb48ef-17bb-11ef-a3d9-005056c0' ,'2t3u4v5w6x7y8z9a0b1c2d3e4f5g6h7i' ,'1159000' ,'qris'),
('8dfb4cf6-17bb-11ef-a3d9-005056c0' ,'2v3w4x5y6z7a8b9c0d1e2f3g4h5i6j7k' ,'935280' ,'qris'),
('8dfb50ef-17bb-11ef-a3d9-005056c0' ,'2v3w4x5y6z7a8b9c0d1e2f3g4h5i6j7s' ,'9769167' ,'bank_transfer');

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
('FurniCrafts Meja Console Sheryl Rectangular 120X45X75Cm UA875-01 Matt White' ,'2559000' ,'1f1833a3-9f70-46c8-b175-2025f2ed935b' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2024/05/WEB-2-17-12.png' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2024/05/WEB-18-12.png' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2024/05/WEB-3-9-12.png' ,'Detail Produk & Spesifikasi

Desain modern
Material : Meja MDF, Kaki Solid Wood
Finishing : Painting Matt
Ukuran  :  120X45X75 CM
Warna  : Matt White
Meja Console Benuansa Putih Cocok untuk ruang tamu ataupun Ruang keluarga' ,'339' ,'1'),
('FurniCrafts Felix Cabinet Multifungsi Serta Meja Lipat + 2 Kursi' ,'3599100' ,'20416935-3935-4b70-8fc8-d0c43826803f' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/05/Felix-2-12.jpg' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/05/Felix-1-12.jpg' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/05/Felix-3-12.jpg' ,'Detail Produk & Spesifikasi

Desain modern ‘- Multifungsi – Efisien – Minimalis – Saving space
Dimensi produk  Meja Tertutup   :  120 x 40 x 200 cm
Dimensi Produk  Meja Terbuka    : ( P. Meja 57cm – L . Meja 72Cm / Lebar keseluruhan 110Cm ) x T. Meja 75
Material                                              : E1 MDF + Melamine + Metal
Warna                                                 : Oak' ,'160' ,'2'),
('FurniCrafts Meja Tamu Almira Walnut Metal Wood 100*50*45Cm' ,'1159000' ,'2144ab71-f6d0-4783-9174-34e623e0c7f1' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/12/WEB-2-167-13.png' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/12/WEB-171-13.png' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2024/01/NEW-Web-banner-700-x-700-px-1-03-34.jpg' ,'Detail Produk & Spesifikasi :

Design Minimalis
Material : Metal
Ukuran Besar :100cm x 50cm x 45cm
Warna : Walnut
Meja Tamu Desain Minimalis Dengan MaterialKaki Metal, Sangat Cocok Untuk Ruang Tamu Atau Ruang Keluarga . Meja Tamu Dengan Desain Minimalis , Cocok Untuk Diletakan Diruang Tamu atau Keluarga' ,'306' ,'1'),
('FurniCrafts Kursi Makan Fabric Sammy SFC094 47*48*80' ,'935280' ,'21c26db0-3edb-4396-bde5-707dcfdab38a' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/12/WEB-73-13.png' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/12/WEB-4-22-13.png' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/12/WEB-73-13.png' ,'Detail Produk & Spesifikasi

Dimensi produk : 47 x 48 x 80 cm
Material : Dudukan Fabric dan kaki Solid Wood
Warna   : Blue & Black' ,'195' ,'2'),
('FurniCrafts Tempat Tidur Shinju King White' ,'3256389' ,'242fd018-d1d7-4e98-936e-2c80f579568a' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/03/shinju-queen-white-3-1-55-2-12.jpg' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/03/shinju-queen-white-3-1-54-2-12.jpg' ,'https://play.google.com/store/apps/details?id=appinventor.ai_bobitetsuya.atria5&pcampaignid=web_share' ,'Detail Produk :

Design Minimalis
Material dari kayu olahan MDF PB E1
Bed Size KING 187 x 207 x 30 Cm
Dilapisi dengan melamine paper warna kayu White' ,'445' ,'4');

INSERT INTO `transaction_detail`
(`id`,
`trxid`,
`item`,
`qty`,
`subtotal`)
VALUES
('1d81db3c17be11efa3d9005056c00001' ,'8dfb336b-17bb-11ef-a3d9-005056c0' ,'1f1833a3-9f70-46c8-b175-2025f2ed935b' ,'4' ,'10236000'),
('1d82b2d917be11efa3d9005056c00001' ,'8dfb4497-17bb-11ef-a3d9-005056c0' ,'20416935-3935-4b70-8fc8-d0c43826803f' ,'2' ,'7198200'),
('1d82e64017be11efa3d9005056c00001' ,'8dfb48ef-17bb-11ef-a3d9-005056c0' ,'2144ab71-f6d0-4783-9174-34e623e0c7f1' ,'1' ,'1159000'),
('1d83219517be11efa3d9005056c00001' ,'8dfb4cf6-17bb-11ef-a3d9-005056c0' ,'21c26db0-3edb-4396-bde5-707dcfdab38a' ,'1' ,'935280'),
('1d83669817be11efa3d9005056c00001' ,'8dfb50ef-17bb-11ef-a3d9-005056c0' ,'242fd018-d1d7-4e98-936e-2c80f579568a' ,'3' ,'9769167');

INSERT INTO `cart`
(`uuid`,
`userId`,
`total`)
VALUES
('1d1c0895227911ef877d0897987d70ff' ,'2j3k4l5m6n7o8p9q0r1s2t3u4v5w6x7y' ,'20472000'),
('1d1c2d44227911ef877d0897987d70ff' ,'2p3q4r5s6t7u8v9w0x1y2z3a4b5c6d7e' ,'10797300'),
('1d1c3726227911ef877d0897987d70ff' ,'2t3u4v5w6x7y8z9a0b1c2d3e4f5g6h7i' ,'9272000'),
('1d1c4244227911ef877d0897987d70ff' ,'2v3w4x5y6z7a8b9c0d1e2f3g4h5i6j7k' ,'1870560'),
('1d1c4f1c227911ef877d0897987d70ff' ,'2v3w4x5y6z7a8b9c0d1e2f3g4h5i6j7s' ,'16281945');

INSERT INTO `cartdetails`
(`uuid`,
`productId`,
`cartId`,
`qty`,
`subTotal`)
VALUES
('494e99db227c11ef877d0897987d70ff' ,'1f1833a3-9f70-46c8-b175-2025f2ed935b' ,'1d1c0895227911ef877d0897987d70ff' ,'8' ,'20472000'),
('494ee489227c11ef877d0897987d70ff' ,'20416935-3935-4b70-8fc8-d0c43826803f' ,'1d1c2d44227911ef877d0897987d70ff' ,'3' ,'10797300'),
('494efcda227c11ef877d0897987d70ff' ,'2144ab71-f6d0-4783-9174-34e623e0c7f1' ,'1d1c3726227911ef877d0897987d70ff' ,'8' ,'9272000'),
('494f141c227c11ef877d0897987d70ff' ,'21c26db0-3edb-4396-bde5-707dcfdab38a' ,'1d1c4244227911ef877d0897987d70ff' ,'2' ,'1870560'),
('494f2a12227c11ef877d0897987d70ff' ,'242fd018-d1d7-4e98-936e-2c80f579568a' ,'1d1c4f1c227911ef877d0897987d70ff' ,'5' ,'16281945');


