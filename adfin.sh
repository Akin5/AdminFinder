#!/usr/bin/env bash


# Colors
r='\e[91m'
g='\e[92m'
y='\e[93m'
b='\e[94m'
p='\e[95m'
c='\e[96m'
w='\e[97m'
n='\e[0m'
# effect colors
bd='\e[1m'
dm='\e[2m'
it='\e[3m'
ul='\e[4m'
rv='\e[7m'

colors=( "${bd}${r}" "${bd}${g}" "${bd}${y}" "${bd}${b}" "${bd}${p}" "${bd}${c}")

thread=1
count=1

check(){
    command -v tput > /dev/null 2>&1 ||
    {
        apt install ncurses-util ||
        {
            echo -e "Please check your connecting!";
            exit;
        }
    }
    command -v curl > /dev/null 2>&1 ||
    {
        
        apt install lynx > /dev/null 2>&1 ||
        {
            echo -e "Please check your connecting!";
            exit;
        }
    }
    apt install grep > /dev/null 2>&1 ||
    {
        echo -e "Please check your connecting!";
        exit
    }
}

banner() {
    rand1=$( shuf -i 0-${#colors[@]} -n 1 )
    rand2=$( shuf -i 0-${#colors[@]} -n 1 )
    echo -e "\t${colors[rand1]}  _____   _       _     ${colors[rand2]}   _____ _       _"${n}
    echo -e "\t${colors[rand1]} |  _  |_| |_____|_|___ ${colors[rand2]}  |   __|_|___ _| |___ ___"${n}
    echo -e "\t${colors[rand1]} |     | . |     | |   |${colors[rand2]}  |   __| |   | . | -_|  _|"${n}
    echo -e "\t${colors[rand1]} |__|__|___|_|_|_|_|_|_|${colors[rand2]}  |__|  |_|_|_|___|___|_|"${n}
    echo -e "\t${bd}${r}--------------------------------------------------${n}"
    echo -e "\t${bd}${g}|${w}       Author  ${b}:${c} ${ul}4K17${n}                           ${g}|${n}"
    echo -e "\t${bd}${g}|${w}       Code    ${b}:${w} Bash                           ${g}|${n}"
    echo -e "\t${bd}${g}|${w}       Team    ${b}:${w} IndoSec, Black coder crush     ${g}|${n}"
    echo -e "\t${bd}${g}|${w}       Date    ${b}:${w} 13 - 5 - 2019                  ${g}|${n}"
    echo -e "\t${bd}${g}|${w}       Version ${b}:${w} 1.0                            ${g}|${n}"
    echo -e "\t${bd}${r}--------------------------------------------------${n}"
}

scan() {
    web=${1}
    path="${2}"
    scan_web=$( curl -s -o /dev/null ${web}/${path} -w %{http_code} )
    if [[ $scan_web = 200 ]] || [[ $scan_web = 201 ]]; then
        printf "\n"
        echo -e "${g}[${w}+${g}] ${w}${web}/${path} ${y}~> ${g}${scan_web}${n}"
        printf "\n"
    else
        echo -e "${g}[${r}-${g}] ${w}${web}/${path} ${b}~> ${r}${scan_web}${n}"
    fi
}

# start
clear
check
banner
echo -ne "\t${c}[${w}?${c}] ${w}Enter your website ${g}:${n} "
read web
if [[ -z $web ]]; then
    
    printf "\n"
    echo -e "${b}[${r}!${b}]${w} Website tidak boleh kosong !!"
    exit
fi
echo -ne "${c}[${w}?${c}] ${w}Enter your wordlist ${g}(${w}Default${g}:${w} wordlist.txt${g}) ${g}:${n} "
read wordlist
printf "\n"
web=$( echo ${web} | cut -d '/' -f 3 )
wordlist=${wordlist:-wordlist.txt}
if ! [[ -e $wordlist ]]; then
    printf "\n"
    echo -e "${b}[${r}!${b}]${w} List not found !!"
    exit
fi
echo -e "\t${g}[${w}+${g}]${w} Total Wordlist ${g}:${w} $( wc -l $wordlist | cut -d ' ' -f 1 )"
echo -ne "\t${g}[${w}+${g}]${w} Start Scanning${n}"
for (( TiTik = 1; TiTik <= 10; TiTik++ )); do
    printf '.'
    sleep 0.2
done
printf "\n\n"
for list in $( cat $wordlist ); do
    if [[ $(( $thread % $count )) = 0 && $count > 0 ]]; then
        sleep 1
    fi
    scan "${web}" "${list}" &
    (( count++ ))
done
wait
