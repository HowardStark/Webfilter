# Webfilter Command 
# Author: Howard Stark 
# Usage: webfilter [on/off] 
alias webfilter=webfilter

WHOAMI=`whoami`
HOSTFILE=/Users/$WHOAMI/.webfilter
PORT=`sed '2q;d' $HOSTFILE`
HOST=`sed '1q;d' $HOSTFILE`
underline=`tput smul`
nounderline=`tput rmul`
bold=`tput bold`
normal=`tput sgr0`
ERROR="${bold}${underline}ERROR:${normal}${nounderline}"

if [[ $1 == "on" ]]
then
    if [[ -z $HOST ]]
    then
        echo "Example: username@server.com"
        echo "Please enter your proxy details:"
        while [[ true ]]
        do
            read input_variable
            if [[ $input_variable == *@* ]]
            then
                HOST=$input_variable
                sed '1 s/\*/$HOST' $HOSTFILE
                break;
            else
                echo "$ERROR Proxy details not valid."
                echo "Please enter your proxy details:"
            fi
        done
    fi

    if [[ -z $PORT ]]
    then
	    PORT=8080
	    sed '2 s/\*/$PORT' $HOSTFILE
    fi

    if [[ -z `ps -ef | grep ssh | grep "ssh -f -D $PORT -C -N $HOST"` ]]
    then
	    echo "$ERROR webfilter instance already running. Please run \'webfilter off\' before continuing." 
	    exit 0
    fi
    
    for (( i=1; i<=$#; i++ )) 
    do
        re='^[0-9]+$'
        if [[ ${!i} == -p ]]
        then
            let "i++"
            if [[ -n ${!i} ]] && [[ ${!i} =~ $re ]]
            then
                PORT=${!i}
	            sed '2 s/\*/$PORT' $HOSTFILE
            else
                echo "Usage: webfilter on -p <PORT NUMBER>"
        	    return
            fi
        elif [[ ${!i} == -h ]]
        then
	        let "i++"
	        if [[ -n ${!i} ]] && [[ ${!i} == *@* ]]
	        then
		        HOST=${!i}
		        echo $HOST
		        sed '1 s/\*/$HOST' $HOSTFILE
	        else
		        echo "Usage: webfilter on -h <HOST>"
		        return
	        fi
        fi
    done
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
elif [[ $1 == "--help" ]]
then
	echo "${bold}TITLE:${normal}"
	echo "        Webfilter"
	echo ""
	echo "${bold}AUTHOR:${normal}"
	echo "        Howard Stark"
	echo ""
	echo "${bold}SYNOPSIS:${normal}"
	echo "        webfilter on | off | --help [-p ${underline}port${nounderline}] [-h ${underline}host${nounderline}]"
	echo ""
	echo "${bold}OPTIONS:${normal}"
	echo "        -h ${underline}host${nounderline}"
	echo "                Change host that webfilter uses. See also: ${underline}.webfilter${nounderline} line 1"
	echo "        -p ${underline}port${nounderline}"
	echo "                Change port that webfilter uses. See also: ${underline}.webfilter${nounderline} line 2"
	echo "        .webfilter"
	echo "                File is written to ~/.webfilter. Line 1 contains host that webfilter reads from, line 2 contains port"
else
    echo "Usage: webfilter [on/off]"
    return
fi
