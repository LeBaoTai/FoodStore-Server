-- Enable UUID extension if not already enabled
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Drop tables if they exist
--DROP TABLE IF EXISTS users_roles;
--DROP TABLE IF EXISTS roles_permissions;
--DROP TABLE IF EXISTS carts_items;
--DROP TABLE IF EXISTS users;
--DROP TABLE IF EXISTS roles;
--DROP TABLE IF EXISTS permissions;
--DROP TABLE IF EXISTS products;
--DROP TABLE IF EXISTS invalidated_tokens;
--DROP TABLE IF EXISTS cart_items;
--DROP TABLE IF EXISTS carts;

-- Create users table
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    firstname VARCHAR(255),
    lastname VARCHAR(255),
    phone VARCHAR(50),
    email VARCHAR(255),
    dob DATE
);

-- Create roles table
CREATE TABLE roles (
    name VARCHAR(255) PRIMARY KEY,
    description VARCHAR(255)
);

-- Create permissions table
CREATE TABLE permissions (
    name VARCHAR(255) PRIMARY KEY,
    description VARCHAR(255)
);

-- Create products table
CREATE TABLE products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    price NUMERIC(15, 2) NOT NULL,
    type VARCHAR(255),
    status BOOLEAN DEFAULT TRUE,
    image VARCHAR(255)
);

-- Create invalidated_tokens table
CREATE TABLE invalidated_tokens (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    expiry_time TIMESTAMP NOT NULL
);

-- Create cart_items table
CREATE TABLE cart_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid()
);

-- Create carts table
CREATE TABLE carts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid()
);

-- Create join table for users and roles
CREATE TABLE users_roles (
    user_id UUID NOT NULL,
    role_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (user_id, role_name),
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    FOREIGN KEY (role_name) REFERENCES roles (name) ON DELETE CASCADE
);

-- Create join table for roles and permissions
CREATE TABLE roles_permissions (
    role_name VARCHAR(255) NOT NULL,
    permission_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (role_name, permission_name),
    FOREIGN KEY (role_name) REFERENCES roles (name) ON DELETE CASCADE,
    FOREIGN KEY (permission_name) REFERENCES permissions (name) ON DELETE CASCADE
);

