# GUIA RÁPIDO DO NMAP - 100 COMANDOS ESSENCIAIS

## 1. Alvos e Escopos (Como definir o que escanear)
nmap 192.168.1.1 - Escanear um único IP.
nmap 192.168.1.1 192.168.1.2 - Escanear múltiplos IPs.
nmap 192.168.1.0/24 - Escanear toda uma sub-rede (classe C).
nmap 192.168.1.1-50 - Escanear um intervalo de IPs.
nmap -iL lista_alvos.txt - Escanear IPs listados em um arquivo.
nmap -iR 100 - Escanear 100 hosts aleatórios na internet.
nmap --exclude 192.168.1.1 - Excluir um IP do escaneamento.
nmap --excludefile arquivo_exclusao.txt - Excluir IPs listados em um arquivo.
nmap scanme.nmap.org - Escanear o domínio de testes oficial do Nmap.
nmap localhost - Escanear a própria máquina local.
nmap 192.168.1.* - Usar wildcard para escanear a rede inteira.
nmap -6 ::1 - Escanear um alvo usando IPv6.
nmap -sL 192.168.1.0/24 - Listar todos os alvos da rede sem enviar pacotes (sem scan de portas).
nmap --top-ports 100 scanme.nmap.org - Escanear apenas as 100 portas mais comuns.
nmap --top-ports 10 scanme.nmap.org - Escanear apenas as 10 portas mais comuns.

## 2. Técnicas de Varredura (Como os pacotes são enviados)
nmap -sS 192.168.1.1 - Scan SYN (padrão e mais rápido, não fecha conexão TCP).
nmap -sT 192.168.1.1 - Scan TCP Connect (completa a conexão, mais barulhento).
nmap -sU 192.168.1.1 - Scan UDP (para serviços como DNS, DHCP).
nmap -sA 192.168.1.1 - Scan ACK (usado para mapear regras de firewall).
nmap -sW 192.168.1.1 - Scan Window TCP (pode identificar portas abertas em alguns SOs).
nmap -sM 192.168.1.1 - Scan Maimon (varredura parecida com FIN/ACK).
nmap -sN 192.168.1.1 - Scan TCP NULL (nenhuma flag ativada, furtivo).
nmap -sF 192.168.1.1 - Scan TCP FIN (manda flag de término, furtivo).
nmap -sX 192.168.1.1 - Scan TCP Xmas (flags FIN, PSH e URG ativadas, furtivo).
nmap -sI zombie_ip alvo_ip - Scan Idle (scan cego usando um IP "zumbi" para camuflar).

## 3. Portas e Especificação
nmap -p 80 192.168.1.1 - Escanear apenas a porta 80.
nmap -p 80,443 192.168.1.1 - Escanear múltiplas portas específicas.
nmap -p 1-100 192.168.1.1 - Escanear um intervalo de portas.
nmap -p- 192.168.1.1 - Escanear todas as 65535 portas do alvo.
nmap -p U:53,T:80 192.168.1.1 - Escanear porta UDP 53 e TCP 80.
nmap -p http* 192.168.1.1 - Escanear portas cujos nomes começam com "http".
nmap -p- --min-rate 1000 192.168.1.1 - Definir velocidade mínima de envio de pacotes.
nmap -F 192.168.1.1 - Scan Rápido (escaneará menos portas que o padrão).
nmap -r 192.168.1.1 - Escanear portas sequencialmente (não aleatorizar).
nmap --top-ports 500 scanme.nmap.org - Escanear as 500 portas superiores.
nmap -p- -T4 192.168.1.1 - Escanear todas as portas rápido.
nmap -p 21,22,23,80,443 192.168.1.1 - Escanear portas de serviços padrão.
nmap -p smtp 192.168.1.1 - Escanear porta associada ao protocolo smtp.
nmap -p- --max-rate 2000 192.168.1.1 - Limitar velocidade para não derrubar rede frágil.
nmap -p 1-1024 192.168.1.1 - Escanear portas privilegiadas/comuns.

## 4. Detecção de SO e Serviços
nmap -sV 192.168.1.1 - Detectar a versão dos serviços rodando nas portas.
nmap -O 192.168.1.1 - Detectar o Sistema Operacional alvo.
nmap -A 192.168.1.1 - Scan Agressivo (combina detecção de SO, versão, scripts e traceroute).
nmap -sV --version-intensity 0 192.168.1.1 - Detectar versão de forma muito rápida e leve.
nmap -sV --version-intensity 9 192.168.1.1 - Detectar versão com alta intensidade (mais preciso, mais lento).
nmap -sV --version-all 192.168.1.1 - Tentar todos os testes de sonda de versão.
nmap -O --osscan-limit 192.168.1.1 - Limitar detecção de SO a alvos promissores.
nmap -O --osscan-guess 192.168.1.1 - Adivinhar SO se não houver correspondência exata.
nmap -A -T4 scanme.nmap.org - Scan agressivo e rápido.
nmap -sV --allports 192.168.1.1 - Tentar detecção de versão em todas as portas.

