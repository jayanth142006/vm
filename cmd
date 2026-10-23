sudo apt update
sudo apt install apache2 -y
sudo systemctl enable apache2
sudo systemctl start apache2
sudo systemctl status apache2
VM1 : echo "<h1>Hello from VM1</h1>" | sudo tee /var/www/html/index.html
VM2: echo "<h1>Hello from VM2</h1>" | sudo tee /var/www/html/index.html
___________________________________________________________________________________________
sudo apt install net-tools -y
ifconfig
ping -c 4 VM1_IP
ping -c 4 VM2_IP
___________________________________________________________________________________________
4: Load Balancing
sudo apt update
sudo apt install haproxy -y
sudo cp /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.backup
sudo nano /etc/haproxy/haproxy.cfg
bottom of the file.
frontend http_front
    bind *:80
    default_backend http_back

backend http_back
    balance roundrobin
    option httpchk GET /
    server VM1 VM1_IP:80 check
    server VM2 VM2_IP:80 check
Ctrl + O.
Enter.
Ctrl + X.
sudo haproxy -c -f /etc/haproxy/haproxy.cfg
sudo systemctl restart haproxy
sudo systemctl enable haproxy
browser...
http://VM3_IP
___________________________________________________________________________________________
Server Consolidation and Resource Monitoring
sudo apt update
sudo apt install htop -y
htop (q to exit)
1. Open VMware Workstation.
2. Select a VM.
3. Click Edit virtual machine settings.
4. Click Memory and record the RAM allocation.
5. Click Processors and record the number of virtual CPUs.
6. Repeat for the other VMs.
___________________________________________________________________________________________
Task Scheduling Using a Shell Script and Cron
Perform these steps on one Ubuntu VM.

Open Terminal and nano script.sh
Enter these two lines:
#!/bin/bash
echo "Hello from scheduled task"
1. Press Ctrl + O.
2. Press Enter.
3. Press Ctrl + X.
chmod +x script.sh
pwd
./script.sh
crontab -e
At the bottom of the file, add the following line. Replace /home/ubuntu if your actual path differs.

* * * * * /home/ubuntu/script.sh >> /home/ubuntu/output.log 2>&1 (get the path from pwd)
Field		   Meaning
First  *	Every minute
Second *	Every hour
Third  *	Every day of the month
Fourth *	Every month
Fifth  *	Every day of the week

1. Press Ctrl + O.
2. Press Enter.
3. Press Ctrl + X.
sudo systemctl enable --now cron
sudo systemctl status cron
Wait one minute, then cat output.log
___________________________________________________________________________________________
Fault Tolerance of the Load Balancer

Stop Apache on VM1
on VM1 : sudo systemctl stop apache2
