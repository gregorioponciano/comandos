✅ Guia completo – Ubuntu / Debian (recomendado)

sudo apt update && sudo apt upgrade -y    (# Atualizar sistema)

sudo apt install -y \  (# Instalar dependências básicas)
  build-essential \
  curl \
  wget \
  unzip \
  zip \
  ca-certificates \
  software-properties-common \
  gnupg \
  lsb-release\
  git\
  python3 \
  python3-pip \
  python3-venv \
  python3-dev

5️⃣ PHP 8.3

# Adicionar repositório oficial:

sudo add-apt-repository ppa:ondrej/php -y
sudo apt update

Instalar PHP 8.3 + extensões comuns:

sudo apt install -y \
  php8.3 \
  php8.3-cli \
  php8.3-fpm \
  php8.3-common \
  php8.3-mbstring \
  php8.3-xml \
  php8.3-curl \
  php8.3-zip \
  php8.3-bcmath \
  php8.3-intl \
  php8.3-mysql \
  php8.3-sqlite3


Verificar:

php -v

6️⃣ Composer (oficial)
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer


Verificar:

composer --version

7️⃣ Node.js (via NVM – recomendado)

Instalar NVM:

curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash


Recarregar shell:

source ~/.zshrc || source ~/.bashrc


Instalar Node LTS:

nvm install --lts
nvm use --lts


Verificar:

node -v
npm -v

8️⃣ ZSH + Oh My Zsh

Instalar ZSH:

sudo apt install -y zsh
chsh -s $(which zsh)


Instalar Oh My Zsh:

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

9️⃣ Autocomplete + Auto-suggestions no ZSH
Plugins essenciais:
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


Editar o arquivo:

nano ~/.zshrc


Altere a linha de plugins para algo assim:

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  docker
  npm
  node
  composer
)


Aplicar:

source ~/.zshrc

🔥 Bônus (opcional, mas recomendado)
sudo apt install -y fonts-firacode


E trocar o tema no .zshrc:

ZSH_THEME="agnoster"


Abaixo está o setup completo do MySQL Server + MySQL Workbench, já pronto para conectar sem dor de cabeça.

1️⃣ Instalar MySQL Server
sudo apt update
sudo apt install -y mysql-server


Verificar se está rodando:

sudo systemctl status mysql


Se não estiver ativo:

sudo systemctl start mysql
sudo systemctl enable mysql

2️⃣ Segurança inicial do MySQL
sudo mysql_secure_installation


Sugestão de respostas:

VALIDATE PASSWORD: Y

Nível: MEDIUM

Remover usuários anônimos: Y

Desabilitar login remoto do root: Y

Remover banco test: Y

Reload privileges: Y

3️⃣ Criar usuário para o MySQL Workbench (IMPORTANTE)

O Workbench não funciona bem com o root via auth_socket, então criamos um usuário próprio.

Entrar no MySQL:

sudo mysql


Dentro do MySQL:

CREATE USER 'dev'@'localhost' IDENTIFIED WITH mysql_native_password BY 'senha_forte_aqui';
GRANT ALL PRIVILEGES ON *.* TO 'dev'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EXIT;


🔐 Guarde essa senha, você vai usar no Workbench.

4️⃣ Ajustar método de autenticação (se necessário)

Verificar plugin:

mysql -u dev -p -e "SELECT user, host, plugin FROM mysql.user;"


Se precisar forçar:

ALTER USER 'dev'@'localhost' IDENTIFIED WITH mysql_native_password BY 'senha_forte_aqui';
FLUSH PRIVILEGES;

5️⃣ Instalar MySQL Workbench
sudo apt install -y mysql-workbench


Abrir:

mysql-workbench

6️⃣ Configurar conexão no MySQL Workbench

No Workbench:

Connection Name: Local MySQL

Hostname: 127.0.0.1

Port: 3306

Username: dev

Password: Store in Keychain

Clique em Test Connection → OK ✅

7️⃣ (Opcional) Permitir conexão via localhost e 127.0.0.1

Se der erro de conexão:

sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf


Verifique:

bind-address = 127.0.0.1


Reinicie:

sudo systemctl restart mysql

8️⃣ Teste rápido via terminal
mysql -u dev -p


Se conectar, o Workbench vai funcionar sem problemas.

✅ Pronto!

Agora você tem:

✔ MySQL Server rodando

✔ Usuário compatível com Workbench

✔ MySQL Workbench conectado

✔ Ambiente pronto para PHP, Laravel, Node e Python

Se quiser, no próximo passo posso:

🚀 Integrar MySQL com PHP/Laravel

🐳 Subir MySQL no Docker

🔐 Criar usuários por projeto

⚡ Ajustar performance (my.cnf)

Só dizer 👌