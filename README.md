# yggtorrent.c.1h.sh
## Yggtorrent script for Argos (gnome-shell)

> THIS SCRIPT IS ONLY IN FRENCH

> CE SCRIPT EST UNIQUEMENT EN FRANÇAIS

## **IMPORTANT:**

[<img src="https://github.com/scoony/yggtorrent.c.1h.sh/blob/master/.cache-icons/extensions-gnome.png">](https://extensions.gnome.org/extension/1176/argos/) 
[<img src="https://github.com/scoony/yggtorrent.c.1h.sh/blob/master/.cache-icons/pushover.png">](https://pushover.net/)

+ Ce script exploite Argos, vous devez imperativement l'avoir installé préalablement.
  - Page officielle de l'extension à installer: https://extensions.gnome.org/extension/1176/argos/
  - GitHub officiel de Argos: https://github.com/p-e-w/argos
+ Les notifications push de ce scripts utilisent le système PushOver
  - Page officielle de PushOver: https://pushover.net/
  - Lien vers la boutique Android: https://play.google.com/store/apps/details?id=net.superblock.pushover
  - Lien vers la boutique Apple: https://itunes.apple.com/us/app/pushover-notifications/id506088175

**Fonction(s):**
- une mise à jour automatique est intégrée au script, inutile de vous en occuper
- récupérer et afficher les informations de votre compte YGGTORRENT (ratio, download, upload et crédits restants)
- vérification de l'URL actuelle du site (tentative de suivre l'URL si elle change)
- vérification de l'IP envoyée à ce site (un VPN protège t'il pour ce site précis)
- vérification de la présence de message(s) dans la messagerie du forum
- un système de message push est intégré (donc notifications sur les téléphones mobiles)

**Dépendances requises:**
- `sudo apt-get install yad`
- `sudo apt-get install curl`
- `sudo apt-get install gawk`

**Installation facile:**

Il suffit simplement de copier/coller ça dans un terminal:

`wget -q https://raw.githubusercontent.com/scoony/yggtorrent.c.1h.sh/master/yggtorrent.c.1h.sh -O ~/.config/argos/yggtorrent.c.1h.sh && sed -i -e 's/\r//g' ~/.config/argos/yggtorrent.c.1h.sh && chmod +x ~/.config/argos/yggtorrent.c.1h.sh`

**Résultat:**
![ScreenShot](https://raw.githubusercontent.com/scoony/yggtorrent.c.1h.sh/master/.screenshots/Capture%20d’écran%20de%202018-02-17%2006-30-15.png)

![ScreenShot](https://raw.githubusercontent.com/scoony/yggtorrent.c.1h.sh/master/.screenshots/Capture%20d’écran%20de%202018-02-17%2006-31-15.png)
