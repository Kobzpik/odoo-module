#!/bin/bash

########################################################################
########   script for install odoo module   ############################
########################################################################

# Exit immediately if a command exits with a non-zero status
set -e

# Function to check if the input contains uppercase letters or spaces
contains_invalid_characters() {
    [[ "$1" =~ [A-Z] || "$1" =~ [[:space:]] ]]
}

# Prompt the user to enter the server name
while true; do
    echo "Please enter the server name (lowercase and no spaces):"
    read -p "Server name: " SERVER_NAME

    if contains_invalid_characters "$SERVER_NAME"; then
        echo "Error: Server name contains uppercase letters or spaces. Please enter a valid server name."
    else
        break
    fi
done

# add the server name to the filebeat.yml
sed -i "s/hostname_goes_here/$SERVER_NAME/g" /tmp/odoo-module/filebeat.yml

# copy filebeat.yml to /etc/filebeat/filebeat.yml
sudo cp /tmp/odoo-module/filebeat.yml /etc/filebeat/filebeat.yml

# restart the filebeat service
sudo systemctl restart filebeat

# install the odoo module
sudo cp /tmp/odoo-module/tigernix.yml /etc/filebeat/modules.d/tigernix.yml

# enable the odoo module
sudo filebeat modules enable tigernix

# configure odoo module
sudo cp -r /tmp/odoo-module/tigernix /usr/share/filebeat/module/tigernix

# restart the filebeat service
sudo systemctl restart filebeat

# Display success message in green text
echo -e "\e[32mModule installation completed successfully!\e[0m"
