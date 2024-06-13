CREATE SCHEMA `OLTP-bryan`;

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

INSERT INTO `oltp-bryan`.`users`
(`uuid`,
`name`,
`email`,
`password`,
`role`,
`status`)
VALUES
('0n1o2p3q4r5s6t7u8v9w0x1y2z3a4b5c' ,'Qiana Melati' ,'qiana@gmail.com' ,'$2y$10$W9J7H3L2N1D8T6X5P4M0K9O2B5A4C6Y7W8G1F3R0A9J6U2D7K5T5Q' ,'user' ,'1'),
('0r1s2t3u4v5w6x7y8z9a0b1c2d3e4f5g' ,'Uci Pratama' ,'uci.pratama@gmail.com' ,'$2y$10$A9N7H3L2N1D8T6X5P4M0K9O2B5A4C6Y7W8G1F3R0A9J6U2D7K5T6U' ,'user' ,'1'),
('0t1u2v3w4x5y6z7a8b9c0d1e2f3g4h5e' ,'Wahyu Putra' ,'wahyu2@gmail.com' ,'$2y$10$C9P7H3J2L1D8T6X5P4M0K9O2B5A4C6Y7W8G1F3R0A9J6U2D7K5T4W' ,'user' ,'1'),
('0t1u2v3w4x5y6z7a8b9c0d1e2f3g4h5i' ,'Wahyu Kurniawan' ,'wahyu@gmail.com' ,'$2y$10$C9P7H3L2N1D8T6X5P4M0K9O2B5A4C6Y7W8G1F3R0A9J6U2D7K5T4W' ,'user' ,'1'),
('0x1y2z3a4b5c6d7e8f9g0h1i2j3k4l5m' ,'Agus Rahman' ,'agus.rahman@gmail.com' ,'$2y$10$G9T7H3L2N1D8T6X5P4M0K9O2B5A4C6Y7W8G1F3R0A9J6U2D7K5T6A' ,'user' ,'1');

INSERT INTO `oltp-bryan`.`shipping`
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
('3e8f22e1-17b0-11ef-9b89-0897987d' ,'0n1o2p3q4r5s6t7u8v9w0x1y2z3a4b5c' ,'Jalan Sudirman No. 56' ,'Yogyakarta' ,'Jawa Timur' ,'Indonesia' ,'82253' ,'08150082883' ,'completed'),
('3e8f2bb1-17b0-11ef-9b89-0897987d' ,'0r1s2t3u4v5w6x7y8z9a0b1c2d3e4f5g' ,'Jalan Ahmad Yani No. 46' ,'Bandung' ,'Jawa Tengah' ,'Indonesia' ,'79876' ,'08483530499' ,'completed'),
('3e8f3453-17b0-11ef-9b89-0897987d' ,'0t1u2v3w4x5y6z7a8b9c0d1e2f3g4h5e' ,'Jalan Gatot Subroto No. 77' ,'Bandung' ,'DKI Jakarta' ,'Indonesia' ,'89458' ,'08312957709' ,'shipping'),
('3e8f3ce6-17b0-11ef-9b89-0897987d' ,'0t1u2v3w4x5y6z7a8b9c0d1e2f3g4h5i' ,'Jalan Kramat Pulo No. 53' ,'Surabaya' ,'Jawa Barat' ,'Indonesia' ,'61190' ,'08580629444' ,'completed'),
('3e8f45cf-17b0-11ef-9b89-0897987d' ,'0x1y2z3a4b5c6d7e8f9g0h1i2j3k4l5m' ,'Jalan Kemanggisan No. 29' ,'Surabaya' ,'Jawa Barat' ,'Indonesia' ,'25140' ,'08726675577' ,'completed');

