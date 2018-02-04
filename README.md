# yggtorrent.c.1h.sh
## Yggtorrent script for Argos (gnome-shell)

> THIS SCRIPT IS ONLY IN FRENCH

> CE SCRIPT EST UNIQUEMENT EN FRANÇAIS

**Fonction(s):**
- une mise à jout automatique est intégrée au script, inutile de vous en occuper
- récupérer et afficher les informations de votre compte YGGTORRENT (ratio, download, upload et crédits restants)
- vérification de l'URL actuelle du site (tentative de suivre l'URL si elle change)
- vérification de l'IP envoyée à ce site (un VPN protège t'il pour ce site précis)
- vérification de la présence de message(s) dans la messagerie du forum
- un système de message push est intégré (donc notifications sur les téléphones mobiles)

**Dépendances requises:**
- `sudo apt install yad`

**Installation facile:**

Il suffit simplement de copier/coller ça dans un terminal:

`wget -q https://raw.githubusercontent.com/scoony/yggtorrent.c.1h.sh/master/yggtorrent.c.1h.sh -O ~/.config/argos/yggtorrent.c.1h.sh && sed -i -e 's/\r//g' ~/.config/argos/yggtorrent.c.1h.sh && chmod +x ~/.config/argos/yggtorrent.c.1h.sh`

**Résultat:**
![ScreenShot](https://raw.githubusercontent.com/scoony/yggtorrent.c.1h.sh/master/.screenshots/Capture%20d%E2%80%99%C3%A9cran%20de%202018-02-04%2009-17-00.png)

![ScreenShot](https://raw.githubusercontent.com/scoony/yggtorrent.c.1h.sh/master/.screenshots/Capture%20d%E2%80%99%C3%A9cran%20de%202018-02-04%2009-17-36.png)
