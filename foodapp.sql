

-- TẠO Bảng USER

CREATE TABLE user (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

-- INSERT value USER
INSERT INTO user (full_name, email, password) 
VALUES 
('Alice', 'alice2example.com', 'password123'),
('Bob', 'bob2@example.com', 'password123'),
('Charlie', 'charlie2@example.com', 'password123'),
('Diana', 'diana2@example.com', 'password123'),
('Eve', 'eve2@example.com', 'password123'),
('Frank', 'frank2@example.com', 'password123')
('Alice Johnson', 'alice@example.com', 'alice123'),
('Bob Smith', 'bob@example.com', 'bob123'),
('Charlie Brown', 'charlie@example.com', 'charlie123'),
('Daisy Lee', 'daisy@example.com', 'daisy123'),
('Eve Carter', 'eve@example.com', 'eve123');



-- Tạo bảng RESTAURANT

CREATE TABLE restaurant (
	res_id INT AUTO_INCREMENT PRIMARY KEY,
	res_name VARCHAR(255) NOT NULL,
	image VARCHAR(255),
	`desc` VARCHAR(255)
);

-- INSERT value RESTAURANT

INSERT INTO restaurant (res_name, image, `desc`) 
VALUES 

('Pizza Palace', 'pizza.png', 'Best pizza in town'),
('Sushi World', 'sushi.png', 'Authentic sushi experience'),
('Burger Town', 'burger.png', 'Delicious burgers'),
('Taco Fiesta', 'taco.png', 'Mexican flavors'),
('Pasta Paradise', 'pasta.png', 'Italian cuisine')
('Pizza Palace', 'pizza_palace.jpg', 'A cozy pizza restaurant'),
('Sushi World', 'sushi_world.jpg', 'Authentic sushi with fresh ingredients'),
('Burger Town', 'burger_town.jpg', 'Best burgers in town'),
('Vegan Delight', 'vegan_delight.jpg', 'Healthy vegan meals'),
('Steak House', 'steak_house.jpg', 'Premium steak dining experience');



-- Tạo Bảng food_type

CREATE TABLE food_type (
	type_id INT AUTO_INCREMENT PRIMARY KEY,
	type_name VARCHAR(255) NOT NULL
);

-- INSERT value food_type

INSERT INTO food_type (type_name)
VALUES
('Pizza'), 
('Sushi'),
('Burger'),
('Vegan'),
('Steak');

-- tạo bảng food

CREATE TABLE food (
	food_id INT AUTO_INCREMENT PRIMARY KEY,
	food_name VARCHAR(255) NOT NULL,
	image VARCHAR(255),
	price FLOAT NOT NULL,
	`desc` VARCHAR(255),
	type_id INT,
	FOREIGN KEY (type_id) REFERENCES food_type(type_id)
);


-- insert value FOOD

INSERT INTO food (food_name, image, price, `desc`, type_id) 
VALUES 
('Margherita Pizza', 'margherita.jpg', 9.99, 'Classic cheese and tomato', 1),
('Pepperoni Pizza', 'pepperoni.jpg', 12.99, 'Spicy and cheesy', 1),
('California Roll', 'california_roll.jpg', 8.99, 'Fresh sushi roll', 2),
('Cheeseburger', 'cheeseburger.jpg', 10.99, 'Juicy burger with cheese', 3),
('Grilled Steak', 'grilled_steak.jpg', 24.99, 'Perfectly grilled steak', 5);




-- Tạo Bảng sub_food

CREATE TABLE sub_food (
	sub_id INT AUTO_INCREMENT PRIMARY KEY,
	sub_name VARCHAR(255) NOT NULL,
	sub_price FLOAT NOT NULL,
	food_id INT,
	FOREIGN KEY (food_id) REFERENCES food(food_id)
);

-- insert value sub_food

INSERT INTO sub_food (sub_name, sub_price, food_id) 
VALUES 
('Extra Cheese', 1.50, 1),
('Spicy Sauce', 0.75, 1),
('Wasabi', 0.50, 3),
('Lettuce', 0.50, 4),
('Garlic Butter', 2.00, 5);



-- Tạo bảng ORDER

CREATE TABLE `order` (
	order_id INT AUTO_INCREMENT PRIMARY KEY,
	user_id INT,
	food_id INT,
	amount INT NOT NULL,
	code VARCHAR(50),
	arr_sub_id VARCHAR(255),
	FOREIGN KEY (user_id) REFERENCES `user`(user_id),
	FOREIGN KEY (food_id) REFERENCES food(food_id)
);


-- INSERT value ORDER

INSERT INTO `order` (user_id, food_id, amount, code, arr_sub_id) 
VALUES 

(1, 1, 2, 'A123', '1,2'),
(1, 2, 1, 'B456', '3'),
(2, 1, 3, 'C789', '1'),
(3, 3, 1, 'D012', '2'),
(4, 4, 2, 'E345', '1,3'),
(4, 5, 1, 'F678', NULL)

(1, 1, 2, 'ORD001', '1,2'),
(2, 3, 1, 'ORD002', '3'), 
(3, 4, 1, 'ORD003', '4'),
(4, 5, 2, 'ORD004', '5'),
(5, 2, 3, 'ORD005', ''); 



-- Tạo bảng LIKE_RES

CREATE TABLE like_res (
	user_id INT,
	res_id INT,
	date_like DATETIME NOT NULL,
	FOREIGN KEY (user_id) REFERENCES `user` (user_id),
	FOREIGN KEY (res_id) REFERENCES restaurant (res_id)
);

-- INSERT value LIKE_RES

INSERT INTO like_res (user_id, res_id, date_like) 
VALUES 

(1, 1, NOW()),
(1, 2, NOW()),
(2, 1, NOW()),
(3, 3, NOW()),
(4, 3, NOW()),
(4, 4, NOW()),
(5, 5, NOW());
(1, 1, NOW()),
(1, 2, NOW()),
(2, 1, NOW()),
(3, 3, NOW()),
(4, 4, NOW());




-- Tạo bảng RATE_RES

CREATE TABLE rate_res (
	user_id INT,
	res_id INT,
	
	amount INT not null,
	date_rate DATETIME NOT NULL,
	FOREIGN KEY (user_id) REFERENCES `user` (user_id),
	FOREIGN KEY (res_id) REFERENCES restaurant (res_id)
);

-- INSERT value RATE_RES

INSERT INTO rate_res ( user_id, res_id, amount, date_rate)
VALUES
(1, 1, 5, NOW()),
(2, 2, 4, NOW()),
(3, 3, 3, NOW()),
(4, 4, 5, NOW()),
(5, 5, 4, NOW());


-- Tìm 5 người đã like nhà hàng nhiều nhất
SELECT 
    u.full_name, 
    l.user_id, 
    COUNT(l.res_id) AS like_count
FROM 
    like_res l
JOIN 
    user u ON l.user_id = u.user_id
GROUP BY 
    l.user_id, u.full_name
ORDER BY 
    like_count DESC
LIMIT 5;



-- Tìm 2 nhà hàng có lượt like nhiều nhất
SELECT 
    r.res_name, 
    COUNT(l.user_id) AS like_count
FROM 
    like_res l
JOIN 
    restaurant r ON l.res_id = r.res_id
GROUP BY 
    r.res_name
ORDER BY 
    like_count DESC
LIMIT 2;



-- Tìm người đặt hàng nhiều nhất

SELECT 
    u.full_name, 
    COUNT(o.order_id) AS order_count
FROM 
    `order` o
JOIN 
    user u ON o.user_id = u.user_id
GROUP BY 
    u.full_name
ORDER BY 
    order_count DESC
LIMIT 1;


-- Tìm người dùng không hoạt động trong hệ thống (không đặt hàng, không like, không đánh giá nhà hàng).

SELECT 
    u.full_name
FROM 
    user u
WHERE 
    u.user_id NOT IN (SELECT user_id FROM `order`)
    AND u.user_id NOT IN (SELECT user_id FROM like_res)
    AND u.user_id NOT IN (SELECT user_id FROM rate_res);


	






