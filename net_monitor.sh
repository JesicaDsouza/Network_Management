#! /bin/bash
# unset any variable which system may be using

unset resetattr os architecture kernelrelease internalip externalip nameserver 

if [[ $# -eq 0 ]]
then
{

# Define Variable resetattr
resetattr=$(tput sgr0)

# Check if connected to Internet or not
ping www.google.com &> /dev/null && echo -e '\E[32m'"Internet: $resetattr Connected" || echo -e '\E[32m'"Internet: $resetattr Disconnected"

# Check OS Type
os=$(uname -o)
echo -e '\E[32m'"Operating System Type :" $resetattr $os

# Check OS Version
OSSTR=$(uname -s)
echo -e '\E[32m'"OS Version :" $resetattr $OSSTR 

# Check Architecture
architecture=$(uname -m)
echo -e '\E[32m'"Architecture :" $resetattr $architecture

# Check Kernel Release
kernelrelease=$(uname -r)
echo -e '\E[32m'"Kernel Release :" $resetattr $kernelrelease

# Check hostname
echo -e '\E[32m'"Hostname :" $resetattr $HOSTNAME

# Check Internal IP
internalip=$(ipconfig | awk '/IPv4/ {print}' | cut -d ':' -f 2)
echo -e '\E[32m'"Internal IP :" $resetattr $internalip

# Check External IP
externalip=$(curl -s ipecho.net/plain;echo)
echo -e '\E[32m'"External IP : $resetattr "$externalip
echo

# Check DNS
nameservers=$(nslookup google.com | awk '{print}')
echo -e '\E[32m'"Name Servers :" $resetattr $nameservers 
echo

echo -e '\E[32m'"Checking if the host is up.." $resetattr
declare -a name
read -p "Enter the Hostnames : " name
for i in ${name[@]}
do
ping -c 1 $i &> /dev/null

if [ $? -ne 0 ]; then
	echo "`date`: ping failed, $i host is down!"
else
	echo "`date`: ping successful, $i host is up!"
fi
done
echo
sleep 5

# Displaying IP Routing tables 
echo -e '\E[32m'"Displaying IPV4 Route Table :" $resetattr
route PRINT -4
echo
sleep 5

# Displaying IP Routing tables 
echo -e '\E[32m'"Displaying IPV6 Route Table :" $resetattr
route PRINT -6
echo
sleep 5

# Displaying Connection Information 
echo -e '\E[32m'"Displaying Connection Information :" $resetattr
netstat -a
echo
sleep 5

# Displaying ARP tables 
echo -e '\E[32m'"Displaying ARP Tables :" $resetattr
arp -a
echo
sleep 5

# Check System Uptime
sysuptime=$(systeminfo | awk '/Boot Time/ {print}')
echo -e '\E[32m'"System Uptime Days/(HH:MM) :" $resetattr $sysuptime
echo

echo "Commands unavailable in Git bash :"
echo
echo -e '\E[32m'"ifconfig" : $resetattr "Display and manipulate route and network interfaces." #ipconfig
echo -e '\E[32m'"ip" : $resetattr "It is a replacement of ifconfig command." #ipconfig
echo -e '\E[32m'"traceroute" : $resetattr "Network troubleshooting utility."
echo -e '\E[32m'"tracepath" : $resetattr "Similar to traceroute but doesn't require root privileges."
echo -e '\E[32m'"ss" : $resetattr "It is a replacement of netstat." #netstat
echo -e '\E[32m'"dig" : $resetattr "Query DNS related information." #curl
echo -e '\E[32m'"host" : $resetattr "Performs DNS lookups." #nslookup
echo -e '\E[32m'"iwconfig" : $resetattr "Used to configure wireless network interface." #ipconfig
echo -e '\E[32m'"wget" : $resetattr "To download a file from internet." #curl
echo -e '\E[32m'"mtr" : $resetattr "Combines ping and tracepath into a single command."
echo -e '\E[32m'"whois" : $resetattr "Will tell you about the website's whois."
echo -e '\E[32m'"ifplugstatus" : $resetattr "Tells whether a cable is plugged in or not."
echo

echo -e '\E[32m'"Scanning Network Subnet.." $resetattr
is_alive_ping()
{
  ping -c 1 $1 &> /dev/null
  [ $? -eq 0 ] && echo Node with IP: $i is up!
}

for i in 192.168.1.{1..255}
do
is_alive_ping $i & disown
done

# Unset Variables
unset resetattr os architecture kernelrelease internalip externalip nameserver

# Remove Temporary Files
}
fi

shift $(($OPTIND -1))