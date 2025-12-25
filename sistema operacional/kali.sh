ls               # Lista arquivos e diretórios
ls -l            # Lista longo formato
ls -la           # Lista detalhada incluindo arquivos ocultos
ls -lh           # Lista com tamanhos legíveis
ls -ltr          # Ordena por tempo reverso
ls -R            # Recursivo
ls -i            # Mostra inodes
ls --color=auto  # Com coloração
ls -d */         # Apenas diretórios 
ls *.txt         # Filtra por extensão
pwd              # Mostra o diretório atual
cd               # Muda de diretório
cd ~             # Vai para o diretório home
cd /             # Vai para o diretório raiz
cd ..            # Volta um diretório
clear            # Limpa a tela
exit             # Sai do terminal
reboot           # Reinicia o sistema
shutdown         # Desliga o sistema
whoami           # Mostra o usuário atual
id               # Mostra informações do usuário
uname -a         # Mostra informações do sistema
history          # Mostra histórico de comandos

# 2. Gerenciamento de Arquivos

cp          # Copia arquivos/diretórios
cp -r       # Copia diretórios recursivamente
mv          # Move/renomeia arquivos
rm          # Remove arquivos
rm -r       # Remove diretórios recursivamente
rm -rf      # Remove forçadamente
mkdir       # Cria diretório
rmdir       # Remove diretório vazio
touch       # Cria arquivo vazio
cat         # Exibe conteúdo do arquivo
more        # Exibe arquivo página por página
less        # Exibe arquivo com navegação
head        # Mostra primeiras linhas
tail        # Mostra últimas linhas
tail -f     # Monitora arquivo em tempo real
nano        # Editor de texto simples
vim         # Editor de texto avançado
gedit       # Editor gráfico
find        # Busca arquivos
locate      # Busca rápida no sistema
grep        # Busca padrões em texto

# 3. Permissões e Propriedade

chmod       # Altera permissões
chown       # Altera proprietário
chgrp       # Altera grupo
umask       # Define permissões padrão

# 4. Processos e Sistema

ps          # Mostra processos ativos
ps aux      # Mostra todos os processos
top         # Monitor de processos em tempo real
htop        # Top com interface melhorada
kill        # Mata processo por PID
killall     # Mata processo por nome
pkill       # Mata processo por padrão
bg          # Coloca processo em segundo plano
fg          # Traz processo para primeiro plano
jobs        # Lista jobs em segundo plano
nice        # Altera prioridade do processo
renice      # Altera prioridade em execução
systemctl   # Controla systemd services
service     # Controla serviços (SysV)

# 5. Rede e Conectividade

ifconfig    # Configura interfaces de rede (obsoleto)
ip addr     # Mostra endereços IP
ip route    # Mostra tabela de roteamento
ping        # Testa conectividade
traceroute  # Traça rota para destino
netstat     # Estatísticas de rede
ss          # Socket statistics (substituto netstat)
nmap        # Scanner de portas
iwconfig    # Configura interfaces wireless
iwlist      # Lista redes wireless
airmon-ng   # Ativa modo monitor wireless

# 6. Gerenciamento de Pacotes

apt update          # Atualiza lista de pacotes
apt upgrade         # Atualiza pacotes instalados
apt install         # Instala pacotes
apt remove          # Remove pacotes
apt purge           # Remove com configurações
apt search          # Busca pacotes
apt show            # Mostra info do pacote
apt list            # Lista pacotes
dpkg                # Gerencia pacotes .deb
snap                # Gerencia snaps

# 7. Escaneamento de Rede

nmap -sS            # SYN scan stealth
nmap -sT            # TCP connect scan
nmap -sU            # UDP scan
nmap -sV            # Detecta versões de serviço
nmap -O             # Detecta sistema operacional
nmap -A             # Scan agressivo
nmap -p             # Escaneia portas específicas
nmap --script       # Executa scripts NSE
masscan             # Scanner de alta velocidade
netdiscover         # Descobre hosts na rede

#  8. Análise de Vulnerabilidades

nikto               # Scanner web vulnerabilidades
sqlmap              # SQL injection tool
burpsuite           # Proxy web security
zap                 # Zed Attack Proxy
nessus              # Scanner vulnerabilidades
openvas             # Open Vulnerability Assessment

# 9. Wireless Hacking

