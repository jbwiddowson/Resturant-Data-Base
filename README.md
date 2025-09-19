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

## 🧪Sample Data Included

✅ 10 menu categories  
✅ 50+ menu items with dietary flags  
✅ 10 suppliers with purchase order setup  
✅ Staff roles and schedules  
✅ Tables (booths, bar, outdoor, etc.)  
✅ Reservations and customer data  
✅ Orders and order items  
✅ Daily sales summaries

---

## 📈 Highlights

🎯 Normalized schema — avoids redundancy and maintains data integrity  
⚡ Optimized with indexes — supports fast lookups and reporting  
🔐 Rich use of constraints — enum types, foreign keys, cascading deletes  
🔍 Searchable — full-text index on menu descriptions  
🍝 Realistic — ready for POS integration, reporting dashboards, or restaurant apps

## 📁 Each File

📂 /database  
├── 📄 restaurant_schema.sql  
├── 📄 sample_data.sql  
├── 📝 setup_restaurant_db.sh 


