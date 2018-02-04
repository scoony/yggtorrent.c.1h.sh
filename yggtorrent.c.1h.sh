#!/usr/bin/env bash

version="0.0.0.6"

#### Nettoyage
## Ne fonctionne pas
if [[ -f "~/yggtorrent-update.sh" ]]; then
  rm $HOME/yggtorrent-update.sh
fi

#### Récupération des versions (locale et distante)
script_pastebin="https://raw.githubusercontent.com/scoony/yggtorrent.c.1h.sh/master/yggtorrent.c.1h.sh"
local_version=$version
pastebin_version=`wget -O- -q "$script_pastebin" | grep "^version=" | sed '/grep/d' | sed 's/.*version="//' | sed 's/".*//'`

#### Comparaison des version et mise à jour si nécessaire
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

#### Vérification du cache des icones (ou création)
icons_cache=`echo $HOME/.config/argos/.cache-icons`
if [[ ! -f "$icons_cache" ]]; then
  mkdir -p $icons_cache
fi
if [[ ! -f "$icons_cache/yggtorrent.png" ]] ; then curl -o "$icons_cache/yggtorrent.png" "https://raw.githubusercontent.com/scoony/yggtorrent.c.1h.sh/master/.cache-icons/yggtorrent.png" ; fi
if [[ ! -f "$icons_cache/yggtorrent-bad.png" ]] ; then curl -o "$icons_cache/yggtorrent-bad.png" "https://raw.githubusercontent.com/scoony/yggtorrent.c.1h.sh/master/.cache-icons/yggtorrent-bad.png" ; fi
if [[ ! -f "$icons_cache/settings.png" ]] ; then curl -o "$icons_cache/settings.png" "https://raw.githubusercontent.com/scoony/yggtorrent.c.1h.sh/master/.cache-icons/settings.png" ; fi
if [[ ! -f "$icons_cache/ratio.png" ]] ; then curl -o "$icons_cache/ratio.png" "https://raw.githubusercontent.com/scoony/yggtorrent.c.1h.sh/master/.cache-icons/ratio.png" ; fi
if [[ ! -f "$icons_cache/upload.png" ]] ; then curl -o "$icons_cache/upload.png" "https://raw.githubusercontent.com/scoony/yggtorrent.c.1h.sh/master/.cache-icons/upload.png" ; fi
if [[ ! -f "$icons_cache/download.png" ]] ; then curl -o "$icons_cache/download.png" "https://raw.githubusercontent.com/scoony/yggtorrent.c.1h.sh/master/.cache-icons/download.png" ; fi
if [[ ! -f "$icons_cache/credits.png" ]] ; then curl -o "$icons_cache/credits.png" "https://raw.githubusercontent.com/scoony/yggtorrent.c.1h.sh/master/.cache-icons/credits.png" ; fi
if [[ ! -f "$icons_cache/url.png" ]] ; then curl -o "$icons_cache/url.png" "https://raw.githubusercontent.com/scoony/yggtorrent.c.1h.sh/master/.cache-icons/url.png" ; fi
if [[ ! -f "$icons_cache/vpn.png" ]] ; then curl -o "$icons_cache/vpn.png" "https://raw.githubusercontent.com/scoony/yggtorrent.c.1h.sh/master/.cache-icons/vpn.png" ; fi
if [[ ! -f "$icons_cache/unprotected.png" ]] ; then curl -o "$icons_cache/unprotected.png" "https://raw.githubusercontent.com/scoony/yggtorrent.c.1h.sh/master/.cache-icons/unprotected.png" ; fi
if [[ ! -f "$icons_cache/message.png" ]] ; then curl -o "$icons_cache/message.png" "https://raw.githubusercontent.com/scoony/yggtorrent.c.1h.sh/master/.cache-icons/message.png" ; fi

#### Mise en variable des icones
YGGTORRENT_ICON=$(curl -s "file://$icons_cache/yggtorrent.png" | base64 -w 0)
YGGTORRENT_BAD_ICON=$(curl -s "file://$icons_cache/yggtorrent-bad.png" | base64 -w 0)
SETTINGS_ICON=$(curl -s "file://$icons_cache/settings.png" | base64 -w 0)
RATIO_ICON=$(curl -s "file://$icons_cache/ratio.png" | base64 -w 0)
UPLOAD_ICON=$(curl -s "file://$icons_cache/upload.png" | base64 -w 0)
DOWNLOAD_ICON=$(curl -s "file://$icons_cache/download.png" | base64 -w 0)
CREDITS_ICON=$(curl -s "file://$icons_cache/credits.png" | base64 -w 0)
URL_ICON=$(curl -s "file://$icons_cache/url.png" | base64 -w 0)
VPN_ICON=$(curl -s "file://$icons_cache/vpn.png" | base64 -w 0)
UNPROTECTED_ICON=$(curl -s "file://$icons_cache/unprotected.png" | base64 -w 0)
MESSAGE_ICON=$(curl -s "file://$icons_cache/message.png" | base64 -w 0)

