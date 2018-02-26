 #!/bin/bash

 ## point to variable file for ipv4 and domain.com
 source <(grep '^ .*='  /opt/appdata/plexguide/var.sh)
 echo $ipv4
 echo $domain

 HEIGHT=14
 WIDTH=38
 CHOICE_HEIGHT=5
 BACKTITLE="Visit PlexGuide.com - Automations Made Simple"
 TITLE="Applications - Torrent Programs"

 OPTIONS=(A "RuTorrent"
          B "Deluge"
          C "Jackett"
          D "VPN Options"
          Z "Exit")

 CHOICE=$(dialog --backtitle "$BACKTITLE" \
                 --title "$TITLE" \
                 --menu "$MENU" \
                 $HEIGHT $WIDTH $CHOICE_HEIGHT \
                 "${OPTIONS[@]}" \
                 2>&1 >/dev/tty)

case $CHOICE in

     A)
       clear
       program=rutorrent
       port=8999
       ansible-playbook /opt/plexguide/ansible/plexguide.yml --tags rutorrent ;;

     B)
       clear
       program=deluge
       port=8112
       ansible-playbook /opt/plexguide/ansible/plexguide.yml --tags deluge ;;

     C)
       clear
       program=jackett
       port=9117
       ansible-playbook /opt/plexguide/ansible/plexguide.yml --tags jackett ;;

     D)
      clear
      bash /opt/plexguide/scripts/menus/programs/program-vpn.sh
      ;;

     Z)
      exit 0 ;;
esac

    clear

    dialog --title "$program - Address Info" \
    --msgbox "\nIPv4      - http://$ipv4:$port\nSubdomain - https://$program.$domain\nDomain    - http://$domain:$port" 8 50

#### recall itself to loop unless user exits
bash /opt/plexguide/menus/programs/torrent.sh
