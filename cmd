Sudo apt update

Sudo apt install apache2 -y

Sudo apt install net-tools

Sudo nano /var/www/html/index.html

Inside file: default page 1
^O Enter ^X

Sudo systemctl enable apache2

Sudo systemctl status apache2

ifconfig -> copy ip address 

Inside firefox paste the ip

- >> next power on clone 

Sudo apt update

Sudo apt install haproxy -y

sudo nano /etc/haproxy/haproxy.cfg

Inside file below defaults

frontend http_front
             bind *:80
             default_backend http_back

backend http_back
             balance roundrobin
            server vm1 192.168
169.223:80 check 
server vm2 192.168
169.221:80 check 

Save

sudo systemctl restart haproxy 

Sudo systemctl enable haproxy 

Sudo systemctl status haproxy 

Sudo apt install net-tools

Ifconfig -> copy ip