#### Récupération des informations de YGG
ygg_login=`cat $HOME/.config/argos/.yggtorrent-account | awk '{print $1}' FS="§"`
ygg_password=`cat $HOME/.config/argos/.yggtorrent-account | awk '{print $2}' FS="§"`
website_main_url="https://yggtorrent.com"
forum_url="https://forum.yggtorrent.com"

#### Vérification de l'URL (en cas de changement)
if [[ ! -f "$HOME/.config/argos/yggtorrent/.website_url.conf" ]]; then
  echo $website_main_url > $HOME/.config/argos/yggtorrent/.website_url.conf
fi
website_url=`cat $HOME/.config/argos/yggtorrent/.website_url.conf`
current_url=`wget -q -O- "$website_url" | grep favicon | sed 's/.*href="//' | sed -n '1p' | sed 's/\/static.*//'`
if [[ "$website_url" != "$current_url" ]]; then
  sed -i 's/'$website_url'/'$current_url'/g' "$HOME/.config/argos/yggtorrent/.website_url.conf"
  website_url=`echo $current_url`
fi

#### Génération du cookie
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

#### Déclaration du système de méssages PUSH
## usage: push-message "title" "message"
push_system_status=`cat $HOME/.config/argos/.yggtorrent-account | awk '{print $5}' FS="§"`
token_app=`cat $HOME/.config/argos/.yggtorrent-account | awk '{print $6}' FS="§"`
destinataire_1=`cat $HOME/.config/argos/.yggtorrent-account | awk '{print $7}' FS="§"`
push-message() {
  push_title=$1
  push_content=$2
  zenity --notification --window-icon="$HOME/.config/argos/.cache-icons/yggtorrent-bad.png" --text "$push_content" 2>/dev/null
  for user in {1..10}; do
    destinataire=`eval echo "\\$destinataire_"$user`
    if [ -n "$destinataire" ]; then
      curl -s \
        --form-string "token=$token_app" \
        --form-string "user=$destinataire" \
        --form-string "title=$push_title" \
        --form-string "message=$push_content" \
        --form-string "html=1" \
        --form-string "priority=0" \
        https://api.pushover.net/1/messages.json > /dev/null
    fi
  done
}

#### Récupération des détails du compte
wget -q --load-cookies=$HOME/.config/argos/yggtorrent/cookies.txt "$website_url" -O $HOME/.config/argos/yggtorrent/page.html
mon_ratio=`cat $HOME/.config/argos/yggtorrent/page.html | grep Ratio | sed 's/.*Ratio \: //' | sed 's/<\/a>.*//'`
if [[ "$mon_ratio" != "" ]]; then
  mon_upload=`cat $HOME/.config/argos/yggtorrent/page.html | grep fa-arrow-up | sed 's/.*;">//' | sed 's/<\/span>.*//' | sed 's/ //g'`
  mon_download=`cat $HOME/.config/argos/yggtorrent/page.html | grep fa-arrow-down | sed 's/.*;">//' | sed 's/<\/span>.*//' | sed 's/ //g'`
  mon_upload_detail=`dehumanise $mon_upload`
  mon_download_detail=`dehumanise $mon_download`
  mon_credit=$(($mon_upload_detail-$mon_download_detail))
  mon_credit_clair=`humanise $mon_credit`
fi
 
#### Récupération de l'avatar du membre
wget -q --load-cookies=$HOME/.config/argos/yggtorrent/cookies.txt "$website_url/user/account" -O $HOME/.config/argos/yggtorrent/page_account.html
avatar_url=`cat $HOME/.config/argos/yggtorrent/page_account.html | grep "/files/avatars/" | grep -oP 'http.?://\S+' | sed 's/"//'`
IMAGE=$(curl -s "$avatar_url" | base64 -w 0)

#### Vérification que notre IP est masquée pour ce site
vpn_domain=$(echo $website_url | sed 's/^http:\/\/www\.//' | sed 's/^https:\/\/www\.//' | sed 's/^http:\/\///' | sed 's/^https:\/\///')
vpn_ip_check=`ip route get $(host $vpn_domain | sed -n '1p' | awk '{print $4}') | awk '{print $5}' | sed -n '1p'`
if [[ "$vpn_ip_check" == "tun0" ]]; then
  ip_status="masquée par VPN"
  ip_status_icon=$VPN_ICON
else
  ip_status="non protégée"
  ip_status_icon=$UNPROTECTED_ICON
fi

