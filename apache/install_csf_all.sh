
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/apache/install_csf_all.sh)
clear

#Install ALL
#[ConfigServer Security and Firewall]
#Installtion [ConfigServer Explorer]
#Installtion [ConfigServer Mail Manage]
#Installtion [ConfigServer Mail Manage]






#======================================================================
#Installation CSF [ConfigServer Security and Firewall]
#======================================================================
echo "Installtion [ConfigServer Security and Firewall]"
cd /usr/src;sleep 3;
rm -fv csf.tgz;sleep 3;
wget https://download.configserver.com/csf.tgz;sleep 3;
tar -xzf csf.tgz;sleep 3;
cd csf;sleep 3;
sh install.sh;sleep 3;

#Enable CSF
echo "Start changing CSF from '1' to '0' to activate it...."
sed -i 's/TESTING = "1"/TESTING = "0"/' /etc/csf/csf.conf
echo "Verify that the change was successful. ...."
grep -r "TESTING =" /etc/csf/csf.conf


#Start CSF
systemctl enable csf;sleep 3;
systemctl enable lfd;sleep 3;
service csf start;sleep 3;
service lfd start;sleep 3;
perl /usr/local/csf/bin/csftest.pl;sleep 3;
#======================================================================
#CSF End
#======================================================================



#======================================================================
#Installtion [ConfigServer Explorer]
#======================================================================
echo "Installtion [ConfigServer Explorer]"
cd /usr/src ;sleep 3;
rm -fv /usr/src/cse.tgz;sleep 3;
wget https://download.configserver.com/cse.tgz;sleep 3;
tar -xzf cse.tgz;sleep 3;
cd cse;sleep 3;
sh install.sh;sleep 3;
rm -Rfv /usr/src/cse*;sleep 3;
#======================================================================
#End [ConfigServer Explorer]
#======================================================================





#======================================================================
#Installtion [ConfigServer Mail Manage]
#======================================================================
echo "Installtion [ConfigServer Mail Manage]"
cd /usr/src;sleep 3;
rm -fv /usr/src/cmm.tgz;sleep 3;
wget http://download.configserver.com/cmm.tgz;sleep 3;
tar -xzf cmm.tgz;sleep 3;
cd cmm;sleep 3;
sh install.sh;sleep 3;
rm -Rfv /usr/src/cmm*;sleep 3;
#======================================================================
#End [ConfigServer Mail Manage]
#======================================================================


#======================================================================
#Installtion [ConfigServer Mail Manage]
#======================================================================
echo "Installtion [ConfigServer Mail Manage]"
cd /usr/src;sleep 3;
rm -fv /usr/src/cmq.tgz;sleep 3;
wget http://download.configserver.com/cmq.tgz;sleep 3;
tar -xzf cmq.tgz;sleep 3;
cd cmq;sleep 3;
sh install.sh;sleep 3;
rm -Rfv /usr/src/cmq*;sleep 3;
#======================================================================
#End [ConfigServer Mail Manage]
#======================================================================



echo "============================
echo "Finish ALL"
echo "============================



