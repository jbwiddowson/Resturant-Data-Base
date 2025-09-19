#!/bin/bash
-- Insert Categories
INSERT INTO categories (category_name, description, display_order) VALUES
('Appetizers', 'Start your meal with our delicious appetizers', 1),
('Soups & Salads', 'Fresh soups and crispy salads', 2),
('Main Courses', 'Hearty main dishes and entrees', 3),
('Pasta & Rice', 'Italian pasta and rice dishes', 4),
('Seafood', 'Fresh catches from the ocean', 5),
('Steaks & Grills', 'Premium cuts grilled to perfection', 6),
('Vegetarian', 'Healthy vegetarian options', 7),
('Desserts', 'Sweet treats to end your meal', 8),
('Beverages', 'Refreshing drinks and specialty beverages', 9),
('Kids Menu', 'Special meals for our young guests', 10);

-- Insert Sample Suppliers
INSERT INTO suppliers (supplier_name, contact_person, email, phone, address, payment_terms, delivery_days) VALUES
('Fresh Farm Produce', 'John Martinez', 'orders@freshfarm.com', '555-0101', '123 Farm Road, Valley City', 'Net 15', 'Mon,Wed,Fri'),
('Ocean Blue Seafood', 'Sarah Chen', 'supply@oceanblue.com', '555-0102', '456 Harbor Street, Coast City', 'Net 30', 'Tue,Thu,Sat'),
('Premium Meats Co', 'Mike Johnson', 'sales@premiummeats.com', '555-0103', '789 Butcher Lane, Meat Valley', 'Net 30', 'Mon,Wed,Fri'),
('Dairy Fresh Solutions', 'Lisa Wilson', 'orders@dairyfresh.com', '555-0104', '321 Milk Street, Dairy Town', 'Net 15', 'Daily'),
('Spice World Trading', 'Roberto Silva', 'info@spiceworld.com', '555-0105', '654 Spice Avenue, Flavor City', 'Net 45', 'Mon,Fri');

-- Insert Sample Ingredients
INSERT INTO ingredients (ingredient_name, category, unit_of_measure, unit_cost, supplier_id, minimum_stock, current_stock, reorder_point) VALUES
('Chicken Breast', 'MEAT', 'lbs', 4.50, 3, 50, 75, 60),
('Salmon Fillet', 'SEAFOOD', 'lbs', 12.00, 2, 20, 30, 25),
('Ground Beef', 'MEAT', 'lbs', 5.25, 3, 40, 60, 45),
('Lettuce', 'VEGETABLES', 'heads', 1.25, 1, 30, 50, 35),
('Tomatoes', 'VEGETABLES', 'lbs', 2.00, 1, 25, 40, 30),
('Onions', 'VEGETABLES', 'lbs', 1.50, 1, 20, 35, 25),
('Cheddar Cheese', 'DAIRY', 'lbs', 4.00, 4, 15, 25, 18),
('Olive Oil', 'OTHER', 'liters', 8.00, 5, 5, 10, 7),
('Salt', 'SPICES', 'lbs', 0.75, 5, 10, 20, 12),
('Black Pepper', 'SPICES', 'lbs', 12.00, 5, 2, 5, 3);

-- Insert Positions
INSERT INTO positions (position_name, hourly_rate, can_take_orders, can_access_kitchen, can_handle_payments, can_manage_inventory, can_view_reports, description) VALUES
('Server', 15.00, TRUE, FALSE, TRUE, FALSE, FALSE, 'Takes orders and serves customers'),
('Cook', 18.00, FALSE, TRUE, FALSE, FALSE, FALSE, 'Prepares food in kitchen'),
('Manager', 25.00, TRUE, TRUE, TRUE, TRUE, TRUE, 'Manages restaurant operations'),
('Host/Hostess', 14.00, FALSE, FALSE, FALSE, FALSE, FALSE, 'Greets and seats customers'),
('Bartender', 16.50, TRUE, FALSE, TRUE, FALSE, FALSE, 'Prepares and serves beverages'),
('Cashier', 15.50, TRUE, FALSE, TRUE, FALSE, FALSE, 'Handles payments and takeout orders'),
('Kitchen Manager', 22.00, FALSE, TRUE, FALSE, TRUE, TRUE, 'Manages kitchen operations and inventory');

-- Insert Staff
INSERT INTO staff (employee_code, first_name, last_name, email, phone, position_id, hire_date, status) VALUES
('EMP001', 'Maria', 'Rodriguez', 'maria.r@restaurant.com', '555-1001', 3, '2023-01-15', 'ACTIVE'),
('EMP002', 'James', 'Wilson', 'james.w@restaurant.com', '555-1002', 1, '2023-02-01', 'ACTIVE'),
('EMP003', 'Chef', 'Antonio', 'antonio@restaurant.com', '555-1003', 2, '2023-01-20', 'ACTIVE'),
('EMP004', 'Emily', 'Davis', 'emily.d@restaurant.com', '555-1004', 4, '2023-03-10', 'ACTIVE'),
('EMP005', 'Michael', 'Brown', 'michael.b@restaurant.com', '555-1005', 5, '2023-02-15', 'ACTIVE'),
('EMP006', 'Sarah', 'Johnson', 'sarah.j@restaurant.com', '555-1006', 1, '2023-04-01', 'ACTIVE'),
('EMP007', 'David', 'Lee', 'david.l@restaurant.com', '555-1007', 7, '2023-01-25', 'ACTIVE');

