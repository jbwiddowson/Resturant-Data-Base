# Resturant-Data-Base
# 🍽️ Restaurant Database Management System

A **comprehensive SQL database system** for managing all operations of a restaurant — from menu and inventory to staff, reservations, and orders.

> 🛠️ Built on **MySQL** using **Ubuntu** CLI — entirely self-taught as a personal practice project to sharpen SQL and relational DB design skills.

---

## 🧠 Key Concepts Practiced

- Advanced SQL (DDL + DML)
- Relational schema design & normalization
- Foreign keys, indexing, constraints
- Data integrity, performance optimization
- Simulated realistic restaurant operations

---

## 🛠️ Tech Stack

| Tool        | Version     |
|-------------|-------------|
| 💾 MySQL     | 8.x         |
| 🐧 Ubuntu    | 20.04+      |
| 🧮 Language  | SQL         |
| 🧑‍💻 Tools    | MySQL CLI   |

---

## 📦 Schema Overview

| Area                   | Tables Included                                                                 |
|------------------------|---------------------------------------------------------------------------------|
| 🍔 **Menu Management**  | `categories`, `menu_items`, `recipe_ingredients`                                |
| 📦 **Inventory**        | `ingredients`, `suppliers`, `purchase_orders`, `purchase_order_items`          |
| 👨‍🍳 **Staff**           | `staff`, `positions`, `staff_schedules`                                        |
| 📞 **Customers**        | `customers`                                                                     |
| 📆 **Reservations**     | `tables`, `reservations`                                                        |
| 🧾 **Orders**           | `orders`, `order_items`, `order_customizations`                                 |
| 🎁 **Promotions & Sales** | `promotions`, `daily_sales_summary`                                           |

---

## 📂 File Structure
├── README.md # Project documentation
├── create_user.sql # SQL to create MySQL user and assign privileges
├── restaurant_schema.sql # Full database schema with constraints and indexes
├── insert_sample_data.sql # Sample data: categories, staff, items, tables, etc.