#### Récupération de données sur le forum
forum_login_page=`echo $forum_url"/index.php?app=core&module=global&section=login&do=process"`
forum_login=`cat $HOME/.config/argos/.yggtorrent-account | awk '{print $3}' FS="§"`
forum_password=`cat $HOME/.config/argos/.yggtorrent-account | awk '{print $4}' FS="§"`
wget -q "$forum_url" -O "$HOME/.config/argos/yggtorrent/forum_page_key.html"
forum_auth_key=`cat $HOME/.config/argos/yggtorrent/forum_page_key.html | grep "auth_key" | sed '/grep/d' | sed -n '1p' | grep -Po "(?<=value=')[^']*"`
wget -q --save-cookies $HOME/.config/argos/yggtorrent/forum_cookies.txt --keep-session-cookies --post-data="auth_key=$forum_auth_key&referer=http%3A%2F%2Fforum.yggtorrent.com%2Findex.php&ips_username=$forum_login&ips_password=$forum_password&rememberMe=1" "$forum_login_page"
wget -q --load-cookies=$HOME/.config/argos/yggtorrent/forum_cookies.txt "$forum_url" -O $HOME/.config/argos/yggtorrent/forum_page.html
get_message_amount=`cat $HOME/.config/argos/yggtorrent/forum_page.html | grep "getInboxList" | sed '/grep/d' | grep -Po "(?<=ipsHasNotifications'>)[^<]*"`
if [[ "$get_message_amount" == "" ]]; then
  get_message_amount="0"
fi

#### Préparation des paramètres
account_infos=`echo -e "yad --width=\"600\" --height=\"300\" --center --window-icon=\"$HOME/.config/argos/.cache-icons/yggtorrent-big.png\" --title=\"Authentification du compte\" --text=\"<big>\r\rVeuillez entrer vos informations de compte(s).\rCes informations ne sont pas stockées sur internet.\r\r</big>\" --text-align=center --image=\"$HOME/.config/argos/.cache-icons/yggtorrent-big.png\" --form --separator=\"§\" --field=\"Identifiant du site\" --field=\"Mot de passe du site\" --field=\"Identifiant du forum\" --field=\"Mot de passe du forum\" --field=\"Activer les notification PushOver:CHK\" --field=\"API KEY\" --field=\"USER_KEY\" \"$ygg_login\" \"$ygg_password\" \"$forum_login\" \"$forum_password\" \"$push_system_status\" \"$token_app\" \"$destinataire_1\" --button=gtk-ok:0 2>/dev/null >~/.config/argos/.yggtorrent-account"`

#### On affice le résultat
echo " $mon_credit_clair | image='$YGGTORRENT_ICON' imageWidth=25"
echo "---"
printf "%19s | ansi=true font='Ubuntu Mono' trim=false size=20 href=$website_url terminal=false image=$IMAGE imageWidth=80 \n" "$ygg_login"
echo "---"
printf "%-2s \e[1m%-20s\e[0m : %s | image='%s' imageWidth=18 ansi=true font='Ubuntu Mono' trim=false \n" "" "Ratio" "$mon_ratio" "$RATIO_ICON"
printf "%-2s \e[1m%-20s\e[0m : %s | image='%s' imageWidth=18 ansi=true font='Ubuntu Mono' trim=false \n" "" "Upload" "$mon_upload" "$UPLOAD_ICON"
printf "%-2s \e[1m%-20s\e[0m : %s | image='%s' imageWidth=18 ansi=true font='Ubuntu Mono' trim=false \n" "" "Download" "$mon_download" "$DOWNLOAD_ICON"
printf "%-2s \e[1m%-20s\e[0m : %s | image='%s' imageWidth=18 ansi=true font='Ubuntu Mono' trim=false \n" "" "Credits restants" "$mon_credit_clair" "$CREDITS_ICON"
echo "---"
printf "%-2s \e[1m%-20s\e[0m : %s | image='%s' imageWidth=18 ansi=true font='Ubuntu Mono' trim=false \n" "" "URL actuelle" "$website_url" "$URL_ICON"
printf "%-2s \e[1m%-20s\e[0m : %s | image='%s' imageWidth=18 ansi=true font='Ubuntu Mono' trim=false \n" "" "Status de l'IP" "$ip_status" "$ip_status_icon"
if [[ "$forum_login" != "" ]] && [[ "$forum_password" != "" ]]; then
  printf "%-2s \e[1m%-20s\e[0m : %s | image='%s' imageWidth=18 ansi=true font='Ubuntu Mono' trim=false \n" "" "Messagerie Forum" "$get_message_amount message(s) non-lu(s)" "$MESSAGE_ICON"
fi
echo "---"
printf "%-2s %s | image='$SETTINGS_ICON' imageWidth=18 ansi=true font='Ubuntu Mono' trim=false bash='$account_infos' terminal=false \n" "" "Paramètres de l'extension"