aircrack-ng         # Suite wireless security
airodump-ng         # Captura pacotes wireless
aireplay-ng         # Injeta pacotes wireless
airmon-ng           # Ativa modo monitor
wash                # Detecta WPS
reaver              # Ataque WPS
wifite              # Automated wireless auditor

# 10. Análise de Tráfego de Rede  (Sniffing e Spoofing)

wireshark           # Analisador de protocolos
tshark              # Wireshark em terminal
tcpdump             # Captura de pacotes
ettercap            # Suite MITM
driftnet            # Captura imagens em rede
dnsspoof            # Spoofing DNS
arpspoof            # ARP spoofing

# 11. Engenharia Social

setoolkit           # Social Engineering Toolkit
maltego             # Intelligence gathering
theharvester        # Coleta informações
sherlock            # Busca contas em redes sociais

# 12. Criptografia e Quebra de Senhas

john                # John the Ripper
hashcat             # Password recovery tool
hydra               # Login cracker
medusa              # Parallel login cracker
crunch              # Wordlist generator
cewl                # Wordlist generator da web

# 13. Exploração

metasploit          # Framework de exploração
msfconsole          # Console Metasploit
searchsploit        # Busca exploits
sqlmap              # SQL injection
beef                # Browser Exploitation Framework

# 14. Web Application

dirb                # Web content scanner
gobuster            # Directory/file brute force
wfuzz               # Web fuzzer
whatweb             # Web scanner
sublist3r           # Subdomain enumeration

# 15. Análise Forense

binwalk             # Firmware analysis tool
foremost            # File recovery
scalpel             # File carving
volatility          # Memory forensics
autopsy             # GUI forensic browser

# 16. Esteganografia

steghide            # Hide data in files
outguess            # Steganography tool
stegosuite          # GUI steganography
zsteg               # Detect stego in PNG/BMP

# 17. Reverse Engineering

gdb                 # GNU Debugger
radare2             # Reverse engineering framework
ghidra              # Software reverse engineering suite
ollydbg             # Debugger para Windows
ida                 # Interactive Disassembler

# 18. Análise de Malware

cuckoo              # Automated malware analysis
yara                # Malware identification
maltego             # Link analysis
virustotal          # Online malware scanning

# COMANDOS AVANÇADOS E UTILITÁRIOS

#19. Shell e Scripting

bash                # Bourne Again SHell
zsh                 # Z Shell
fish                # Friendly Interactive Shell
python              # Python interpreter
python3             # Python 3 interpreter
perl                # Perl interpreter
ruby                # Ruby interpreter
sh                  # Shell
echo                # Exibe texto
printf              # Formata e exibe texto
alias               # Cria aliases
unalias             # Remove alias
export              # Define variáveis de ambiente
source              # Executa script no shell atual

# 20. Compressão e Arquivos

tar                 # Archiver
gzip                # Compress GNU zip
gunzip              # Descompacta .gz
bzip2               # Compressão melhor
xz                  # Compressão alta taxa
zip                 # Cria arquivos ZIP
unzip               # Extrai arquivos ZIP
7z                  # 7-Zip archiver

# 21. Monitoramento do Sistema

df                  # Espaço em disco livre
du                  # Uso de espaço por diretório
free                # Memória livre
vmstat              # Estatísticas de sistema
iostat              # Estatísticas de I/O
mpstat              # Estatísticas de processador
sar                 # System Activity Reporter
dmesg               # Mensagens do kernel
journalctl          # Systemd journal

# 22. Usuários e Grupos

useradd             # Adiciona usuário
userdel             # Remove usuário
usermod             # Modifica usuário
groupadd            # Adiciona grupo
groupdel            # Remove grupo
passwd              # Altera senha
su                  # Muda usuário
sudo                # Executa como superusuário
visudo              # Edita sudoers

# 23. Backup e Recuperação

rsync               # Sincronização de arquivos
scp                 # Cópia segura via SSH
sftp                # FTP seguro
dd                  # Conversão e cópia
clonezilla          # Clonagem de disco

# 24. Virtualização e Containers

docker              # Container platform
docker-compose      # Multi-container apps
vagrant             # Virtual development env
virtualbox          # Virtualization software
vmware              # VMware tools
lxc                 # Linux containers
lxd                 # Container hypervisor

# 25. Desenvolvimento

git                 # Version control
gcc                 # GNU C compiler
g++                 # GNU C++ compiler
make                # Build automation
cmake               # Cross-platform build
gdb                 # Debugger
valgrind            # Memory debugging
strace              # System call tracer
ltrace              # Library call tracer

