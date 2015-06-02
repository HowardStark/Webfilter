# Title: Webfilter Command
# Author: Howard Stark
# Usage: sudo webfilter [on/off]
alias webfilter=webfilter

webfilter(){
    if [ "$EUID" -ne 0 ]
    then
        echo "Please run as root"
    fi
 
    if [ $1 == "on" ]
    then
        networksetup -setsocksfirewallproxy "Wi-Fi" localhost 8080; ssh -D 8080 -C -N user@example.com
    elif [ $1 == "off" ]
    then
        networksetup -setsocksfirewallproxy "Wi-Fi" "" ""; networksetup -setsocksfirewallproxystate "Wi-Fi" off
    else
        echo "Usage: webfilter [on/off]"
    fi
}
