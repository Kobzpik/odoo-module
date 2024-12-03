#!/bin/bash

########################################################################
########   script for install odoo module   ############################
########################################################################

# Exit immediately if a command exits with a non-zero status
set -e

#enable nginx  module
sudo filebeat modules enable nginx 
sudo sed -i 's/enabled: false/enabled: true/' /etc/filebeat/modules.d/nginx.yml

# enable system module system
sudo filebeat modules enable system  
sudo sed -i 's/enabled: false/enabled: true/' /etc/filebeat/modules.d/system.yml

# enable system module postgresql
sudo filebeat modules enable postgresql
sudo sed -i 's/enabled: false/enabled: true/' /etc/filebeat/modules.d/postgresql.yml 


# restart the filebeat service
sudo systemctl restart filebeat

# Display success message in green text
echo -e "\e[32mModule enable completed successfully!\e[0m"
