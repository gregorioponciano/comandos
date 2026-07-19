# GUIA RÁPIDO DO TCPDUMP - COMANDOS ESSENCIAIS

## 1. Captura Básica e Gestão de Interfaces
tcpdump -D                  # Listar todas as interfaces de rede disponíveis no sistema para captura.
tcpdump -i eth0             # Capturar pacotes especificamente na interface de rede "eth0".
tcpdump -i any              # Capturar tráfego de todas as interfaces ativas no sistema simultaneamente.
tcpdump -c 10 -i eth0       # Interromper a captura automaticamente após receber exatamente 10 pacotes.
tcpdump -i eth0 -n          # Exibir endereços IP em formato numérico (evita a resolução de nomes por DNS, tornando o scan muito mais rápido).
tcpdump -i eth0 -nn         # Não resolver endereços IP nem números de portas (Ex: exibe :80 em vez de :http).
tcpdump -i eth0 -v          # Ativar o modo verboso para exibir detalhes como TTL, ID do pacote e opções IP.
tcpdump -i eth0 -vv         # Modo muito verboso, trazendo informações detalhadas de protocolos (NFS, SMB, etc).
tcpdump -i eth0 -vvv        # Nível máximo de verbosidade, exibe todos os dados possíveis de decodificação de pacotes.

## 2. Visualização de Dados e Formatos de Saída
tcpdump -i eth0 -q          # Modo silencioso (quiet). Exibe menos informações na linha de comandos, focando no essencial.
tcpdump -i eth0 -A          # Exibir o conteúdo de cada pacote capturado em formato ASCII (ideal para ler mensagens HTTP, cookies ou texto limpo).
tcpdump -i eth0 -X          # Exibir o conteúdo do pacote tanto em formato Hexadecimal como em ASCII lado a lado.
tcpdump -i eth0 -XX         # Semelhante ao -X, mas inclui também a decodificação do cabeçalho de ligação de dados (Ethernet).
tcpdump -i eth0 -t          # Ocultar a impressão da marca de tempo (timestamp) em cada linha de pacote.
tcpdump -i eth0 -tt         # Exibir a marca de tempo no formato Unix Epoch (segundos desde 1 de Janeiro de 1970).
tcpdump -i eth0 -tttt       # Exibir a data e hora completas no formato padrão do sistema (Ano-Mês-Dia Hora).

## 3. Escrita e Leitura de Ficheiros (Análise Posterior)
tcpdump -i eth0 -w cap.pcap # Salvar todo o tráfego bruto capturado diretamente num ficheiro PCAP para abrir mais tarde no Wireshark.
tcpdump -r cap.pcap         # Ler e analisar o conteúdo de um ficheiro de captura PCAP previamente guardado.
tcpdump -r cap.pcap -n -c 5 # Ler um ficheiro PCAP sem resolver DNS e mostrando apenas os primeiros 5 pacotes.
tcpdump -i eth0 -C 10 -w c  # Limitar o tamanho do ficheiro em 10MB; cria automaticamente novos ficheiros (c1, c2) ao atingir o limite.
tcpdump -i eth0 -W 5 -C 10 -w rotativo # Cria um buffer rotativo de 5 ficheiros de 10MB cada, substituindo os mais antigos quando cheios.

## 4. Filtragem Avançada por Hosts e Redes
tcpdump -i eth0 host 10.0.0.5          # Capturar pacotes que tenham o IP "10.0.0.5" como origem OU como destino.
tcpdump -i eth0 src host 10.0.0.5      # Filtrar pacotes que venham especificamente da origem (source) 10.0.0.5.
tcpdump -i eth0 dst host 10.0.0.5      # Filtrar pacotes que vão especificamente para o destino (destination) 10.0.0.5.
tcpdump -i eth0 net 192.168.1.0/24     # Capturar tráfego de ou para qualquer máquina localizada nesta sub-rede.
tcpdump -i eth0 src net 192.168.1.0/24 # Filtrar pacotes cuja origem pertença à sub-rede especificada.
tcpdump -i eth0 dst net 192.168.1.0/24 # Filtrar pacotes cujo destino pertença à sub-rede especificada.

## 5. Filtragem por Portas e Protocolos
tcpdump -i eth0 port 80                # Capturar pacotes que utilizem a porta 80 (HTTP) como origem ou destino.
tcpdump -i eth0 src port 80            # Filtrar pacotes vindos especificamente da porta de origem 80.
tcpdump -i eth0 dst port 443           # Filtrar pacotes direcionados especificamente para a porta de destino 443 (HTTPS).
tcpdump -i eth0 portrange 1-1024       # Capturar tráfego de qualquer porta localizada dentro deste intervalo específico.
tcpdump -i eth0 tcp                    # Capturar estritamente pacotes do protocolo TCP.
tcpdump -i eth0 udp                    # Capturar estritamente pacotes do protocolo UDP.
tcpdump -i eth0 icmp                   # Capturar pacotes do protocolo ICMP (útil para monitorizar pings).
tcpdump -i eth0 arp                    # Capturar pacotes de resolução de endereços ARP na rede.

## 6. Operadores Lógicos (Combinação de Filtros Complexos)
tcpdump -i eth0 "src 10.0.0.5 and dst port 80"       # Operador AND: Capturar se a origem for o IP e o destino for a porta 80.
tcpdump -i eth0 "port 80 or port 443"                 # Operador OR: Capturar tráfego web padrão, seja ele HTTP (80) ou HTTPS (443).
tcpdump -i eth0 "host 10.0.0.5 and not port 22"       # Operador NOT: Capturar tráfego do host, mas ignorar completamente o tráfego de SSH (22).
tcpdump -i eth0 "src net 10.0.0.0/24 and (dst port 80 or dst port 443)" # Uso de parênteses para agrupar condições lógicas complexas.

## 7. Filtros Avançados de Cabeçalhos e Flags (Inspeção de Pacotes)
tcpdump -i eth0 "tcp[tcpflags] & (tcp-syn|tcp-ack) == tcp-syn" # Filtrar estritamente pacotes com a flag SYN ativa (início de conexões).
tcpdump -i eth0 "tcp[tcpflags] & tcp-syn != 0"                 # Outra forma comum de capturar apenas pacotes TCP SYN.
tcpdump -i eth0 "tcp[tcpflags] & tcp-rst != 0"                 # Filtrar conexões rejeitadas ou abortadas abruptamente (flag RST ativa).
tcpdump -i eth0 "tcp[tcpflags] & tcp-fin != 0"                 # Filtrar encerramentos normais de conexão TCP (flag FIN ativa).
tcpdump -i eth0 "ip[2:2] > 576"                                # Filtrar pacotes IP cujo comprimento total do pacote seja maior que 576 bytes.
tcpdump -i eth0 "ip[6] & 0x40 != 0"                            # Filtrar pacotes que tenham a flag "Don't Fragment" (DF) ativa no cabeçalho IP.
