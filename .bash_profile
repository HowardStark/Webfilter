# Webfilter Command
# Author: Howard Stark
# Usage: sudo webfilter [on/off]
alias webfilter=webfilter

HOST=howard@winterflake.net
PORT=8080

webfilter(){
    if [ $1 == "on" ]
    then
        re='^[0-9]+$'
        if [[ $2 == -* ]]
        then
            if [[ $2 == *p* ]] && [[ -n $3 ]] && [[ $3 =~ $re ]]
            then
                PORT=$3
            elif [[ $2 == *p* ]] && [[ -z $3 ]]
            then
                echo "Usage: webfilter on -p <port>"
            elif [[ $2 == *p* ]] && ! [[ $3 =~ $re ]]
            then
                echo "Usage: webfilter on -p <port>"
            fi
        elif [[ -n $2 ]]
        then
            echo "Invalid Argument."
        fi
        networksetup -setsocksfirewallproxystate "Wi-Fi" on
        networksetup -setsocksfirewallproxy "Wi-Fi" localhost $PORT 
        ssh -f -D $PORT -C -N $HOST
    elif [ $1 == "off" ]
    then
        if [[ -n $2 ]]
        then
            echo "Too many arguments."
        fi
        kill `ps -ef | grep ssh | grep "ssh -f -D $PORT -C -N $HOST" | awk '{print $2}'`
        networksetup -setsocksfirewallproxy "Wi-Fi" "" ""
        networksetup -setsocksfirewallproxystate "Wi-Fi" off
    else
        echo "Usage: webfilter [on/off]"
    fi
}
