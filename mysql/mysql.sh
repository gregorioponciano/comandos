# Iniciar/Parar/Reiniciar Serviço

sudo systemctl start mysql        # Iniciar
sudo systemctl stop mysql         # Parar
sudo systemctl restart mysql      # Reiniciar
sudo systemctl status mysql       # Verificar status
sudo systemctl enable mysql       # Habilitar inicialização automática

# Configuração Segura Inicial

sudo mysql_secure_installation     # ?

# CONEXÃO E AUTENTICAÇÃO

# Conectar como root (modo padrão Ubuntu)

sudo mysql
# No Ubuntu, root não precisa de senha inicialmente

# Conectar com autenticação

mysql -u root -p                # Com senha
mysql -u usuario -p             # Usuário específico
mysql -h localhost -u root -p  # Especificar host


#  Dê todos os privilégios para este usuário
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
# Atualize os privilégios
FLUSH PRIVILEGES;

# Usuário atual e host
SELECT USER();

#Usuário atual e privilégios
SELECT CURRENT_USER();

# Veja os usuários que existem
SELECT User, Host FROM mysql.user;

# Host de conexão
SELECT SUBSTRING_INDEX(USER(), '@', -1) AS host;

# Usuário sem host
SELECT SUBSTRING_INDEX(USER(), '@', 1) AS usuario;

# Alterar método de autenticação root (se necessário)
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Nova@lei187';
FLUSH PRIVILEGES;  # senhas forte com letras maiuscula @ e numeros 


# 🛠️ COMANDOS ADMINISTRATIVOS DENTRO DO MYSQL
SHOW DATABASES;
CREATE DATABASE nome_banco;
CREATE DATABASE nome_banco CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE nome_banco;
SHOW TABLES; # use banco depois show table

# Mostrar estrutura da tabela
DESCRIBE nome_tabela;
DESC nome_tabela;  # Forma abreviada
SHOW CREATE TABLE nome_tabela;  # Mostra comando completo de criação

# 👥 GERENCIAMENTO DE USUÁRIOS E PRIVILÉGIOS

# Criar usuário
CREATE USER 'gregorio'@'localhost' IDENTIFIED BY 'Nova@lei187'; # senhas forte com letras maiuscula @ e numeros 
CREATE USER 'usuario'@'%' IDENTIFIED BY 'senha';  # Acesso de qualquer host

# Conceder privilégios
GRANT ALL PRIVILEGES ON banco.* TO 'usuario'@'localhost';
GRANT SELECT, INSERT, UPDATE ON banco.tabela TO 'usuario'@'localhost';
GRANT CREATE, DROP ON *.* TO 'admin'@'localhost';
GRANT ALL PRIVILEGES ON banco_de_dados.* TO 'usuario'@'localhost'; # Conceder todos privilégios em UM banco específico
GRANT ALL PRIVILEGES ON banco_de_dados.* TO 'usuario'@'localhost' IDENTIFIED BY 'senha_forte'; # Com identificação de senha na mesma linha

# Aplicar privilégios imediatamente
FLUSH PRIVILEGES;

# Revogar privilégios
REVOKE ALL PRIVILEGES ON banco.* FROM 'usuario'@'localhost';

# Mostrar privilégios de um usuário
SHOW GRANTS FOR 'usuario'@'localhost';

# Alterar senha de usuário
ALTER USER 'usuario'@'localhost' IDENTIFIED BY 'nova_senha';

# Excluir usuário
DROP USER 'usuario'@'localhost';

# 💾 BACKUP E RESTAURAÇÃO

# Backup de todos os bancos
sudo mysqldump --all-databases > backup_completo.sql

# Backup de banco específico
sudo mysqldump nome_banco > backup_banco.sql

# Backup com compressão
sudo mysqldump nome_banco | gzip > backup_banco.sql.gz

# Backup com usuário e senha
sudo mysqldump -u root -p nome_banco > backup.sql

# Backup de tabela específica

sudo mysqldump nome_banco nome_tabela > backup_tabela.sql

# Restauração (fora do MySQL)

# Restaurar banco completo
sudo mysql nome_banco < backup_banco.sql

# Restaurar todos os bancos
sudo mysql < backup_completo.sql

# Restaurar backup comprimido
gunzip < backup_banco.sql.gz | sudo mysql nome_banco

# 📊 CONSULTAS E INFORMAÇÕES DO SISTEMA

SELECT VERSION();                  # Ver versão do MySQL
SHOW VARIABLES LIKE '%version%';   # Ver versão do MySQL
STATUS;                            # Ver status do servidor
\s                  # No mysql client
SHOW VARIABLES;                         # Ver variáveis de configuração
SHOW VARIABLES LIKE 'port%';            # Ver variáveis de configuração
SHOW VARIABLES LIKE 'max_connections%'; # Ver variáveis de configuração
SHOW PROCESSLIST;                       # Ver processos em execução
KILL id_processo;                       # ID mostrado no SHOW PROCESSLIST
SHOW ENGINES;                           # Ver engines disponíveis



# Excluir tabela
DROP TABLE nome_tabela;      # Exclui tabela e dados
TRUNCATE TABLE nome_tabela;  # Remove todos os dados, mantém estrutura

# Alterar tabela
ALTER TABLE tabela ADD COLUMN nova_coluna VARCHAR(50);
ALTER TABLE tabela DROP COLUMN coluna;
ALTER TABLE tabela MODIFY COLUMN coluna TEXT;
ALTER TABLE tabela RENAME TO novo_nome;

# Verifique a configuração do MySQL
sudo grep -r "port" /etc/mysql/
sudo cat /etc/mysql/mysql.conf.d/mysqld.cnf | grep port

# Se quiser mudar para porta 3306 padrão
sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf # Encontre a linha port = 3306 e mude