# 26. SSH e Conexões Remotas

ssh                 # Secure Shell client
ssh-keygen          # Gera chaves SSH
ssh-copy-id         # Copia chave para servidor
sftp                # SSH file transfer
scp                 # Secure copy
telnet              # Telnet client
netcat              # Networking utility
socat               # Multipurpose relay

# 27. Banco de Dados

mysql               # MySQL client
psql                # PostgreSQL client
sqlite3             # SQLite client
mongodb             # MongoDB shell
redis-cli           # Redis client

# 28. Serviços Web

curl                # Transferência de dados
wget                # Download da web
httpie              # HTTP client moderno
nginx               # Web server
apache2             # Web server Apache

#29. Ferramentas Específicas Kali   

kali-tools          # Lista ferramentas Kali
kali-linux-headless # Kali sem interface
kali-undercover     # Modo discreto
update-alternatives # Gerencia alternativas

# COMANDOS DE REDE ESPECIALIZADOS

# 30. Protocol Analysis

hping3              # Packet generator/analyzer
scapy               # Packet manipulation
ncat                # Netcat do Nmap
tcpick              # TCP stream sniffer
tcpflow             # Captura conteúdo TCP

# 31. DNS Analysis

dig                 # DNS lookup utility
nslookup            # Query DNS servers
dnsenum             # DNS enumeration
dnsrecon            # DNS reconnaissance
fierce              # DNS scanner

# 32. SSL/TLS Analysis

sslscan             # SSL/TLS scanner
testssl             # TLS/SSL encryption checker
sslyze              # SSL/TLS configuration analyzer

# 33. VPN and Tunneling

openvpn             # VPN client/server
wireguard           # Modern VPN protocol
sshuttle            # VPN over SSH
proxychains         # Proxy redirector


# COMANDOS ÚTEIS PARA PENTEST

# 34. Information Gathering

theharvester        # Gathers emails/subdomains
recon-ng            # Web reconnaissance
spiderfoot          # OSINT automation
osrframework        # Open Sources Research

# 35. Vulnerability Scanning

openvas             # Vulnerability scanner
lynis               # Security auditing
nikto               # Web server scanner
wapiti              # Web vulnerability scanner

# 36. Exploitation Tools

metasploit-framework # Exploit framework
armitage            # GUI for Metasploit
routersploit        # Embedded device exploitation
powersploit         # PowerShell post-exploitation

# 37. Post-Exploitation

mimikatz            # Windows credential extraction
powershell-empire   # Post-exploitation framework
bloodhound          # Active Directory analysis
cobaltstrike        # Red team framework

# 38. Reporting

dradis              # Reporting and collaboration
faraday             # Collaborative pentest platform
keepnote            # Note-taking application
cherrytree          # Hierarchical note taking

# COMANDOS DE LINHA DE COMANDO ÚTEIS

# 39. Text Processing

awk                 # Pattern scanning/processing
sed                 # Stream editor
cut                 # Remove sections from lines
paste               # Merge lines of files
join                # Join lines on common field
sort                # Sort lines
uniq                # Remove duplicates
wc                  # Word count
tr                  # Translate characters

# 40. System Information

lscpu               # CPU architecture info
lsblk               # List block devices
lspci               # List PCI devices
lsusb               # List USB devices
inxi                # Full system information
neofetch            # System info display
screenfetch         # Screenshot system info

# 41. Network Configuration

nmcli               # NetworkManager CLI
nmtui               # NetworkManager TUI
hostnamectl         # Control system hostname
timedatectl         # Control system time/date
localectl           # Control locale settings

# 42. Disk Management

fdisk               # Partition table manipulator
parted              # Partition editor
gparted             # GUI partition editor
fsck                # Filesystem check
mkfs                # Create filesystem
mount               # Mount filesystem
umount              # Unmount filesystem
blkid               # Locate/print block device attr

# 43. Performance Monitoring

nmon                # System performance monitor
glances             # Cross-platform monitoring tool
bpytop              # Resource monitor
iftop               # Display bandwidth usage
nethogs             # Per-process network usage
iotop               # I/O usage by process
powertop            # Power usage monitor

# 44. Log Analysis

logwatch            # Log analysis and reporting
swatch              # Log file watcher
multitail           # Monitor multiple logs
lnav                # Log file navigator

