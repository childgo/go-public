
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/RockyLinux8/csf_install.sh1)





#Install the dependencies
dnf install perl-libwww-perl -y;sleep 3;
dnf install perl-Math-BigInt -y;sleep 3;
dnf install wget -y;sleep 3;

#Download CSF files and extract them
cd /usr/src;sleep 3;
wget https://download.configserver.com/csf.tgz;sleep 3;
tar xzf csf.tgz;sleep 3;
cd csf;sleep 3;

#Run the installation script
sh install.sh;sleep 3;


#Enable and start csf and lfd services
systemctl enable csf && systemctl enable lfd
systemctl start csf && systemctl restart lfd






#======================================================================
#CSF Setting
#======================================================================
echo "Start changing CSF from '1' to '0' to activate it...."
sed -i 's/TESTING = "1"/TESTING = "0"/' /etc/csf/csf.conf
echo "Verify that the change was successful. ...."
grep -r "TESTING =" /etc/csf/csf.conf



#Start changing  protocal
echo "Start changing  protocal...."

file="/etc/csf/csf.conf"

################################################################
# Comment out the existing TCP_IN line
sed -i 's/^TCP_IN.*/#&/' "$file"

# Add a new line with TCP_IN set to an empty string
sed -i '/#TCP_IN/a TCP_IN = ""' "$file"


# Comment out the existing TCP_OUT line
sed -i 's/^TCP_OUT.*/#&/' "$file"

# Add a new line with TCP_OUT set to an empty string
sed -i '/#TCP_OUT/a TCP_OUT = ""' "$file"


# Comment out the existing UDP_IN line
sed -i 's/^UDP_IN.*/#&/' "$file"

# Add a new line with UDP_IN set to an empty string
sed -i '/#UDP_IN/a UDP_IN = ""' "$file"


# Comment out the existing UDP_OUT line
sed -i 's/^UDP_OUT.*/#&/' "$file"

# Add a new line with UDP_OUT set to an empty string
sed -i '/#UDP_OUT/a UDP_OUT = ""' "$file"
################################################################



################################################################
# Comment out the TCP6_IN line
sed -i 's/^TCP6_IN.*/#&/' "$file"

# Comment out the TCP6_OUT line
sed -i 's/^TCP6_OUT.*/#&/' "$file"


# Comment out the UDP6_IN line
sed -i 's/^UDP6_IN.*/#&/' "$file"

# Define the file to modify
file="/etc/csf/csf6.conf"

# Comment out the UDP6_OUT line
sed -i 's/^UDP6_OUT.*/#&/' "$file"
################################################################



echo "Verify that the change was successful. ...."
grep -r "TCP_IN =" /etc/csf/csf.conf
grep -r "TCP_OUT =" /etc/csf/csf.conf
grep -r "UDP_IN =" /etc/csf/csf.conf
grep -r "UDP_OUT =" /etc/csf/csf.conf


grep -r "TCP6_IN =" /etc/csf/csf.conf
grep -r "TCP6_OUT =" /etc/csf/csf.conf
grep -r "UDP6_IN =" /etc/csf/csf.conf
grep -r "UDP6_OUTT =" /etc/csf/csf.conf
#======================================================================




systemctl enable csf && systemctl enable lfd
systemctl start csf && systemctl restart lfd


#Check if both services have started with no issues
perl /usr/local/csf/bin/csftest.pl
systemctl status csf
systemctl status lfd
csf -e






