-- Create the restaurant database
CREATE DATABASE restaurant_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE restaurant_db;

-- ==================== MENU MANAGEMENT ====================

-- Categories table for organizing menu items
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    display_order INT DEFAULT 1,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_display_order (display_order),
    INDEX idx_active (is_active)
) ENGINE=InnoDB;

-- Menu items table
CREATE TABLE menu_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(150) NOT NULL,
    category_id INT NOT NULL,
    description TEXT,
    price DECIMAL(8,2) NOT NULL,
    cost DECIMAL(8,2) DEFAULT 0.00,
    preparation_time INT DEFAULT 15, -- minutes
    calories INT,
    is_vegetarian BOOLEAN DEFAULT FALSE,
    is_vegan BOOLEAN DEFAULT FALSE,
    is_gluten_free BOOLEAN DEFAULT FALSE,
    is_spicy BOOLEAN DEFAULT FALSE,
    spice_level ENUM('MILD', 'MEDIUM', 'HOT', 'EXTRA_HOT') DEFAULT 'MILD',
    is_available BOOLEAN DEFAULT TRUE,
    is_featured BOOLEAN DEFAULT FALSE,
    image_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE RESTRICT,
    INDEX idx_category (category_id),
    INDEX idx_price (price),
    INDEX idx_available (is_available),
    INDEX idx_dietary (is_vegetarian, is_vegan, is_gluten_free),
    FULLTEXT idx_search (item_name, description)
) ENGINE=InnoDB;

-- ==================== INVENTORY MANAGEMENT ====================

-- Ingredients/Inventory items
CREATE TABLE ingredients (
    ingredient_id INT AUTO_INCREMENT PRIMARY KEY,
    ingredient_name VARCHAR(100) NOT NULL UNIQUE,
    category ENUM('MEAT', 'SEAFOOD', 'VEGETABLES', 'DAIRY', 'GRAINS', 'SPICES', 'BEVERAGES', 'OTHER') NOT NULL,
    unit_of_measure VARCHAR(20) NOT NULL, -- kg, lbs, pieces, liters, etc.
    unit_cost DECIMAL(8,3) NOT NULL,
    supplier_id INT,
    minimum_stock DECIMAL(10,2) DEFAULT 0,
    current_stock DECIMAL(10,2) DEFAULT 0,
    reorder_point DECIMAL(10,2) DEFAULT 0,
    expiry_days INT DEFAULT 30, -- Days until expiry
    storage_location VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_category (category),
    INDEX idx_stock_level (current_stock, reorder_point),
    INDEX idx_supplier (supplier_id)
) ENGINE=InnoDB;

-- Recipe ingredients (what goes into each menu item)
CREATE TABLE recipe_ingredients (
    recipe_id INT AUTO_INCREMENT PRIMARY KEY,
    menu_item_id INT NOT NULL,
    ingredient_id INT NOT NULL,
    quantity_needed DECIMAL(8,3) NOT NULL,
    is_optional BOOLEAN DEFAULT FALSE,
    preparation_notes TEXT,
    FOREIGN KEY (menu_item_id) REFERENCES menu_items(item_id) ON DELETE CASCADE,
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(ingredient_id) ON DELETE RESTRICT,
    UNIQUE KEY unique_recipe (menu_item_id, ingredient_id),
    INDEX idx_menu_item (menu_item_id),
    INDEX idx_ingredient (ingredient_id)
) ENGINE=InnoDB;

-- ==================== STAFF MANAGEMENT ====================