# COMANDOS DE SEGURANÇA AVANÇADA

# 45. Firewall and Security

iptables            # IPv4 packet filtering
ip6tables           # IPv6 packet filtering
ufw                 # Uncomplicated Firewall
firewalld           # Dynamic firewall manager
fail2ban            # Ban IPs with failed attempts

# 46. Encryption and Keys

gpg                 # GNU Privacy Guard
openssl             # Cryptography toolkit
cryptsetup          # Setup encrypted filesystems
shred               # Overwrite files securely
wipe                # Secure file deletion

# 47. Incident Response

sleuthkit           # Forensic toolkit
chkrootkit          # Rootkit detector
rkhunter            # Rootkit scanner
lynis               # Security auditing tool
tripwire            # Integrity checking
aide                # Advanced intrusion detection

# 48. Network Defense

snort               # Network intrusion detection
suricata            # Network IDS/IPS
securityonion       # Network security monitoring
bro/zeek            # Network analysis framework

# 49. Web Security

burpsuite           # Web vulnerability scanner
zaproxy             # OWASP Zed Attack Proxy
w3af                # Web app attack/audit framework
arachni             # Web app security scanner

# 50. Mobile Security

apktool             # Reverse engineering APKs
jadx                # Dex to Java decompiler
frida               # Dynamic instrumentation
mobsf               # Mobile Security Framework

# COMANDOS DE AUTOMAÇÃO 

# 51. Task Automation

cron                # Job scheduler
at                  # Execute commands at time
anacron             # Cron for desktops
systemd-timer       # Systemd job scheduler

# 52. Scripting Helpers

xargs               # Build and execute commands
parallel            # Run jobs in parallel
watch               # Execute periodically
time                # Time command execution
timeout             # Run with time limit
nohup               # Run immune to hangups

# 53. Version Control

git init            # Initialize repository
git clone           # Clone repository
git add             # Add files to staging
git commit          # Commit changes
git push            # Push to remote
git pull            # Pull from remote
git branch          # Manage branches
git merge           # Merge branches
git status          # Show status
git log             # Show commit history

# COMANDOS DE REDE ESPECÍFICOS

# 54. Network Troubleshooting

mtr                 # Network diagnostic tool
pathping            # Combines ping/traceroute
nping               # Packet generation tool
hping               # Custom packet crafting

# 55. Service Discovery

nbtscan             # NetBIOS name scanner
enum4linux          # SMB enumeration
smbclient           # SMB/CIFS client
rpcinfo             # RPC information

# 56. Protocol Specific

snmpwalk            # SNMP enumeration
onesixtyone         # SNMP scanner
amap                # Application mapper

# 57. Web Crawling

cewl                # Custom wordlist generator
httrack             # Website copier
wget --mirror       # Mirror website

# COMANDOS ÚTEIS DO DIA-A-DIA

# 58. File Comparison

diff                # Compare files line by line
vimdiff             # Compare files in Vim
meld                # GUI diff tool
comm                # Compare sorted files
cmp                 # Compare two files

# 59. Archive Handling

ar                  # Create/modify archives
unar                # Universal archive extractor

# 60. System Maintenance

updatedb            # Update database for locate
ldconfig            # Configure dynamic linker
depmod              # Generate modules.dep
modprobe            # Add/remove modules

# 61. Hardware Info

dmidecode           # DMI table decoder
hdparm              # Get/set hard disk params
smartctl            # SMART disk control
sensors             # Monitor sensors

# COMANDOS PARA DESENVOLVEDORES

# 62. Programming 

python              # Python interpreter
pip                 # Python package manager
node                # Node.js runtime
npm                 # Node package manager
javac               # Java compiler
java                # Java runtime
gcc                 # C compiler
g++                 # C++ compiler
rustc               # Rust compiler
cargo               # Rust package manager

# 63. Web Development

npm                 # Node package manager
yarn                # Alternative to npm
composer            # PHP dependency manager
bundler             # Ruby dependency manager
webpack             # Module bundler

# 64. Container Tools

podman              # Daemonless containers
buildah             # Build OCI images
skopeo              # Work with remote images
kubernetes          # Container orchestration
kubectl             # Kubernetes CLI
helm                # Kubernetes package manager

# COMANDOS DE AUDIO/VIDEO

# 65. Multimedia

ffmpeg              # Video/audio converter
youtube-dl          # Download videos
mpv                 # Media player
vlc                 # VLC media player
sox                 # Sound exchange

