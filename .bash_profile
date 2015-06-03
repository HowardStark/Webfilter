# Title: Webfilter Command
# Author: Howard Stark
# Usage: sudo webfilter [on/off]
alias webfilter=webfilter

#Please edit this line to the desired host
HOST=user@example.com

webfilter(){
    if [ "$EUID" -ne 0 ]
    then
        echo "Please run as root"
    fi
 
    if [ $1 == "on" ]
    then
        networksetup -setsocksfirewallproxystate "Wi-Fi" on
        networksetup -setsocksfirewallproxy "Wi-Fi" localhost 8080
        ssh -f -D 8080 -C -N $HOST
    elif [ $1 == "off" ]
    then
        kill `ps -ef | grep ssh | grep $HOST | awk '{print $2}'`
        networksetup -setsocksfirewallproxy "Wi-Fi" "" "" 
        networksetup -setsocksfirewallproxystate "Wi-Fi" off
    else
        echo "Usage: webfilter [on/off]"
    fi
}