-- Create join table for carts and cart_items
CREATE TABLE carts_items (
    cart_id UUID NOT NULL,
    item_id UUID NOT NULL,
    PRIMARY KEY (cart_id, item_id),
    FOREIGN KEY (cart_id) REFERENCES carts (id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES cart_items (id) ON DELETE CASCADE
);

-- Create join table for cart_items and products
CREATE TABLE cart_items_products (
    cart_item_id UUID NOT NULL,
    product_id UUID NOT NULL,
    PRIMARY KEY (cart_item_id, product_id),
    FOREIGN KEY (cart_item_id) REFERENCES cart_items (id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE
);

-- Insert initial data
INSERT INTO roles (name, description) VALUES
('USER', 'Standard user role'),
('ADMIN', 'Administrator role');

INSERT INTO permissions (name, description) VALUES
('READ', 'Permission to read data'),
('WRITE', 'Permission to write data');

--INSERT INTO users (username, password, firstname, lastname, phone, email, dob) VALUES
--('admin', 'admin@admin', 'admin', 'admin', '0123456789', 'admin@example.com', '1990-01-01'),
--('test', 'test@test', 'test', 'test', '0987654321', 'test@example.com', '1992-02-02');

INSERT INTO products (name, price, type, status, image) VALUES
('Spinach', 1.49, 'Vegetables', true, 'https://images.unsplash.com/photo-1515363578674-99f41329ab4c'),
('Lettuce', 1.29, 'Vegetables', true, 'https://images.unsplash.com/photo-1543056295-d585ba290712'),
('Kale', 1.59, 'Vegetables', true, 'https://images.unsplash.com/photo-1522193582792-c66cf1cddd16'),
('Arugula', 1.39, 'Vegetables', true, 'https://images.unsplash.com/photo-1595574446720-ca5f6736b8fb'),
('Swiss Chard', 1.89, 'Vegetables', true, 'https://images.unsplash.com/photo-1679595044391-3c42b0f351b5'),
('Mustard Greens', 1.69, 'Vegetables', true, 'https://images.unsplash.com/photo-1618582705011-8b101db14d20'),
('Collard Greens', 1.79, 'Vegetables', true, 'https://images.unsplash.com/photo-1549736624-81a2ca809ad7'),
('Beet Greens', 1.49, 'Vegetables', true, 'https://images.unsplash.com/photo-1593528852413-69f279565422'),
('Romaine Lettuce', 1.59, 'Vegetables', true, 'https://images.unsplash.com/photo-1691906470255-640353380f3d'),
('Endive', 1.99, 'Vegetables', true, 'https://images.unsplash.com/photo-1615368689980-4090f7008f11'),
('Radicchio', 1.69, 'Vegetables', true, 'https://images.unsplash.com/photo-1516554646385-7642248096d1'),
('Bok Choy', 1.89, 'Vegetables', true, 'https://images.unsplash.com/photo-1708798534031-3711ec8cc16e'),
('Cabbage', 1.39, 'Vegetables', true, 'https://images.unsplash.com/photo-1486328228599-85db4443971f'),
('Brussels Sprouts', 1.79, 'Vegetables', true, 'https://images.unsplash.com/photo-1668120082660-735234f1a845'),
('Zucchini', 1.19, 'Vegetables', true, 'https://images.unsplash.com/photo-1692956475726-d4a90d0dfbdf'),
('Green Beans', 1.49, 'Vegetables', true, 'https://images.unsplash.com/photo-1508900173264-bb171fa617e4'),
('Bell Peppers', 1.29, 'Vegetables', true, 'https://images.unsplash.com/photo-1621953723422-6023013f659d'),
('Cucumbers', 1.09, 'Vegetables', true, 'https://images.unsplash.com/photo-1570110618492-3cc50d652681'),
('Carrots', 1.00, 'Vegetables', true, 'https://images.unsplash.com/photo-1447175008436-054170c2e979'),
('Celery', 1.39, 'Vegetables', true, 'https://images.unsplash.com/photo-1708436476465-0938f4e28836'),
('Beef', 12.49, 'Meat', true, 'https://images.unsplash.com/photo-1695683948430-35b6220f4e2e'),
('Chicken', 7.99, 'Meat', true, 'https://images.unsplash.com/photo-1642102903996-cdad15f5dcdd'),
('Pork', 9.49, 'Meat', true, 'https://images.unsplash.com/photo-1600180786608-28d06391d25c'),
('Lamb', 15.99, 'Meat', true, 'https://images.unsplash.com/photo-1448907503123-67254d59ca4f'),
('Turkey', 11.99, 'Meat', true, 'https://images.unsplash.com/photo-1606728035253-49e8a23146de'),
('Veal', 13.49, 'Meat', true, 'https://images.unsplash.com/photo-1628294896516-344152572ee8'),
('Ham', 8.99, 'Meat', true, 'https://images.unsplash.com/photo-1624030997838-6b93e2d54d04'),
('Sausage', 10.29, 'Meat', true, 'https://images.unsplash.com/photo-1531097023973-44a8761c85e1'),
('Ground Beef', 11.29, 'Meat', true, 'https://images.unsplash.com/photo-1620167789273-d66c723fe754'),
('Chicken Breast', 14.99, 'Meat', true, 'https://images.unsplash.com/photo-1624364543842-b0472614eb68'),
('Crab', 18.99, 'Seafood', true, 'https://images.unsplash.com/photo-1509415173911-37ff7a1aa29c'),
('Fish', 8.49, 'Seafood', true, 'https://images.unsplash.com/photo-1498654200943-1088dd4438ae'),
('Salmon', 16.79, 'Seafood', true, 'https://images.unsplash.com/photo-1499125562588-29fb8a56b5d5'),
('Shrimp', 12.29, 'Seafood', true, 'https://images.unsplash.com/photo-1674066625481-8cffd7cf5aac'),
('Tuna', 9.99, 'Seafood', true, 'https://images.unsplash.com/photo-1648431529663-8ae9606630c0'),
('Mussels', 10.49, 'Seafood', true, 'https://images.unsplash.com/photo-1602065538249-7f958ef7b356'),
('Lobster', 19.99, 'Seafood', true, 'https://images.unsplash.com/photo-1707995548052-cfca47bfb6db'),
('Clams', 7.89, 'Seafood', true, 'https://images.unsplash.com/photo-1703786948642-f914b897c937'),
('Oysters', 11.59, 'Seafood', true, 'https://images.unsplash.com/photo-1578882422378-9ed72be08b5e'),
('Cod', 8.99, 'Seafood', true, 'https://images.unsplash.com/photo-1640666761099-339b810c774f'),
('Apple', 1.99, 'Fruits', true, 'https://images.unsplash.com/photo-1476837579993-f1d3948f17c2'),
('Banana', 1.29, 'Fruits', true, 'https://images.unsplash.com/photo-1523667864248-fc55f5bad7e2'),
('Orange', 2.49, 'Fruits', true, 'https://images.unsplash.com/photo-1517161782303-6bee363b9d9a'),
('Grapes', 3.99, 'Fruits', true, 'https://images.unsplash.com/photo-1515778767554-42d4b373f2b3'),
('Mango', 4.79, 'Fruits', true, 'https://images.unsplash.com/photo-1553279768-865429fa0078'),
('Pineapple', 5.99, 'Fruits', true, 'https://images.unsplash.com/photo-1685551638142-6ffee7b34255'),
('Strawberry', 6.49, 'Fruits', true, 'https://images.unsplash.com/photo-1495570689269-d883b1224443'),
('Blueberry', 4.99, 'Fruits', true, 'https://images.unsplash.com/photo-1498557850523-fd3d118b962e'),
('Peach', 3.29, 'Fruits', true, 'https://images.unsplash.com/photo-1532704868953-d85f24176d73'),
('Watermelon', 7.99, 'Fruits', true, 'https://images.unsplash.com/photo-1529701348460-57e405ad9825'),
('Milk', 2.99, 'Dairy', true, 'https://images.unsplash.com/photo-1533651131910-36d95c33b6c5'),
('Cheese', 5.49, 'Dairy', true, 'https://images.unsplash.com/photo-1683314573422-649a3c6ad784'),
('Yogurt', 4.29, 'Dairy', true, 'https://images.unsplash.com/photo-1593450298063-4e08a162a437'),
('Butter', 3.79, 'Dairy', true, 'https://images.unsplash.com/photo-1589985270826-4b7bb135bc9d'),
('Cream', 6.49, 'Dairy', true, 'https://images.unsplash.com/photo-1514077583608-aedd9ec18c40'),
('Cottage Cheese', 5.99, 'Dairy', true, 'https://images.unsplash.com/photo-1604146267145-24bc07ab6e8f'),
('Sour Cream', 4.99, 'Dairy', true, 'https://images.unsplash.com/photo-1589985270319-40629f6ae936'),
('Buttermilk', 3.49, 'Dairy', true, 'https://images.unsplash.com/photo-1630409346699-79481a79db52'),
('Ricotta', 7.29, 'Dairy', true, 'https://images.unsplash.com/photo-1681557732649-c0d8a9b07843'),
('Kefir', 6.79, 'Dairy', true, 'https://images.unsplash.com/photo-1719528809952-d613e546b18b');


-- Assign roles to users
--INSERT INTO users_roles (user_id, role_name) VALUES
--((SELECT id FROM users WHERE username = 'admin'), 'ADMIN')
--((SELECT id FROM users WHERE username = 'test'), 'USER');

-- Assign permissions to roles
INSERT INTO roles_permissions (role_name, permission_name) VALUES
('USER', 'READ'),
('ADMIN', 'READ'),
('ADMIN', 'WRITE');