-- Employee positions/roles
CREATE TABLE positions (
    position_id INT AUTO_INCREMENT PRIMARY KEY,
    position_name VARCHAR(100) NOT NULL UNIQUE,
    base_salary DECIMAL(10,2) DEFAULT 0.00,
    hourly_rate DECIMAL(6,2) DEFAULT 0.00,
    can_take_orders BOOLEAN DEFAULT FALSE,
    can_access_kitchen BOOLEAN DEFAULT FALSE,
    can_handle_payments BOOLEAN DEFAULT FALSE,
    can_manage_inventory BOOLEAN DEFAULT FALSE,
    can_view_reports BOOLEAN DEFAULT FALSE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Staff/Employees
CREATE TABLE staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_code VARCHAR(20) NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    address TEXT,
    position_id INT NOT NULL,
    hire_date DATE NOT NULL,
    hourly_rate DECIMAL(6,2),
    status ENUM('ACTIVE', 'INACTIVE', 'TERMINATED') DEFAULT 'ACTIVE',
    emergency_contact_name VARCHAR(100),
    emergency_contact_phone VARCHAR(20),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (position_id) REFERENCES positions(position_id) ON DELETE RESTRICT,
    INDEX idx_status (status),
    INDEX idx_position (position_id),
    INDEX idx_name (last_name, first_name)
) ENGINE=InnoDB;

-- Staff schedules
CREATE TABLE staff_schedules (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    staff_id INT NOT NULL,
    work_date DATE NOT NULL,
    shift_start TIME NOT NULL,
    shift_end TIME NOT NULL,
    break_duration INT DEFAULT 30, -- minutes
    status ENUM('SCHEDULED', 'CONFIRMED', 'COMPLETED', 'ABSENT', 'CANCELLED') DEFAULT 'SCHEDULED',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id) ON DELETE CASCADE,
    UNIQUE KEY unique_staff_date (staff_id, work_date, shift_start),
    INDEX idx_work_date (work_date),
    INDEX idx_staff_status (staff_id, status)
) ENGINE=InnoDB;

-- ==================== CUSTOMER MANAGEMENT ====================

-- Customer information (for loyalty program, reservations)
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20) UNIQUE,
    date_of_birth DATE,
    address TEXT,
    loyalty_points INT DEFAULT 0,
    total_visits INT DEFAULT 0,
    total_spent DECIMAL(12,2) DEFAULT 0.00,
    preferred_table VARCHAR(20),
    dietary_restrictions TEXT,
    allergies TEXT,
    status ENUM('ACTIVE', 'INACTIVE', 'BLOCKED') DEFAULT 'ACTIVE',
    registration_date DATE DEFAULT (CURRENT_DATE),
    last_visit_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email),
    INDEX idx_phone (phone),
    INDEX idx_loyalty_points (loyalty_points),
    INDEX idx_last_visit (last_visit_date)
) ENGINE=InnoDB;

-- ==================== TABLE AND RESERVATION MANAGEMENT ====================

-- Restaurant tables
CREATE TABLE tables (
    table_id INT AUTO_INCREMENT PRIMARY KEY,
    table_number VARCHAR(10) NOT NULL UNIQUE,
    seating_capacity INT NOT NULL,
    table_type ENUM('REGULAR', 'BOOTH', 'BAR', 'OUTDOOR', 'PRIVATE') DEFAULT 'REGULAR',
    location_section VARCHAR(50), -- Main dining, Patio, Bar area, etc.
    is_available BOOLEAN DEFAULT TRUE,
    status ENUM('AVAILABLE', 'OCCUPIED', 'RESERVED', 'CLEANING', 'OUT_OF_ORDER') DEFAULT 'AVAILABLE',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_capacity (seating_capacity),
    INDEX idx_status (status),
    INDEX idx_section (location_section)
) ENGINE=InnoDB;

-- Reservations
CREATE TABLE reservations (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    customer_name VARCHAR(100) NOT NULL, -- For walk-ins without customer record
    customer_phone VARCHAR(20),
    party_size INT NOT NULL,
    reservation_date DATE NOT NULL,
    reservation_time TIME NOT NULL,
    table_id INT,
    status ENUM('PENDING', 'CONFIRMED', 'SEATED', 'COMPLETED', 'CANCELLED', 'NO_SHOW') DEFAULT 'PENDING',
    special_requests TEXT,
    occasion VARCHAR(100), -- Birthday, Anniversary, etc.
    created_by_staff_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE SET NULL,
    FOREIGN KEY (table_id) REFERENCES tables(table_id) ON DELETE SET NULL,
    FOREIGN KEY (created_by_staff_id) REFERENCES staff(staff_id) ON DELETE SET NULL,
    INDEX idx_reservation_datetime (reservation_date, reservation_time),
    INDEX idx_customer (customer_id),
    INDEX idx_status (status),
    INDEX idx_table (table_id)
) ENGINE=InnoDB;

