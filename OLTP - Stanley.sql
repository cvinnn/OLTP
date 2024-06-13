CREATE SCHEMA `OLTP-STANLEY`;
USE `OLTP-STANLEY`;

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
('4n5o6p7q8r9s0t1u2v3w4x5y6z7a8b9c' ,'Qori Amir' ,'qori.amir@gmail.com' ,'$2y$10$W9J7H3L2N1D8T6X5P4M0K9O2B5A4C6Y7W8G1F3R0A9J6U2D7K5T4Q' ,'user' ,'1'),
('4n5o6p7q8r9s0t1u2v3w4x5y6z7a8b9g' ,'Qori Amir' ,'qori.amir2@gmail.com' ,'$2y$10$W9J7H3L2N1D8T6X5P4M0K9O2B5A4C6Y7W8G1F3R0A9J6U2D7K5T4Q' ,'user' ,'1'),
('4r5s6t7u8v9w0x1y2z3a4b5c6d7e8f9g' ,'Uci Rahman' ,'uci@gmail.com' ,'$2y$10$A9N7H3L2N1D8T6X5P4M0K9O2B5A4C6Y7W8G1F3R0A9J6U2D7K5T5U' ,'user' ,'1'),
('4x5y6z7a8b9c0d1e2f3g4h5i6j7k8l9m' ,'Ayu Susanti' ,'ayu.susanti@gmail.com' ,'$2y$10$G9T7H3L2N1D8T6X5P4M0K9O2B5A4C6Y7W8G1F3R0A9J6U2D7K5T5A' ,'user' ,'1'),
('5c6d7e8f9g0h1i2j3k4l5m6n7o8p9q0r' ,'Farah Pratama' ,'farah.pratama@gmail.com' ,'$2y$10$L9Y7H3L2N1D8T6X5P4M0K9O2B5A4C6Y7W8G1F3R0A9J6U2D7K5T6F' ,'user' ,'1'),
('4v5w6x7y8z9a0b1c2d3e4f5g6h7i8j9k' ,'Yanto Pratama' ,'yanto.pratama@gmail.com' ,'$2y$10$E9R7H3L2N1D8T6X5P4M0K9O2B5A4C6Y7W8G1F3R0A9J6U2D7K5T6Y' ,'owner' ,'1');

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
('6ca19c12-17b1-11ef-9b89-0897987d' ,'4n5o6p7q8r9s0t1u2v3w4x5y6z7a8b9c' ,'Jalan S Parman No. 31' ,'Bandung' ,'Jawa Barat' ,'Indonesia' ,'61673' ,'08722395568' ,'shipping'),
('6ca1a9b0-17b1-11ef-9b89-0897987d' ,'4n5o6p7q8r9s0t1u2v3w4x5y6z7a8b9g' ,'Jalan Ahmad Yani No. 1' ,'Jakarta' ,'Jawa Barat' ,'Indonesia' ,'53254' ,'08453446556' ,'shipping'),
('6ca1b2c8-17b1-11ef-9b89-0897987d' ,'4r5s6t7u8v9w0x1y2z3a4b5c6d7e8f9g' ,'Jalan Ahmad Yani No. 4' ,'Surabaya' ,'Jawa Barat' ,'Indonesia' ,'51533' ,'08874633555' ,'completed'),
('6ca1c43d-17b1-11ef-9b89-0897987d' ,'4x5y6z7a8b9c0d1e2f3g4h5i6j7k8l9m' ,'Jalan Kuningan No. 85' ,'Semarang' ,'Sumatera Utara' ,'Indonesia' ,'52575' ,'08680579493' ,'completed'),
('6ca1d562-17b1-11ef-9b89-0897987d' ,'5c6d7e8f9g0h1i2j3k4l5m6n7o8p9q0r' ,'Jalan H Agus Salim No. 69' ,'Semarang' ,'DKI Jakarta' ,'Indonesia' ,'92546' ,'08416048089' ,'waiting');

