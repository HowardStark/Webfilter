# Webfilter Command 
# Author: Howard Stark 
# Usage: webfilter [on/off] 

alias webfilter=webfilter

ERROR="ERROR:"
WHOAMI=`whoami`
HOSTFILE=/Users/$WHOAMI/.webfilter
PORT=8080

webfilter() {
    
    if [[ $1 == "on" ]]
    then
        
        if [[ -z HOST=`cat $HOSTFILE` ]]
        then
            echo "$HOST"
            echo "Example: username@server.com"
            echo "Please enter your proxy details:"
            while [[ true ]]
            do
                read input_variable
                if [[ $input_variable == *@* ]]
                then
                    HOST=$input_variable
                    echo $HOST > $HOSTFILE
                    break;
                else
                    echo "$ERROR Proxy details not valid."
                    echo "Please enter your proxy details:"
                fi
            done
        fi

        for (( i=1; i<=$#; i++ )) 
        do
            re='^[0-9]+$'
            if [[ ${!i} == -p ]]
            then
                i++
                if [[ -n ${!i} ]] && [[ ${!i} =~ $re ]]
                then
                    PORT=${!i}
                    echo $PORT
                else
                    echo "Usage: leol"
                fi
            elif
            then
                
            fi
        done

        #re='^[0-9]+$'
        #if [[ $2 == -* ]]
        #then
        #    if [[ $2 == *p* ]] && [[ -n $3 ]] && [[ $3 =~ $re ]]
        #    then
        #        PORT=$3
        #    elif [[ $2 == *p* ]] && [[ -z $3 ]]
        #    then
        #        echo "Usage: webfilter on -p <port>"
        #        return
        #    elif [[ $2 == *p* ]] && ! [[ $3 =~ $re ]]
        #    then
        #        echo "Usage: webfilter on -p <port>"
        #        return
        #    fi
        #elif [[ -n $2 ]]
        #then
        #    echo "Invalid Argument."
        #    return
        #fi
        networksetup -setsocksfirewallproxystate "Wi-Fi" on
        networksetup -setsocksfirewallproxy "Wi-Fi" localhost $PORT 
        ssh -f -D $PORT -C -N $HOST
    elif [[ $1 == "off" ]]
    then
        if [[ -n $2 ]]
        then
            echo "Too many arguments."
            return
        fi
        kill `ps -ef | grep ssh | grep "ssh -f -D $PORT -C -N $HOST" | awk '{print $2}'` 2> /dev/null
        networksetup -setsocksfirewallproxy "Wi-Fi" "" ""
        networksetup -setsocksfirewallproxystate "Wi-Fi" off
    else
        echo "Usage: webfilter [on/off]"
        return
    fi
}
