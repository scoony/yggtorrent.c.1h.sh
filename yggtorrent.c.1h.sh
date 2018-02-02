#!/usr/bin/env bash

#### Version: 0.0.0.2

ygg_login=""
ygg_password=""
website_url="https://yggtorrent.com"

#### Generating cookie
website_login_page=`echo $website_url"/user/login"`
wget -q --save-cookies cookies.txt --keep-session-cookies --post-data="id=$ygg_login&pass=$ygg_password" "$website_login_page"
rm -f login 2>/dev/null

#### Getting my account details
wget -q --load-cookies=cookies.txt "$website_url" -O page.html
mon_ratio=`cat page.html | grep Ratio | sed 's/.*Ratio \: //' | sed 's/<\/a>.*//'`
mon_upload=`cat page.html | grep fa-arrow-up | sed 's/.*;">//' | sed 's/<\/span>.*//' | sed 's/ //g'`
mon_download=`cat page.html | grep fa-arrow-down | sed 's/.*;">//' | sed 's/<\/span>.*//' | sed 's/ //g'`
mon_upload_detail=`humanfriendly --parse-size="$mon_upload"`
mon_download_detail=`humanfriendly --parse-size="$mon_download"`
mon_credit=$(($mon_upload_detail-$mon_download_detail))

humanise() {
    b=${1:-0}; d=''; s=0; S=(Bytes {K,M,G,T,E,P,Y,Z}o)
    while ((b > 1024)); do
        d="$(printf ".%02d" $((b % 1000 * 100 / 1000)))"
        b=$((b / 1000))
        let s++
    done
    echo "$b$d ${S[$s]}"
}
mon_credit_clair=`humanise $mon_credit`
 
#### Get my avatar
wget -q --load-cookies=cookies.txt "$website_url/user/account" -O page_account.html
avatar_url=`cat page_account.html | grep "/files/avatars/" | grep -oP 'http.?://\S+' | sed 's/"//'`
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
echo "Mon Crédit    : $mon_credit_clair | ansi=true font=monospace trim=false"