INSERT INTO `transaction`
(`uuid`,
`shipping_uuid`,
`total_amount`,
`payment_type`)
VALUES
('3bb9db01-17bc-11ef-a3d9-005056c0' ,'6ca19c12-17b1-11ef-9b89-0897987d' ,'8799200' ,'bank_transfer'),
('3bb9ea0e-17bc-11ef-a3d9-005056c0' ,'6ca1a9b0-17b1-11ef-9b89-0897987d' ,'2559200' ,'bank_transfer'),
('3bb9f40f-17bc-11ef-a3d9-005056c0' ,'6ca1b2c8-17b1-11ef-9b89-0897987d' ,'6398400' ,'bank_transfer'),
('3bb9feac-17bc-11ef-a3d9-005056c0' ,'6ca1c43d-17b1-11ef-9b89-0897987d' ,'2110000' ,'qris'),
('3bba07e9-17bc-11ef-a3d9-005056c0' ,'6ca1d562-17b1-11ef-9b89-0897987d' ,'1670000' ,'qris');

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
('Meja Makan Extend Tammara FurniCrafts A-4211 (160-200)*90*76CM High Gloss White' ,'8799200' ,'3b9f6740-19b2-4b44-ae85-f0e7dd646d62' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/10/Meja-Sano-White-27-20-10.jpg' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/10/web-banner-700-x-700-px-1-02-12.jpg' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/10/web-banner-700-x-700-px-1-03-12.jpg' ,'No Description' ,'379' ,'1'),
('FurniCrafts Meja Makan Adella Rectangular Persegi Panjang SFT017 150x90x76Cm Ash Wood' ,'2559200' ,'3bcce14e-03de-4ae5-9b35-4104d7d7a9f4' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/12/WEB-3-171-13.png' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/12/WEB-177-13.png' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/12/WEB-2-173-13.png' ,'Detail Produk & Spesifikasi :
Material : Metal Leg, Kayu
Ukuran : 150cm x 90cm x 76cm' ,'459' ,'2'),
('FurniCrafts Meja Makan Rectangular  Natalie CUS-EUNA008 160x90x76 Walnut' ,'3199200' ,'3c4df5f6-dae4-4b9e-820f-9d94ba04eb36' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2024/01/WEB-2-31-13.png' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2024/01/WEB-42-13.png' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2024/01/WEB-3-34-13.png' ,'Detail Produk & Spesifikasi
Desain modern
Dimensi produk:160X90X76
Material : TOP TABLE MDF+PB FINISHING MELAMINE KAKI METAL' ,'341' ,'3'),
('FurniCrafts Night Table Tyo 0506 FC302 Black Walnut 45x39x59Cm' ,'1055000' ,'3e2a49cf-23b6-432d-9494-59e192a4e51b' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2024/01/WEB-8-66-12.png' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2024/01/NEW-Web-banner-700-x-700-px-1-03-12.jpg' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2024/01/NEW-Web-banner-700-x-700-px-1-02-12.jpg' ,'Detail Produk & Spesifikasi
Ukuran : 45 x 39 x 59 Cm
Warna : Black Walnut
Material : Mdf+Pb Fin. Melamin (E1)' ,'304' ,'4'),
('FurniCrafts Nakas Anak Welby AX-KB50 Blue/White 45x42x44Cm' ,'835000' ,'4018f225-bdac-4d9b-8cf0-fbaef00d919f' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2024/05/WEB-3-6-12.png' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2024/01/NEW-Web-banner-700-x-700-px-1-03-12.jpg' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2024/01/NEW-Web-banner-700-x-700-px-1-02-12.jpg' ,'Detail Produk & Spesifikasi :

Design Minimalis
Ukuran : 45x42x44Cm
Material : Mdf+Pb Fin. Painting with Melamin (E1)
Warna :  Blue/White
Design dengan tema minimalis yang dipadukan dengan warna biru muda, biru tua, dan putih terkesan relax saat dipandang. Nakas Terdapat 2 laci dan pada bagian atas nakas dapat menyimpan barang.' ,'479' ,'3');


INSERT INTO `transaction_detail`
(`id`,
`trxid`,
`item`,
`qty`,
`subtotal`)
VALUES
('84245696-17c4-11ef-9b89-0897987d' ,'3bb9db01-17bc-11ef-a3d9-005056c0' ,'3b9f6740-19b2-4b44-ae85-f0e7dd646d62' ,'1' ,'8799200'),
('84246309-17c4-11ef-9b89-0897987d' ,'3bb9ea0e-17bc-11ef-a3d9-005056c0' ,'3bcce14e-03de-4ae5-9b35-4104d7d7a9f4' ,'1' ,'2559200'),
('84247b56-17c4-11ef-9b89-0897987d' ,'3bb9f40f-17bc-11ef-a3d9-005056c0' ,'3c4df5f6-dae4-4b9e-820f-9d94ba04eb36' ,'2' ,'6398400'),
('84248d64-17c4-11ef-9b89-0897987d' ,'3bb9feac-17bc-11ef-a3d9-005056c0' ,'3e2a49cf-23b6-432d-9494-59e192a4e51b' ,'2' ,'2110000'),
('84249c17-17c4-11ef-9b89-0897987d' ,'3bba07e9-17bc-11ef-a3d9-005056c0' ,'4018f225-bdac-4d9b-8cf0-fbaef00d919f' ,'2' ,'1670000');

INSERT INTO `cart`
(`uuid`,
`userId`,
`total`)
VALUES
('1d1d1685227911ef877d0897987d70ff' ,'4n5o6p7q8r9s0t1u2v3w4x5y6z7a8b9c' ,'8799200'),
('1d1d20ff227911ef877d0897987d70ff' ,'4n5o6p7q8r9s0t1u2v3w4x5y6z7a8b9g' ,'7677600'),
('1d1d2c00227911ef877d0897987d70ff' ,'4r5s6t7u8v9w0x1y2z3a4b5c6d7e8f9g' ,'3199200'),
('1d1d4093227911ef877d0897987d70ff' ,'4x5y6z7a8b9c0d1e2f3g4h5i6j7k8l9m' ,'3165000'),
('1d1d5496227911ef877d0897987d70ff' ,'5c6d7e8f9g0h1i2j3k4l5m6n7o8p9q0r' ,'7515000');

INSERT INTO `cartdetails`
(`uuid`,
`productId`,
`cartId`,
`qty`,
`subTotal`)
VALUES
('49511ac6227c11ef877d0897987d70ff' ,'3b9f6740-19b2-4b44-ae85-f0e7dd646d62' ,'1d1d1685227911ef877d0897987d70ff' ,'1' ,'8799200'),
('495131f5227c11ef877d0897987d70ff' ,'3bcce14e-03de-4ae5-9b35-4104d7d7a9f4' ,'1d1d20ff227911ef877d0897987d70ff' ,'3' ,'7677600'),
('49514a04227c11ef877d0897987d70ff' ,'3c4df5f6-dae4-4b9e-820f-9d94ba04eb36' ,'1d1d2c00227911ef877d0897987d70ff' ,'1' ,'3199200'),
('495176ab227c11ef877d0897987d70ff' ,'3e2a49cf-23b6-432d-9494-59e192a4e51b' ,'1d1d4093227911ef877d0897987d70ff' ,'3' ,'3165000'),
('4951b28b227c11ef877d0897987d70ff' ,'4018f225-bdac-4d9b-8cf0-fbaef00d919f' ,'1d1d5496227911ef877d0897987d70ff' ,'9' ,'7515000');