-- Insert Tables
INSERT INTO tables (table_number, seating_capacity, table_type, location_section, status) VALUES
('T01', 2, 'REGULAR', 'Main Dining', 'AVAILABLE'),
('T02', 4, 'REGULAR', 'Main Dining', 'AVAILABLE'),
('T03', 6, 'REGULAR', 'Main Dining', 'AVAILABLE'),
('T04', 4, 'BOOTH', 'Main Dining', 'AVAILABLE'),
('T05', 4, 'BOOTH', 'Main Dining', 'AVAILABLE'),
('T06', 8, 'REGULAR', 'Private Room', 'AVAILABLE'),
('B01', 2, 'BAR', 'Bar Area', 'AVAILABLE'),
('B02', 2, 'BAR', 'Bar Area', 'AVAILABLE'),
('P01', 4, 'OUTDOOR', 'Patio', 'AVAILABLE'),
('P02', 6, 'OUTDOOR', 'Patio', 'AVAILABLE');

-- Insert Menu Items
INSERT INTO menu_items (item_name, category_id, description, price, cost, preparation_time, is_vegetarian, is_vegan, is_gluten_free, is_available) VALUES
-- Appetizers
('Buffalo Wings', 1, 'Crispy chicken wings with spicy buffalo sauce', 12.99, 4.50, 15, FALSE, FALSE, FALSE, TRUE),
('Mozzarella Sticks', 1, 'Golden fried mozzarella with marinara sauce', 9.99, 3.20, 10, TRUE, FALSE, FALSE, TRUE),
('Spinach Artichoke Dip', 1, 'Creamy dip served with tortilla chips', 11.99, 3.80, 12, TRUE, FALSE, FALSE, TRUE),

-- Soups & Salads
('Caesar Salad', 2, 'Romaine lettuce, croutons, parmesan, caesar dressing', 10.99, 3.50, 8, TRUE, FALSE, FALSE, TRUE),
('Tomato Basil Soup', 2, 'Creamy tomato soup with fresh basil', 7.99, 2.25, 15, TRUE, TRUE, TRUE, TRUE),
('Greek Salad', 2, 'Mixed greens, feta, olives, tomatoes, cucumber', 12.99, 4.10, 10, TRUE, FALSE, TRUE, TRUE),

-- Main Courses
('Grilled Chicken Breast', 3, 'Herb-seasoned chicken breast with vegetables', 18.99, 6.50, 25, FALSE, FALSE, TRUE, TRUE),
('Beef Stir Fry', 3, 'Tender beef with mixed vegetables and rice', 16.99, 5.80, 20, FALSE, FALSE, FALSE, TRUE),
('Fish and Chips', 3, 'Beer-battered cod with fries and coleslaw', 15.99, 5.20, 18, FALSE, FALSE, FALSE, TRUE),

-- Pasta & Rice
('Spaghetti Bolognese', 4, 'Classic meat sauce with parmesan cheese', 14.99, 4.75, 20, FALSE, FALSE, FALSE, TRUE),
('Vegetable Fried Rice', 4, 'Wok-fried rice with mixed vegetables', 12.99, 3.90, 15, TRUE, TRUE, FALSE, TRUE),
('Chicken Alfredo', 4, 'Creamy alfredo sauce with grilled chicken', 17.99, 6.20, 22, FALSE, FALSE, FALSE, TRUE),

-- Seafood
('Grilled Salmon', 5, 'Atlantic salmon with lemon herb butter', 22.99, 9.50, 20, FALSE, FALSE, TRUE, TRUE),
('Shrimp Scampi', 5, 'Garlic butter shrimp over linguine', 19.99, 7.80, 18, FALSE, FALSE, FALSE, TRUE),

-- Steaks & Grills
('Ribeye Steak', 6, '12oz ribeye cooked to your preference', 28.99, 12.50, 25, FALSE, FALSE, TRUE, TRUE),
('BBQ Ribs', 6, 'Slow-cooked ribs with house BBQ sauce', 24.99, 9.20, 30, FALSE, FALSE, FALSE, TRUE),

-- Vegetarian
('Veggie Burger', 7, 'House-made patty with avocado and sprouts', 13.99, 4.60, 15, TRUE, TRUE, FALSE, TRUE),
('Quinoa Bowl', 7, 'Quinoa with roasted vegetables and tahini', 15.99, 5.40, 18, TRUE, TRUE, TRUE, TRUE),

-- Desserts
('Chocolate Cake', 8, 'Rich chocolate layer cake with frosting', 7.99, 2.80, 5, TRUE, FALSE, FALSE, TRUE),
('Cheesecake', 8, 'New York style cheesecake with berry compote', 8.99, 3.20, 5, TRUE, FALSE, FALSE, TRUE),

-- Beverages
('House Coffee', 9, 'Freshly brewed coffee blend', 2.99, 0.50, 3,
