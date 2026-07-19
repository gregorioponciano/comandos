# GUIA RÁPIDO DO GOBUSTER - COMANDOS ESSENCIAIS

## 1. Modo Diretório (dir) - Descobrir Pastas e Ficheiros Web
gobuster dir -u http://192.168.1.1 -w /usr/share/wordlists/dirb/common.txt - Varredura básica de diretórios.
gobuster dir -u http://192.168.1.1 -w lista.txt -x php,html,txt - Procurar extensões de ficheiros específicas.
gobuster dir -u http://192.168.1.1 -w lista.txt -f - Adicionar uma barra (/) no final de cada diretório testado.
gobuster dir -u http://192.168.1.1 -w lista.txt -k - Ignorar avisos e erros de certificados SSL/TLS inválidos.
gobuster dir -u http://192.168.1.1 -w lista.txt -s "200,204,301,302,307" - Filtrar para mostrar apenas estes códigos de status HTTP.
gobuster dir -u http://192.168.1.1 -w lista.txt -b "404,403" - Ocultar/excluir códigos de status específicos da resposta.
gobuster dir -u http://192.168.1.1 -w lista.txt -a "Mozilla/5.0" - Alterar o User-Agent da requisição para simular um navegador.
gobuster dir -u http://192.168.1.1 -w lista.txt -H "Authorization: Bearer TOKEN" - Adicionar um cabeçalho HTTP customizado (ex: autenticação).
gobuster dir -u http://192.168.1.1 -w lista.txt -U utilizador -P senha - Autenticação HTTP Básica (.htaccess).
gobuster dir -u http://192.168.1.1 -w lista.txt -r - Seguir redirecionamentos HTTP (HTTP 3xx).
gobuster dir -u http://192.168.1.1 -w lista.txt -p http://127.0.0.1:8080 - Encaminhar todo o tráfego através de um Proxy (ex: Burp Suite).
gobuster dir -u http://192.168.1.1 -w lista.txt -m GET - Mudar o método de requisição HTTP (ex: GET, POST, HEAD).
gobuster dir -u http://192.168.1.1 -w lista.txt -d - Descobrir também ficheiros ocultos (que começam com ponto, ex: .env).
gobuster dir -u http://192.168.1.1 -w lista.txt --cookies "session=123" - Enviar cookies de sessão nas requisições.

## 2. Modo DNS (dns) - Descobrir Subdomínios
gobuster dns -d alvo.com -w /usr/share/wordlists/SecLists/Discovery/DNS/subdomains-top1million-5000.txt - Varredura básica de subdomínios.
gobuster dns -d alvo.com -w lista.txt -r 8.8.8.8 - Usar um servidor DNS específico (ex: Google) para resolver os nomes.
gobuster dns -d alvo.com -w lista.txt -r 8.8.8.8,1.1.1.1 - Usar múltiplos servidores DNS em rotação.
gobuster dns -d alvo.com -w lista.txt -i - Mostrar o endereço IP correspondente ao subdomínio encontrado.
gobuster dns -d alvo.com -w lista.txt -c - Mostrar também os registos CNAME (aliases de domínio).
gobuster dns -d alvo.com -w lista.txt --wildcard - Forçar a execução mesmo que o domínio tenha resolução wildcard ativa.

## 3. Modo Host Virtual (vhost) - Descobrir Virtual Hosts
gobuster vhost -u http://alvo.com -w lista.txt - Procurar por Virtual Hosts baseados em IP/Nome no servidor web.
gobuster vhost -u http://alvo.com -w lista.txt --append-domain - Adicionar automaticamente o domínio principal a cada palavra da lista (ex: ://alvo.com).

## 4. Modo Amazon S3 (s3) - Descobrir Buckets Públicos
gobuster s3 -w lista.txt - Procurar por buckets S3 da AWS expostos publicamente com base na wordlist.

## 5. Performance e Ajustes Globais (Aplicável a qualquer modo)
gobuster dir -u http://192.168.1.1 -w lista.txt -t 50 - Definir o número de threads/processos paralelos (padrão é 10, aumentar acelera o scan).
gobuster dir -u http://192.168.1.1 -w lista.txt --delay 500ms - Adicionar um atraso entre as requisições (útil para evitar bloqueios/IDS).
gobuster dir -u http://192.168.1.1 -w lista.txt --timeout 10s - Definir o tempo limite de espera para conexões HTTP/DNS.
gobuster dir -u http://192.168.1.1 -w lista.txt --retry 3 - Número de tentativas de conexão em caso de falha ou timeout.

## 6. Saída e Relatórios
gobuster dir -u http://192.168.1.1 -w lista.txt -o resultado.txt - Salvar a saída com os resultados encontrados num ficheiro de texto.
gobuster dir -u http://192.168.1.1 -w lista.txt -q - Modo silencioso (oculta banners e mensagens de status, mostra apenas resultados).
gobuster dir -u http://192.168.1.1 -w lista.txt -v - Modo verboso (mostra mais detalhes sobre erros e progresso).
gobuster dir -u http://192.168.1.1 -w lista.txt -z - Ocultar a barra de progresso em tempo real durante a execução.
gobuster version - Exibir a versão atual instalada do Gobuster.
gobuster help - Exibir a ajuda geral do sistema.
gobuster help dir - Exibir o menu de ajuda específico para o modo de diretórios.