-- ==================== ORDER MANAGEMENT ====================

-- Orders (main order information)
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_number VARCHAR(20) NOT NULL UNIQUE,
    customer_id INT,
    table_id INT,
    staff_id INT NOT NULL, -- Server who took the order
    order_type ENUM('DINE_IN', 'TAKEOUT', 'DELIVERY', 'DRIVE_THROUGH') NOT NULL,
    order_date DATE NOT NULL,
    order_time TIME NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    tax_amount DECIMAL(8,2) NOT NULL DEFAULT 0.00,
    tip_amount DECIMAL(8,2) DEFAULT 0.00,
    discount_amount DECIMAL(8,2) DEFAULT 0.00,
    total_amount DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    payment_method ENUM('CASH', 'CREDIT_CARD', 'DEBIT_CARD', 'MOBILE_PAY', 'GIFT_CARD', 'LOYALTY_POINTS') DEFAULT 'CASH',
    payment_status ENUM('PENDING', 'PAID', 'PARTIAL', 'REFUNDED', 'FAILED') DEFAULT 'PENDING',
    order_status ENUM('PLACED', 'CONFIRMED', 'PREPARING', 'READY', 'SERVED', 'COMPLETED', 'CANCELLED') DEFAULT 'PLACED',
    special_instructions TEXT,
    estimated_completion_time DATETIME,
    actual_completion_time DATETIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE SET NULL,
    FOREIGN KEY (table_id) REFERENCES tables(table_id) ON DELETE SET NULL,
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id) ON DELETE RESTRICT,
    INDEX idx_order_date (order_date),
    INDEX idx_order_status (order_status),
    INDEX idx_payment_status (payment_status),
    INDEX idx_customer (customer_id),
    INDEX idx_staff (staff_id),
    INDEX idx_order_type (order_type)
) ENGINE=InnoDB;

-- Order items (individual items in each order)
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    menu_item_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    unit_price DECIMAL(8,2) NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    special_instructions TEXT,
    status ENUM('ORDERED', 'PREPARING', 'READY', 'SERVED', 'CANCELLED') DEFAULT 'ORDERED',
    preparation_start_time DATETIME,
    preparation_complete_time DATETIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (menu_item_id) REFERENCES menu_items(item_id) ON DELETE RESTRICT,
    INDEX idx_order (order_id),
    INDEX idx_menu_item (menu_item_id),
    INDEX idx_status (status)
) ENGINE=InnoDB;

-- Order item customizations (modifications to menu items)
CREATE TABLE order_customizations (
    customization_id INT AUTO_INCREMENT PRIMARY KEY,
    order_item_id INT NOT NULL,
    customization_type ENUM('ADD', 'REMOVE', 'SUBSTITUTE', 'EXTRA', 'ON_SIDE') NOT NULL,
    ingredient_id INT,
    description VARCHAR(200) NOT NULL,
    price_adjustment DECIMAL(6,2) DEFAULT 0.00,
    FOREIGN KEY (order_item_id) REFERENCES order_items(order_item_id) ON DELETE CASCADE,
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(ingredient_id) ON DELETE SET NULL,
    INDEX idx_order_item (order_item_id)
) ENGINE=InnoDB;

-- ==================== SUPPLIER MANAGEMENT ====================

-- Suppliers for ingredients
CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(150) NOT NULL,
    contact_person VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address TEXT,
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(20),
    country VARCHAR(50) DEFAULT 'USA',
    payment_terms VARCHAR(100), -- Net 30, COD, etc.
    delivery_days VARCHAR(100), -- Mon, Wed, Fri
    minimum_order_amount DECIMAL(10,2) DEFAULT 0.00,
    rating DECIMAL(3,2) DEFAULT 5.00, -- Out of 5
    is_active BOOLEAN DEFAULT TRUE,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_name (supplier_name),
    INDEX idx_active (is_active),
    INDEX idx_rating (rating)
) ENGINE=InnoDB;