INSERT INTO `oltp-bryan`.`transaction`
(`uuid`,
`shipping_uuid`,
`total_amount`,
`payment_type`)
VALUES
('5aa1b2f3-17b6-11ef-9b89-0897987d' ,'3e8f22e1-17b0-11ef-9b89-0897987d' ,'4798000' ,'bank_transfer'),
('5aa1b6a3-17b6-11ef-9b89-0897987d' ,'3e8f2bb1-17b0-11ef-9b89-0897987d' ,'4200000' ,'bank_transfer'),
('5aa1ba42-17b6-11ef-9b89-0897987d' ,'3e8f3453-17b0-11ef-9b89-0897987d' ,'4796000' ,'bank_transfer'),
('5aa1bdda-17b6-11ef-9b89-0897987d' ,'3e8f3ce6-17b0-11ef-9b89-0897987d' ,'14995000' ,'bank_transfer'),
('5aa1c16a-17b6-11ef-9b89-0897987d' ,'3e8f45cf-17b0-11ef-9b89-0897987d' ,'32193000' ,'qris');

INSERT INTO `oltp-bryan`.`category`
(`Category_id`,
`Category_Name`)
VALUES
('1' ,'ruangtamu'),
('2' ,'ruangkerja'),
('3' ,'ruangtidur'),
('4' ,'ruangdapur');

