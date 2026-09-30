#!/usr/bin/env bash

clear

GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${CYAN}==================================================${NC}"
echo -e "${GREEN}  _   _ _____ _______        _____  _____ ___ "
echo -e " | \ | | ____|_   _\ \      / / _ \|  _  |_  /"
echo -e " |  \| |  _|   | |  \ \ /\ / / | | | |_) |__/ "
echo -e " | |\  | |___  | |   \ V  V /| |_| |  _ <|  \ "
echo -e " |_| \_|_____| |_|    \_/\_/  \___/|_| \_\___\/${NC}"
echo -e ""
echo -e "${YELLOW}           [+] WIRELESS FIXER & RESET TOOL [+]${NC}"
echo -e "${CYAN}==================================================${NC}"
echo ""

if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Error: Root privileges required.${NC}"
  echo -e "${YELLOW}Run with: sudo $0${NC}"
  echo ""
  exit 1
fi

echo -e "${YELLOW}[*] Starting network reset...${NC}"
sleep 1

echo -e "\n${CYAN}[1/4] Stopping interface...${NC}"
echo -e "[...] Bringing wlan0 down"
ip link set wlan0 down
sleep 1.5
echo -e "${GREEN}[+] wlan0 stopped.${NC}"

echo -e "\n${CYAN}[2/4] Resetting interface mode...${NC}"
echo -e "[...] Switching wlan0 to managed mode"
iw dev wlan0 set type managed
sleep 1
echo -e "${GREEN}[+] Mode reset to managed.${NC}"

echo -e "\n${CYAN}[3/4] Starting interface...${NC}"
echo -e "[...] Bringing wlan0 up"
ip link set wlan0 up
sleep 1.5
echo -e "${GREEN}[+] wlan0 is back up.${NC}"

echo -e "\n${CYAN}[4/4] Restarting services...${NC}"
echo -e "[...] Restarting NetworkManager daemon"
systemctl restart NetworkManager
sleep 2
echo -e "${GREEN}[+] Service restarted.${NC}"

echo ""
echo -e "${CYAN}==================================================${NC}"
echo -e "${GREEN}[+] Done. Wireless stack successfully reset.${NC}"
echo -e "${YELLOW}[*] NetworkManager will auto-reconnect shortly.${NC}"
echo -e "${CYAN}==================================================${NC}"
echo ""
