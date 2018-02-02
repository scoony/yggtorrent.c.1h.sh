#!/usr/bin/env bash

version="0.0.0.0"

#### Nettoyage
## Ne fonctionne pas
if [[ -f "~/yggtorrent-update.sh" ]]; then
  rm $HOME/yggtorrent-update.sh
fi

#### Récupération des versions (locale et distante
script_pastebin="https://raw.githubusercontent.com/scoony/yggtorrent.c.1h.sh/master/yggtorrent.c.1h.sh"
local_version=$version
pastebin_version=`wget -O- -q "$script_pastebin" | grep "^version=" | sed '/grep/d' | sed 's/.*version="//' | sed 's/".*//'`

#### Comparing versions and updating if required
vercomp () {
    if [[ $1 == $2 ]]
    then
        return 0
    fi
    local IFS=.
    local i ver1=($1) ver2=($2)
    for ((i=${#ver1[@]}; i<${#ver2[@]}; i++))
    do
        ver1[i]=0
    done
    for ((i=0; i<${#ver1[@]}; i++))
    do
        if [[ -z ${ver2[i]} ]]
        then
            ver2[i]=0
        fi
        if ((10#${ver1[i]} > 10#${ver2[i]}))
        then
            return 1
        fi
        if ((10#${ver1[i]} < 10#${ver2[i]}))
        then
            return 2
        fi
    done
    return 0
}
testvercomp () {
    vercomp $1 $2
    case $? in
        0) op='=';;
        1) op='>';;
        2) op='<';;
    esac
    if [[ $op != $3 ]]
    then
        echo "FAIL: Expected '$3', Actual '$op', Arg1 '$1', Arg2 '$2'"
    else
        echo "Pass: '$1 $op $2'"
    fi
}
compare=`testvercomp $local_version $pastebin_version '<' | grep Pass`
if [[ "$compare" != "" ]] ; then
  update_required="Mise à jour disponible"
  (
  echo "# Creation de l'updater." ; sleep 2
  touch ~/yggtorrent-update.sh
  echo "25"
  echo "# Chmod de l'updater." ; sleep 2
  chmod +x ~/yggtorrent-update.sh
  echo "50"
  echo "# Edition de l'updater." ; sleep 2
  echo "#!/bin/bash" > ~/yggtorrent-update.sh
  echo "(" >> ~/yggtorrent-update.sh
  echo "echo \"75\"" >> ~/yggtorrent-update.sh
  echo "echo \"# Mise à jour en cours.\" ; sleep 2" >> ~/yggtorrent-update.sh
  echo "curl -o ~/.config/argos/yggtorrent.c.1h.sh $script_pastebin" >> ~/yggtorrent-update.sh
  echo "sed -i -e 's/\r//g' ~/.config/argos/yggtorrent.c.1h.sh" >> ~/yggtorrent-update.sh
  echo "echo \"100\"" >> ~/yggtorrent-update.sh
  echo ") |" >> ~/yggtorrent-update.sh
  echo "zenity --progress \\" >> ~/yggtorrent-update.sh
  echo "  --title=\"Mise à jour de YGGTorrent\" \\" >> ~/yggtorrent-update.sh
  echo "  --text=\"Démarrage du processus.\" \\" >> ~/yggtorrent-update.sh
  echo "  --percentage=0 \\" >> ~/yggtorrent-update.sh
  echo "  --auto-close \\" >> ~/yggtorrent-update.sh
  echo "  --auto-kill" >> ~/yggtorrent-update.sh
  echo "75"
  echo "# Lancement de l'updater." ; sleep 2
  bash ~/yggtorrent-update.sh
  exit 1
) |
zenity --progress \
  --title="Mise à jour de YGGTorrent" \
  --text="Démarrage du processus." \
  --percentage=0 \
  --auto-close \
  --auto-kill
fi

ygg_login=""
ygg_password=""
website_url="https://yggtorrent.com"

#### Generating cookie
website_login_page=`echo $website_url"/user/login"`
wget -q --save-cookies $HOME/.config/argos/yggtorrent/cookies.txt --keep-session-cookies --post-data="id=$ygg_login&pass=$ygg_password" "$website_login_page"
rm -f login 2>/dev/null

#### Fonction: dehumanize
dehumanise() {
  for v in "$@"
  do  
    echo $v | awk \
      'BEGIN{IGNORECASE = 1}
       function printpower(n,b,p) {printf "%u\n", n*b^p; next}
       /[0-9]$/{print $1;next};
       /K(iB)?$/{printpower($1,  2, 10)};
       /M(iB)?$/{printpower($1,  2, 20)};
       /G(iB)?$/{printpower($1,  2, 30)};
       /T(iB)?$/{printpower($1,  2, 40)};
       /KB$/{    printpower($1, 10,  3)};
       /MB$/{    printpower($1, 10,  6)};
       /GB$/{    printpower($1, 10,  9)};
       /TB$/{    printpower($1, 10, 12)}'
  done
}

#### Fonction: humanize
humanise() {
    b=${1:-0}; d=''; s=0; S=(Bytes {K,M,G,T,E,P,Y,Z}o)
    while ((b > 1024)); do
        d="$(printf ".%02d" $((b % 1000 * 100 / 1000)))"
        b=$((b / 1000))
        let s++
    done
    echo "$b$d ${S[$s]}"
}

#### Getting my account details
wget -q --load-cookies=$HOME/.config/argos/yggtorrent/cookies.txt "$website_url" -O $HOME/.config/argos/yggtorrent/page.html
mon_ratio=`cat $HOME/.config/argos/yggtorrent/page.html | grep Ratio | sed 's/.*Ratio \: //' | sed 's/<\/a>.*//'`
mon_upload=`cat $HOME/.config/argos/yggtorrent/page.html | grep fa-arrow-up | sed 's/.*;">//' | sed 's/<\/span>.*//' | sed 's/ //g'`
mon_download=`cat $HOME/.config/argos/yggtorrent/page.html | grep fa-arrow-down | sed 's/.*;">//' | sed 's/<\/span>.*//' | sed 's/ //g'`
mon_upload_detail=`dehumanise $mon_upload`
mon_download_detail=`dehumanise $mon_download`
mon_credit=$(($mon_upload_detail-$mon_download_detail))


mon_credit_clair=`humanise $mon_credit`
 
#### Get my avatar
wget -q --load-cookies=$HOME/.config/argos/yggtorrent/cookies.txt "$website_url/user/account" -O $HOME/.config/argos/yggtorrent/page_account.html
avatar_url=`cat $HOME/.config/argos/yggtorrent/page_account.html | grep "/files/avatars/" | grep -oP 'http.?://\S+' | sed 's/"//'`
IMAGE=$(curl -s "$avatar_url" | base64 -w 0)
 
#### Get YGG icon
YGG_ICON=$(curl -s "https://yggtorrent.com/static/images/favicon-32x32.png" | base64 -w 0)

#### Let's display the result
echo " $mon_credit_clair | image='$YGG_ICON' imageWidth=32"
echo "---"
echo "$ygg_login | href=$website_url terminal=false image=$IMAGE imageWidth=80"
echo "---"
echo "Mon Ratio     : $mon_ratio | ansi=true font=monospace trim=false"
echo "Mon Upload    : $mon_upload | ansi=true font=monospace trim=false"
echo "Mon Download  : $mon_download | ansi=true font=monospace trim=false"
echo 
echo "Mon Crédit    : $mon_credit_clair | ansi=true font=monospace trim=false"
