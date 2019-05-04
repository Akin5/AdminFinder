#!/usr/bin/env bash
set -euo pipefail
# Dfv47@Mfth'Daffa Gans
# Black Coder Crush

# colors
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

thread=1
count=1
jeda=1

check(){
	command -v tput > /dev/null 2>&1 ||
		{
			apt install ncurees-util ||
				{
					echo -e "Please check your connecting!";
					exit;
				}
		}
	command -v lynx > /dev/null 2>&1 ||
		{
			{
				apt install lynx > /dev/null 2>&1 ||
					{
						echo -e "Please check your connecting!";
						exit;
					}
			}
	}
apt install grep > /dev/null 2>&1 ||
	{
		echo -e "Please check your connecting!";
		exit
	}
}

banner(){
	printf "\n"
	echo -e "${g}[${w}+${g}]${b} ================================ ${g}[${w}+${g}]${n}"
	echo -e "${g}[${w}+${g}]${w}            ${r}Admin ${w}Finder          ${g}[${w}+${g}]${n}"
	echo -e "${g}[${w}+${g}]${w}  Author ${g}:${w} Dfv47 ft 4K17          ${g}[${w}+${g}]${n}"
	echo -e "${g}[${w}+${g}]${w}  Code ${g}:${w} Bash                     ${g}[${w}+${g}]${n}"
	echo -e "${g}[${w}+${g}]${w}  Team ${g}:${w} Black coder crush        ${g}[${w}+${g}]${n}"
	echo -e "${g}[${w}+${g}]${w}                                  ${g}[${w}+${g}]${n}"
	echo -e "${g}[${w}+${g}]${c}  ${ul}All member black coder crush${n}    ${g}[${w}+${g}]${n}"
	echo -e "${g}[${w}+${g}]${b} ================================ ${g}[${w}+${g}]${n}"
	printf "\n"
}

scan() {
	web=$( echo ${1} | cut -d '/' -f 3 )
	path="${2}"
	# fc=$(lynx -head -dump "$urls/$x" | grep -n "1" | cut -d "8" -f1 | cut -d "6" -f3 | cut -d "9" -f6 | cut -d "5" -f1 | tr -d "4" | grep --text "1:.*" | awk '/:/{print $2}')
	scan_web=$( curl -s -o /dev/null ${web}/${path} -w %{http_code} )
	if [[ $scan_web = 200 ]] || [[ $scan_web = 201 ]]; then
		echo -e "${g}[ ${w}STATUS ${g}] ${w}${web}/${path} ${y}~> ${g}${scan_web}${n}"
	else
		echo -e "${g}[ ${w}STATUS ${g}] ${w}${web}/${path} ${b}~> ${r}${scan_web}${n}"
	fi
}

# start
clear
check
banner
echo -ne "${c}[${w}?${c}] ${w}Enter your website ${g}:${n} "
read web
echo -ne "${c}[${w}?${c}] ${w}Enter your wordlist ${g}(${w}Default${g}:${w} wordlist.txt${g}) ${g}:${n} "
read wordlist
printf "\n"
wordlist=${wordlist:-wordlist.txt}
if ! [[ -e $wordlist ]]; then
	printf "\n"
	echo -e "${b}[${r}!${b}]${w} List not found !!"
	exit
fi
for list in $( cat $wordlist ); do
	if [[ $(( $thread % $count )) = 0 && $count > 0 ]]; then
		sleep $jeda
	fi
	scan "${web}" "${list}" &
	(( count++ ))
done
wait