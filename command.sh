########################################################################
########   script for install odoo module   ############################
########################################################################

# Prompt the user to enter the server name
echo "Please enter the server name (Lowercase and no space):"
read -p "Server name: " SERVER_NAME

# add the server name to the filebeat.yml
sed -i "s/hostname_goes_here/$SERVER_NAME/g" /tmp/odoo-module/filebeat.yml

# copy filebeat.yml to /etc/filebeat/filebeat.yml
sudo cp /tmp/odoo-module/filebeat.yml /etc/filebeat/filebeat.yml

# restart the filebeat service
sudo systemctl restart filebeat

# install the odoo module
sudo mv /tmp/odoo-module/odoo.yml /etc/filebeat/modules.d/odoo.yml

# enable the odoo module
sudo filebeat modules enable odoo

# configure odoo module
sudo mv /tmp/odoo-module/odoo /usr/share/filebeat/module/odoo

# restart the filebeat service
sudo sudo systemctl restart filebeat