#66. Screenshot/Recording

scrot               # Screenshot utility
import              # Image capture (ImageMagick)
ffmpeg              # Screen recording
obs                 # Open Broadcaster Software
kazam               # Desktop recorder

# COMANDOS DE IMPRESSÃO

# 67. Printing

lp                  # Print files
lpstat              # Printer status
lprm                # Remove print jobs
lpoptions           # Set printer options
cupsctl             # Configure CUPS

# COMANDOS PARA WINDOWS EM KALI

# 68. Windows Tools

wine                # Run Windows applications
mono                .NET framework on Linux

#COMANDOS DE BACKDOOR/RAT

# 69. Remote Access

netcat              # Network Swiss army knife
socat               # Multipurpose relay
webshells           # Various web shells

# COMANDOS DE PERSISTÊNCIA

#70. Persistence

crontab             # Schedule recurring jobs
systemd services    # Create system services
rc.local            # Scripts at boot

#COMANDOS DE PRIVACIDADE

# 71. Privacy

tor                 # Onion routing
torsocks            # Torify applications
proxychains         # Proxy chains
bleachbit           # Privacy cleaner

# COMANDOS DE RECONHECIMENTO

# 72. Reconnaissance

sublist3r           # Subdomain enumeration
assetfinder         # Find related domains
waybackurls         # Get Wayback Machine URLs
gau                 # Get All URLs

# COMANDOS DE BRUTE FORCE

# 73. Brute Force

patator             # Multi-purpose brute forcer
ncrack              # Network authentication cracker
thc-hydra           # Parallelized login cracker
crowbar             # Brute force certain services

# COMANDOS DE ANÁLISE DE TRÁFEGO

# 74. Traffic Analysis

ngrep               # Network grep
httpry              # HTTP logging
justniffer          # TCP packet sniffer
tcpreplay           # Replay network traffic

# COMANDOS DE ENUMERAÇÃO

# 75. Enumeration

enum4linux          # SMB enumeration
ldapsearch          # LDAP enumeration
snmp-check          # SNMP enumeration
rdp-sec-check       # RDP security check

# COMANDOS PARA METASPLOIT

#76. Metasploit Essentials

msfconsole          # Metasploit framework console
msfvenom            # Payload generator
msfdb               # Metasploit database
msfrpc              # Metasploit RPC interface
msfupdate           # Update Metasploit

# COMANDOS PARA WIFI

# 77. WiFi Tools

kismet              # Wireless detector/sniffer
bully               # WPS brute force
pixiewps            # Offline WPS attack
fern-wifi-cracker   # GUI wireless cracker

# COMANDOS PARA ANDROID

# 78. Android Security

apktool             # Reverse engineering APK
dex2jar             # Dex to Jar converter
jd-gui              # Java decompiler
androguard          # Android app analysis

# COMANDOS PARA IOS

# 79. iOS Security

plutil              # Property list utility
class-dump          # Objective-C header dumper
frida-ios-dump      # iOS app dumper
cycript             # JavaScript/Objective-C bridge

# COMANDOS DE CLOUD

# 80. Cloud Security

awscli              # AWS command line
gcloud              # Google Cloud CLI
az                  # Azure CLI
prowler             # AWS security assessment
cloudsploit         # Cloud security configuration

# COMANDOS DE AUTOMAÇÃO DE PENTEST

# 81. Automation

autorecon           # Automated reconnaissance
lazyrecon           # Semi-automated recon
reconspider         # Advanced OSINT
photon              # Incredibly fast crawler

# COMANDOS DE REPORTING

# 82. Reporting Tools

serbot              # Report generator
pandoc              # Document converter
wkhtmltopdf         # HTML to PDF converter
libreoffice         # Office suite

# COMANDOS DE GESTÃO DE PROJETOS

# 83. Project Management

trello-cli          # Trello command line
taskwarrior         # Task management
timewarrior         # Time tracking

# COMANDOS ÚTEIS ADICIONAIS

# 84. Miscellaneous

cal                 # Calendar
date                # Display date/time
bc                  # Calculator
factor              # Factor numbers
units               # Unit conversion
ascii               # ASCII table
banner              # Create banners
figlet              # ASCII art text
cowsay              # Talking cow
fortune             # Random quotes
sl                  # Steam locomotive
cmatrix             # Matrix effect