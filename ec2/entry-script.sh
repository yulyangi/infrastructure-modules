#!/bin/env bash 
sudo apt -y update && sudo apt -y install apache2 bind9 bind9utils bind9-doc
sudo systemctl start apache2 && sudo systemctl enable apache2
sudo systemctl start bind9 && sudo systemctl enable bind9  
sudo echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html

# configuring bind
sudo sed -i 's/OPTIONS="-u bind"/OPTIONS="-u bind -4"/' /etc/default/named
sudo sed '/.*listen-on-v6 { any; };/        forwarders { 8.8.8.8; 8.8.4.4; };' /etc/bind/named.conf.options
sudo tee -a /etc/bind/named.conf.local <<EOF
zone "binbash.site" {
    type master;
    file "/etc/bind/db.binbash.site";
};
EOF
sudo cp /etc/bind/db.empty /etc/bind/db.binbash.site
sudo sed -i '6s/.*/@        IN        SOA        ns1.binbash.site. root.localhost. (/' /etc/bind/db.binbash.site
sudo sed -i '13s/.*/@        IN        NS        ns1.binbash.site./' /etc/bind/db.binbash.site
sudo tee -a /etc/bind/db.binbash.site <<EOF 
@        IN        NS        ns2.binbash.site.
ns1      IN        A         54.158.23.174
ns2      IN        A         54.158.23.174
mail     IN        MX 10     mail.binbash.site.
binbash.site.      IN        A        54.158.23.174
www      IN        A         54.158.23.174
mail     IN        A         54.158.23.174
public-dns         IN        A         8.8.8.8
EOF

systemctl reload-or-restart bind9


# configuring ssl
sudo apt -y install certbot python3-certbot-apache 
sudo certbot -d binbash.site
expect "Your name: "
send -- "expect\n"