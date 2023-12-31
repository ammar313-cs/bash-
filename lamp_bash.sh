#!/bin/bash

# Update package lists
sudo apt update

# Install Apache
sudo apt install -y apache2

# Verify Apache status
sudo systemctl status apache2

# Check Apache test page
curl http://localhost:80

# Install MySQL server
sudo apt install -y mysql-server

# Log into MySQL console
sudo mysql

# Exit MySQL shell
mysql> exit

# Secure MySQL installation
sudo mysql_secure_installation

# Install PHP and necessary modules
sudo apt install -y php libapache2-mod-php php-mysql

# Verify PHP installation
php -v

# Create directory for the virtual host
sudo mkdir /var/www/projectlamp
sudo chown -R $USER:$USER /var/www/projectlamp

# Create Apache config file for the virtual host
sudo tee /etc/apache2/sites-available/projectlamp.conf > /dev/null <<EOT
<VirtualHost *:80>
    ServerName projectlamp
    ServerAlias www.projectlamp
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/projectlamp
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOT

# Enable virtual host
sudo a2ensite projectlamp

# Disable default Apache website
sudo a2dissite 000-default

# Check Apache configuration for errors
sudo apache2ctl configtest

# Reload Apache to apply changes
sudo systemctl reload apache2

# Create a custom index.html for the virtual host
sudo echo 'Hello LAMP from hostname $(curl -s http://169.254.169.254/latest/meta-data/public-hostname) with public IP $(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)' > /var/www/projectlamp/index.html

# Modify DirectoryIndex to prioritize index.php
sudo sed -i 's/index.html index.cgi index.pl index.php index.xhtml index.htm/index.php index.html index.cgi index.pl index.xhtml index.htm/' /etc/apache2/mods-enabled/dir.conf

# Reload Apache to apply changes
sudo systemctl reload apache2

# Create index.php for the virtual host
sudo tee /var/www/projectlamp/index.php > /dev/null <<EOT
<?php
phpinfo();
?>
EOT

# Verify setup
echo "Current user: $(whoami)"
ls -l /var/www/

# Display final message
echo "Access the website in your browser to check if the LAMP stack is properly deployed!"
