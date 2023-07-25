#!/bin/bash
CONEXAO_NAME=$(nmcli -g NAME connection show --active)
DNS_PRIMARIO="172.23.32.4"
DNS_SECUNDARIO="172.23.116.4"


# Endereço de IP
ip_address=$(hostname -I)

# Endereço MAC
mac_address=$(ip link show | awk '/ether/ {print $2}')

# Processador
processor=$(cat /proc/cpuinfo | grep 'model name' | uniq | cut -d ':' -f 2)

# Memória RAM
ram=$(free -h | awk '/Mem.:/ {print $2}')

# Armazenamento (verifica se é SSD ou HD)
storage=$(lsblk -o name,rota,size | grep 'sd'| awk '$2 == "1" {print $1 " " $2 " " $3 " (HD)"}; $2 == "0" {print $1 " " $3 " (SSD)"}')

# DATA DA BIOS
bios_date=$(sudo dmidecode -s bios-release-date)

# Verifica se o USB está desabilitado ou habilitado
#usb_status=$(lsusb &>/dev/null && echo "Habilitado" || echo "Desabilitado")

# Verifica se o Fusion-inventory está ativo (verifique o nome do processo real para substituir "fusion-inventory")
fusion_inventory_status=$(pgrep fusioninventory &>/dev/null && echo "Ativo" || echo "Inativo")

# Verifica se o Kaspersky está ativo (verifique o nome do processo real para substituir "kaspersky")
kaspersky_status=$(pgrep kesl &> /dev/null && pgrep kesl-gui &> /dev/null && echo "Ativo" || echo "Inativo")

#Configurações do dns
sudo nmcli connection modify "$CONEXAO_NAME" ipv4.dns "$DNS_PRIMARIO, $DNS_SECUNDARIO"

#Reinicia conexão de rede
sudo nmcli connection down "$CONEXAO_NAME" && sudo nmcli connection up "$CONEXAO_NAME"

#Verifica DNS
SHOW_DNS=$(nmcli -g IP4.DNS connection show "$CONEXAO_NAME")

# Imprime as informações coletadas
echo "Endereço de IP: $ip_address"
echo "Endereço MAC: $mac_address"
echo "Processador: $processor"
echo "Memória RAM: $ram"
echo "Armazenamento: $storage"
echo "Data da BIOS: $bios_date"
#echo "Status do USB: $usb_status"
echo "Status do Fusion-inventory: $fusion_inventory_status"
echo "Status do Kaspersky: $kaspersky_status"
echo "Nome da conexão: $CONEXAO_NAME"
echo "DNS configurado: $SHOW_DNS"


#sudo rm status_et.sh

#curl -k http://www.com3dn.mb/sites/default/files/aplicacoes/status_et.sh > status_et.sh && sudo chmod 755 status_et.sh && ./status_et.sh
