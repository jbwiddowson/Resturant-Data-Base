#!/bin/bash
# Connect to MySQL
sudo mysql -u root -p

# Or create and use specific user
sudo mysql -u root -p -e "
CREATE USER 'restaurant_admin'@'localhost' IDENTIFIED BY 'RestaurantPass123!';
GRANT ALL PRIVILEGES ON restaurant_db.* TO 'restaurant_admin'@'localhost';
FLUSH PRIVILEGES;"

# Connect as restaurant admin
mysql -u restaurant_admin -p