-- Add supplier foreign key to ingredients
ALTER TABLE ingredients 
ADD CONSTRAINT fk_ingredient_supplier 
FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id) ON DELETE SET NULL;

-- Purchase orders from suppliers
CREATE TABLE purchase_orders (
    po_id INT AUTO_INCREMENT PRIMARY KEY,
    po_number VARCHAR(20) NOT NULL UNIQUE,
    supplier_id INT NOT NULL,
    order_date DATE NOT NULL,
    expected_delivery_date DATE,
    actual_delivery_date DATE,
    subtotal DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    tax_amount DECIMAL(10,2) DEFAULT 0.00,
    shipping_cost DECIMAL(8,2) DEFAULT 0.00,
    total_amount DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    status ENUM('DRAFT', 'SENT', 'CONFIRMED', 'DELIVERED', 'COMPLETED', 'CANCELLED') DEFAULT 'DRAFT',
    payment_status ENUM('PENDING', 'PAID', 'PARTIAL', 'OVERDUE') DEFAULT 'PENDING',
    created_by_staff_id INT,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id) ON DELETE RESTRICT,
    FOREIGN KEY (created_by_staff_id) REFERENCES staff(staff_id) ON DELETE SET NULL,
    INDEX idx_order_date (order_date),
    INDEX idx_supplier (supplier_id),
    INDEX idx_status (status)
) ENGINE=InnoDB;

-- Purchase order items
CREATE TABLE purchase_order_items (
    po_item_id INT AUTO_INCREMENT PRIMARY KEY,
    po_id INT NOT NULL,
    ingredient_id INT NOT NULL,
    quantity_ordered DECIMAL(10,3) NOT NULL,
    quantity_received DECIMAL(10,3) DEFAULT 0.000,
    unit_cost DECIMAL(8,3) NOT NULL,
    total_cost DECIMAL(12,2) NOT NULL,
    expiry_date DATE,
    batch_number VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (po_id) REFERENCES purchase_orders(po_id) ON DELETE CASCADE,
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(ingredient_id) ON DELETE RESTRICT,
    INDEX idx_po (po_id),
    INDEX idx_ingredient (ingredient_id)
) ENGINE=InnoDB;

-- ==================== ADDITIONAL TABLES ====================

-- Promotions and discounts
CREATE TABLE promotions (
    promotion_id INT AUTO_INCREMENT PRIMARY KEY,
    promotion_name VARCHAR(100) NOT NULL,
    description TEXT,
    discount_type ENUM('PERCENTAGE', 'FIXED_AMOUNT', 'BUY_ONE_GET_ONE') NOT NULL,
    discount_value DECIMAL(8,2) NOT NULL,
    minimum_order_amount DECIMAL(8,2) DEFAULT 0.00,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    applicable_days SET('MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY', 'SATURDAY', 'SUNDAY'),
    time_restrictions VARCHAR(100), -- "12:00-15:00" for lunch specials
    max_uses_per_customer INT DEFAULT NULL,
    total_usage_limit INT DEFAULT NULL,
    current_usage_count INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_dates (start_date, end_date),
    INDEX idx_active (is_active)
) ENGINE=InnoDB;

-- Daily sales summary for reporting
CREATE TABLE daily_sales_summary (
    summary_id INT AUTO_INCREMENT PRIMARY KEY,
    business_date DATE NOT NULL UNIQUE,
    total_orders INT DEFAULT 0,
    total_customers INT DEFAULT 0,
    gross_sales DECIMAL(12,2) DEFAULT 0.00,
    discounts DECIMAL(10,2) DEFAULT 0.00,
    taxes DECIMAL(10,2) DEFAULT 0.00,
    tips DECIMAL(10,2) DEFAULT 0.00,
    net_sales DECIMAL(12,2) DEFAULT 0.00,
    avg_order_value DECIMAL(8,2) DEFAULT 0.00,
    cash_sales DECIMAL(10,2) DEFAULT 0.00,
    card_sales DECIMAL(10,2) DEFAULT 0.00,
    labor_cost DECIMAL(10,2) DEFAULT 0.00,
    food_cost DECIMAL(10,2) DEFAULT 0.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_business_date (business_date)
) ENGINE=InnoDB;
