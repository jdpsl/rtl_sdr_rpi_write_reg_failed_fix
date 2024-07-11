#!/bin/bash


if [[ "$EUID" -ne 0 ]]; then
  echo "[-] Please run this script as root."
  exit 1
fi

echo "[+] We are root


local blacklist_file="/etc/modprobe.d/blacklist-dvb.conf"

echo "[i] Creating blacklist file at $blacklist_file..."

echo "blacklist dvb_usb_rtl28xxu" >> "$blacklist_file"
echo "blacklist rtl2832" >> "$blacklist_file"
echo "blacklist rtl2830" >> "$blacklist_file"


if [[ ! -f "$blacklist_file" ]]; then
    echo "Blacklist file not found. Creating new file..."
    touch "$blacklist_file"
else
  echo "[+] Blacklist file created successfully."
  echo "[i] Please make sure all your work is saved."
  read -p "[?] Would you like to reboot now to apply changes? (y/n): " choice
      case "$choice" in
          y|Y ) 
              sudo reboot
              ;;
          n|N ) 
              echo "You must reboot for changed to take effect."
              ;;
          * ) 
              echo "Invalid option. Please answer y or n."
              prompt_reboot
              ;;
      esac

fi







create_blacklist
