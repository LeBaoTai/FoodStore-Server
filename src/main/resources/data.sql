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
('Spinach', 1.49, 'Vegetables', true, 'assets/product/salad.jpg'),
('Lettuce', 1.29, 'Vegetables', true, 'assets/product/salad.jpg'),
('Kale', 1.59, 'Vegetables', true, 'assets/product/salad.jpg'),
('Arugula', 1.39, 'Vegetables', true, 'assets/product/salad.jpg'),
('Swiss Chard', 1.89, 'Vegetables', true, 'assets/product/salad.jpg'),
('Mustard Greens', 1.69, 'Vegetables', true, 'assets/product/salad.jpg'),
('Collard Greens', 1.79, 'Vegetables', true, 'assets/product/salad.jpg'),
('Beet Greens', 1.49, 'Vegetables', true, 'assets/product/salad.jpg'),
('Romaine Lettuce', 1.59, 'Vegetables', true, 'assets/product/salad.jpg'),
('Endive', 1.99, 'Vegetables', true, 'assets/product/salad.jpg'),
('Radicchio', 1.69, 'Vegetables', true, 'assets/product/salad.jpg'),
('Bok Choy', 1.89, 'Vegetables', true, 'assets/product/salad.jpg'),
('Cabbage', 1.39, 'Vegetables', true, 'assets/product/salad.jpg'),
('Brussels Sprouts', 1.79, 'Vegetables', true, 'assets/product/salad.jpg'),
('Zucchini', 1.19, 'Vegetables', true, 'assets/product/salad.jpg'),
('Green Beans', 1.49, 'Vegetables', true, 'assets/product/salad.jpg'),
('Bell Peppers', 1.29, 'Vegetables', true, 'assets/product/salad.jpg'),
('Cucumbers', 1.09, 'Vegetables', true, 'assets/product/salad.jpg'),
('Carrots', 1.00, 'Vegetables', true, 'assets/product/salad.jpg'),
('Celery', 1.39, 'Vegetables', true, 'assets/product/salad.jpg'),
('Beef', 12.49, 'Meat', true, 'assets/product/salad.jpg'),
('Chicken', 7.99, 'Meat', true, 'assets/product/salad.jpg'),
('Pork', 9.49, 'Meat', true, 'assets/product/salad.jpg'),
('Lamb', 15.99, 'Meat', true, 'assets/product/salad.jpg'),
('Turkey', 11.99, 'Meat', true, 'assets/product/salad.jpg'),
('Veal', 13.49, 'Meat', true, 'assets/product/salad.jpg'),
('Ham', 8.99, 'Meat', true, 'assets/product/salad.jpg'),
('Sausage', 10.29, 'Meat', true, 'assets/product/salad.jpg'),
('Ground Beef', 11.29, 'Meat', true, 'assets/product/salad.jpg'),
('Chicken Breast', 14.99, 'Meat', true, 'assets/product/salad.jpg'),
('Crab', 18.99, 'Seafood', true, 'assets/product/salad.jpg'),
('Fish', 8.49, 'Seafood', true, 'assets/product/salad.jpg'),
('Salmon', 16.79, 'Seafood', true, 'assets/product/salad.jpg'),
('Shrimp', 12.29, 'Seafood', true, 'assets/product/salad.jpg'),
('Tuna', 9.99, 'Seafood', true, 'assets/product/salad.jpg'),
('Mussels', 10.49, 'Seafood', true, 'assets/product/salad.jpg'),
('Lobster', 19.99, 'Seafood', true, 'assets/product/salad.jpg'),
('Clams', 7.89, 'Seafood', true, 'assets/product/salad.jpg'),
('Oysters', 11.59, 'Seafood', true, 'assets/product/salad.jpg'),
('Cod', 8.99, 'Seafood', true, 'assets/product/salad.jpg'),
('Spinach', 3.99, 'Vegetables', true, 'assets/product/salad.jpg'),
('Lettuce', 2.49, 'Vegetables', true, 'assets/product/salad.jpg'),
('Kale', 4.29, 'Vegetables', true, 'assets/product/salad.jpg'),
('Arugula', 5.19, 'Vegetables', true, 'assets/product/salad.jpg'),
('Swiss Chard', 6.89, 'Vegetables', true, 'assets/product/salad.jpg'),
('Mustard Greens', 4.59, 'Vegetables', true, 'assets/product/salad.jpg'),
('Collard Greens', 5.99, 'Vegetables', true, 'assets/product/salad.jpg'),
('Beet Greens', 4.29, 'Vegetables', true, 'assets/product/salad.jpg'),
('Romaine Lettuce', 5.39, 'Vegetables', true, 'assets/product/salad.jpg'),
('Endive', 7.49, 'Vegetables', true, 'assets/product/salad.jpg'),
('Apple', 1.99, 'Fruits', true, 'assets/product/salad.jpg'),
('Banana', 1.29, 'Fruits', true, 'assets/product/salad.jpg'),
('Orange', 2.49, 'Fruits', true, 'assets/product/salad.jpg'),
('Grapes', 3.99, 'Fruits', true, 'assets/product/salad.jpg'),
('Mango', 4.79, 'Fruits', true, 'assets/product/salad.jpg'),
('Pineapple', 5.99, 'Fruits', true, 'assets/product/salad.jpg'),
('Strawberry', 6.49, 'Fruits', true, 'assets/product/salad.jpg'),
('Blueberry', 4.99, 'Fruits', true, 'assets/product/salad.jpg'),
('Peach', 3.29, 'Fruits', true, 'assets/product/salad.jpg'),
('Watermelon', 7.99, 'Fruits', true, 'assets/product/salad.jpg'),
('Milk', 2.99, 'Dairy', true, 'assets/product/salad.jpg'),
('Cheese', 5.49, 'Dairy', true, 'assets/product/salad.jpg'),
('Yogurt', 4.29, 'Dairy', true, 'assets/product/salad.jpg'),
('Butter', 3.79, 'Dairy', true, 'assets/product/salad.jpg'),
('Cream', 6.49, 'Dairy', true, 'assets/product/salad.jpg'),
('Cottage Cheese', 5.99, 'Dairy', true, 'assets/product/salad.jpg'),
('Sour Cream', 4.99, 'Dairy', true, 'assets/product/salad.jpg'),
('Buttermilk', 3.49, 'Dairy', true, 'assets/product/salad.jpg'),
('Ricotta', 7.29, 'Dairy', true, 'assets/product/salad.jpg'),
('Kefir', 6.79, 'Dairy', true, 'assets/product/salad.jpg');


-- Assign roles to users
--INSERT INTO users_roles (user_id, role_name) VALUES
--((SELECT id FROM users WHERE username = 'admin'), 'ADMIN')
--((SELECT id FROM users WHERE username = 'test'), 'USER');

-- Assign permissions to roles
INSERT INTO roles_permissions (role_name, permission_name) VALUES
('USER', 'READ'),
('ADMIN', 'READ'),
('ADMIN', 'WRITE');