INSERT INTO `oltp-bryan`.`product`
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
('FurniCrafts Meja Kopi Agatha Model Oval Ceramic White SCT501 100x50x45' ,'2399000' ,'0a87e0f6-59f4-426d-b0b4-44e1e2eaf8e0' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/12/WEB-164-13.png' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/12/WEB-2-161-13.png' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/12/WEB-3-161-13.png' ,'Detail Produk & Spesifikasi
Material : Stone ,Metal Gold, Keramik
Ukuran : 100cm x50cm x45cm' ,'157' ,'1'),
('FurniCrafts Meja Rias Norta' ,'2100000' ,'0b4fd3d4-9ce5-4e8d-896e-d6e87ba3ed08' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/03/Norta-dressing-Table-2-13.jpg' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/03/Norta-dressing-Table-1-13.jpg' ,'https://play.google.com/store/apps/details?id=appinventor.ai_bobitetsuya.atria5&pcampaignid=web_share' ,'Detail Produk & Spesifikasi

Material : MDF   PB E1
Finishing : Melamine
Dimensi produk : 100 x 40 x 150 cm' ,'360' ,'4'),
('FurniCrafts Kursi Sisca Dining SFC1154 49x48x86.5 Cream' ,'959200' ,'0c64b6cb-dad5-44fc-9b1b-2e429ebfe292' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2024/03/WEB-68-13.png' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2024/03/WEB-2-36-12.png' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2024/03/WEB-68-13.png' ,'Detail Produk & Spesifikasi

Desain modern
Dimensi produk    : 100x60x45 cm
Material                  : GLASS/MDF/PB/MELAMINE/METAL
Warna                      : Glass/Wood

‘MEJA TAMU DENGAN DESAIN MODERN, MATERIAL TEMPERED GLASS, TERDAPAT LACI DIBAGIAN BAWAH, COCOK UNTUK RUANG TAMU ATAU RUANG KELUARGA' ,'180' ,'1'),
('FurniCrafts Meja Tamu Evelyn Round D.70x70x52/D.50x50x42 AT-CT23 Stone White' ,'2999000' ,'0cf74614-3bc0-4f4c-9c57-140f3140dc34' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2024/05/WEB-622-11.png' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2024/05/WEB-3-467-11.png' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2024/05/WEB-2-594-11.png' ,'Detail Produk & Spesifikasi

Desain Minimalis
Material : Kulit ,Metal,Pocket Spring
Ukuran Light tan : 92x91x93 Cm
Ukuran Gey           : 92x95x95 Cm
Warna : Grey & Light Tan

Desain modern dan minimalis , sangat nyaman untuk diduduki dan bersantai , sangat empuk dan tahan lama , cocok untuk ruang keluarga  , Bagian yang tersentuh dengan tubuh menggunakan kulit asli dan yang tidak tersentuh dengan tubuh menggunakan kulit sintetis , Dapat menahan daya beban perseater 120KG , Bagian dudukan menggunakan pocket spring membuat dudukan terasa lebih nyaman , Kaki sofa material Metal' ,'349' ,'1'),
('FurniCrafts Sofa Fabric Chester Satu Dudukan' ,'4599000' ,'0d13b318-2b26-4383-93b6-b84b7498dbb3' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/12/5-35.png' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/12/WEB-1-60.png' ,'https://www.atria.co.id/surabaya/wp-content/uploads/2023/12/WEB-3-1-59.png' ,'Detail Produk & Spesifikasi

Roda pada bagian kaki
Sandaran Mesh sehingga tidak panas saat digunakan lama
Modern design ,
Tuas hidrolik untuk mengatur tinggi dudukan
Material : Mesh, plastic, metal
Dimensi produk : 63×66×121(129)cm
Warna  : Black
Kursi dengan sandaraan kepala dan penopang kaki serta banyak fitur untuk kenyamanan pengguna' ,'417' ,'3');

INSERT INTO `oltp-bryan`.`transaction_detail`
(`id`,
`trxid`,
`item`,
`qty`,
`subtotal`)
VALUES
('4073b062-17bc-11ef-9b89-0897987d' ,'5aa1b2f3-17b6-11ef-9b89-0897987d' ,'0a87e0f6-59f4-426d-b0b4-44e1e2eaf8e0' ,'2' ,'4798000'),
('4073bb3f-17bc-11ef-9b89-0897987d' ,'5aa1b6a3-17b6-11ef-9b89-0897987d' ,'0b4fd3d4-9ce5-4e8d-896e-d6e87ba3ed08' ,'2' ,'4200000'),
('4073c304-17bc-11ef-9b89-0897987d' ,'5aa1ba42-17b6-11ef-9b89-0897987d' ,'0c64b6cb-dad5-44fc-9b1b-2e429ebfe292' ,'5' ,'4796000'),
('4073dafc-17bc-11ef-9b89-0897987d' ,'5aa1bdda-17b6-11ef-9b89-0897987d' ,'0cf74614-3bc0-4f4c-9c57-140f3140dc34' ,'5' ,'14995000'),
('4073e2e1-17bc-11ef-9b89-0897987d' ,'5aa1c16a-17b6-11ef-9b89-0897987d' ,'0d13b318-2b26-4383-93b6-b84b7498dbb3' ,'7' ,'32193000');

INSERT INTO `oltp-bryan`.`cart`
(`uuid`,
`userId`,
`total`)
VALUES
('1d1b00c6227911ef877d0897987d70ff' ,'0n1o2p3q4r5s6t7u8v9w0x1y2z3a4b5c' ,'9596000'),
('1d1b1332227911ef877d0897987d70ff' ,'0r1s2t3u4v5w6x7y8z9a0b1c2d3e4f5g' ,'2100000'),
('1d1b1f38227911ef877d0897987d70ff' ,'0t1u2v3w4x5y6z7a8b9c0d1e2f3g4h5e' ,'1918400'),
('1d1b2c2e227911ef877d0897987d70ff' ,'0t1u2v3w4x5y6z7a8b9c0d1e2f3g4h5i' ,'17994000'),
('1d1b3ad2227911ef877d0897987d70ff' ,'0x1y2z3a4b5c6d7e8f9g0h1i2j3k4l5m' ,'27594000');
INSERT INTO `oltp-bryan`.`cartdetails`
(`uuid`,
`productId`,
`cartId`,
`qty`,
`subTotal`)
VALUES
('494c5a04227c11ef877d0897987d70ff' ,'0a87e0f6-59f4-426d-b0b4-44e1e2eaf8e0' ,'1d1b00c6227911ef877d0897987d70ff' ,'4' ,'9596000'),
('494c7dd9227c11ef877d0897987d70ff' ,'0b4fd3d4-9ce5-4e8d-896e-d6e87ba3ed08' ,'1d1b1332227911ef877d0897987d70ff' ,'1' ,'2100000'),
('494c9968227c11ef877d0897987d70ff' ,'0c64b6cb-dad5-44fc-9b1b-2e429ebfe292' ,'1d1b1f38227911ef877d0897987d70ff' ,'2' ,'1918400'),
('494cbd2b227c11ef877d0897987d70ff' ,'0cf74614-3bc0-4f4c-9c57-140f3140dc34' ,'1d1b2c2e227911ef877d0897987d70ff' ,'6' ,'17994000'),
('494cdca1227c11ef877d0897987d70ff' ,'0d13b318-2b26-4383-93b6-b84b7498dbb3' ,'1d1b3ad2227911ef877d0897987d70ff' ,'6' ,'27594000');