## 5. Descoberta de Hosts (Ping Scan)
nmap -sn 192.168.1.0/24 - Apenas descobrir hosts ativos (sem scan de portas).
nmap -Pn 192.168.1.1 - Pular a etapa de Ping (útil se o firewall bloqueia pacotes ICMP).
nmap -PS 192.168.1.1 - Ping TCP SYN.
nmap -PA 192.168.1.1 - Ping TCP ACK.
nmap -PU 192.168.1.1 - Ping UDP.
nmap -PE 192.168.1.1 - Ping Echo Request (padrão ICMP).
nmap -PP 192.168.1.1 - Timestamp Ping.
nmap -PM 192.168.1.1 - Netmask Ping.
nmap -PO 192.168.1.1 - Ping IP Protocol.
nmap -PR 192.168.1.1 - Ping ARP (útil na rede local).
nmap -n 192.168.1.1 - Não resolver DNS reverso (acelera o processo).
nmap -R 192.168.1.1 - Resolver DNS reverso para todos os alvos.
nmap --system-dns 192.168.1.1 - Usar o DNS do seu próprio sistema em vez do Nmap.
nmap -sn --traceroute 192.168.1.0/24 - Rastrear a rota até os ativos da rede.
nmap -sP 192.168.1.0/24 - Scan de Ping clássico.

## 6. Performance e Temporização (-T)
nmap -T0 192.168.1.1 - Modo Paranóico (muito lento, para evitar ser detectado por IDS).
nmap -T1 192.168.1.1 - Modo Furtivo (lento).
nmap -T2 192.168.1.1 - Modo Polido (reduz uso de banda).
nmap -T3 192.168.1.1 - Modo Normal (padrão).
nmap -T4 192.168.1.1 - Modo Agressivo (rápido, recomendado para conexões confiáveis).
nmap -T5 192.168.1.1 - Modo Insano (muito rápido, mas pode falhar ao detectar portas).
nmap --host-timeout 10m 192.168.1.1 - Abortar o scan de um host se demorar mais de 10 minutos.
nmap --max-rtt-timeout 100ms 192.168.1.1 - Ajustar tempo de espera de resposta.
nmap --min-parallelism 10 192.168.1.1 - Definir sondagens paralelas mínimas.
nmap -T4 --max-retries 2 192.168.1.1 - Ajustar número máximo de tentativas de retransmissão.

## 7. Evasão de Firewall e Falsificação
nmap -f 192.168.1.1 - Fragmentar pacotes (dificulta a inspeção de firewalls).
nmap -D RND:10 192.168.1.1 - Scan com 10 IPs aleatórios falsos para camuflar o seu IP (Decoys).
nmap -D 192.168.1.100,192.168.1.101 192.168.1.1 - Definir IPs Decoys específicos.
nmap -S 10.0.0.1 192.168.1.1 - Falsificar o IP de origem (Spoofing).
nmap --spoof-mac 00:11:22:33:44:55 192.168.1.1 - Falsificar o endereço MAC.
nmap --mtu 24 192.168.1.1 - Alterar a unidade máxima de transmissão (MTU).
nmap --proxies http://127.0.0.1:8080 192.168.1.1 - Usar proxy para rotear pacotes.
nmap -g 53 192.168.1.1 - Usar a porta 53 como fonte (porta DNS, para enganar firewalls).
nmap --data-length 25 192.168.1.1 - Adicionar dados aleatórios aos pacotes.
nmap --badsum 192.168.1.1 - Enviar pacotes com checksum TCP/UDP inválido.

## 8. Nmap Scripting Engine (NSE)
nmap -sC 192.168.1.1 - Executar os scripts padrão do Nmap.
nmap --script vuln 192.168.1.1 - Escanear vulnerabilidades conhecidas.
nmap --script safe 192.168.1.1 - Executar apenas scripts considerados seguros.
nmap --script auth 192.168.1.1 - Rodar scripts de checagem de autenticação.
nmap --script banner 192.168.1.1 - Ler o banner do serviço (ex: qual servidor HTTP responde).
nmap --script http-enum 192.168.1.1 - Enumerar diretórios e arquivos de servidores web.
nmap --script smb-os-discovery 192.168.1.1 - Descobrir SO através de compartilhamento de arquivos.
nmap --script dns-zone-transfer 192.168.1.1 - Testar se o servidor permite transferência de zona DNS.
nmap --script brute 192.168.1.1 - Testar senhas por força bruta.
nmap --script "http-*" - Rodar todos os scripts relacionados a HTTP.
nmap --script "default or safe" - Rodar scripts padrão OU seguros.

## 9. Relatórios e Formatos de Saída
nmap -oN resultado.txt 192.168.1.1 - Salvar resultado em arquivo de texto normal.
nmap -oX resultado.xml 192.168.1.1 - Salvar resultado em formato XML (fácil leitura por outras ferramentas).
nmap -oG resultado.grep 192.168.1.1 - Salvar em formato fácil de filtrar com comandos como grep.
nmap -v 192.168.1.1 - Aumentar verbosidade (exibe o que o Nmap está fazendo em tempo real).
