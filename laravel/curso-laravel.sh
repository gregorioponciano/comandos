composer create-project laravel/laravel:^10.0 ./ (PARA INSTALAR A VERSAO 10 DO LARAVEL)
composer create-project laravel/laravel exemplo  (CRIA UM PROJETO COM A ULTIMA VERSAO DO LARAVEL)
php artisan --version 					(MOSTRA A VERSAO DO FRAMEWORK DO LARAVEL)


php artisankey:generate     (GERA A CHAVE NO ARQUIVO .env APP_KEY=base64dfnsifniusdrs....)

php artisan make:controller ProdutoControllers --resource (CRIA UM ARQUIVO COM AS ROTA PRONTAS PARA CRIAR EDITAR DELETAR TABELAAS app/http/controller)
php artisan make:model Categoria --migration --controller --resource    (CRIA TODOS OS ARQUIVOS JA PARA MANIPULAR controller migrations models)

php artisan make:migration create_produtos_table  (CRIA UMA TABELA EM database/migrations)
php artisan make:migration alterar_nome_tabela_produtos (CRIE ESTA TABELA PARA MUDAR O NOME DE OUTRA TABELA DENTRO DO SEU CODIGO)
	
php artisan migrate:reset   (RESETA TODAS AS MIGRAÇOES)
php artisan migrate:refresh (RESETA E REINICIA OS MIGRATION DENTRO DO BANCO DE DADOS)
php artisan migrate:fresh       (DELETA TODO O BANCO DE DADOS E REINSTALA AS MIGRAÇOES)

php artisan migrate  		(EXECUTA O BANCO DE DADOS COM OS PRODUTOS)
php artisan migrate:rollback	(DEFAZER A ULTIMA MIGRAÇAO)
php artisan migrate:status      (STATUS DO BANCO SE FOI EXECUTADO OU NAO)
composer upgrade     (ATUALIZA O COMPOSER)

composer require doctrine/dbal  (PACOTE PARA MODIFICAR AS TABELAS E COLUNAS EXCLUIR COLUNAS)

php artisan make:seeder UsersSeeder	          (Seeder: dados fixos, importantes, que você precisa no sistema.)
php artisan db:seed --class=UsersSeeder	 (→ indica qual seeder específico você quer rodar (neste caso, o UsersSeeder)).

php artisan make:factory CategoriaFactory  	(Factory: dados falsos/aleatórios, geralmente para teste ou povoar tabelas em dev.)
php artisan db:seed

composer require laravel/breeze --dev      (BAIXA O BREEZE PARA O PROJETO)-cria rotas como /login /registro /dashboard /profile
php artisan breeze:install blade	   (INSTALA O BREEZE NO PROJETO)
php artisan migrate			   (ATUALIZE O BANCO DE DADOS)

composer require laravellegends/pt-br-validator

php artisan make:middleware IsAdmin (cria um arquivo em App\Http\MiddkewarezIsadmin pronto para editar um adm do site lembre-se de criar na tabela user a coluna is_admin)
UPDATE users SET is_admin = 1 WHERE email = 'admin@demo.com';   (use para criar um cargo adm para o email admin@demo.com)

composer global require "filament/filament:^3.0" --with-all-dependencies  (globalmente no seu sistema não recomendado)
composer require filament/filament:"^2.0"  (BAIXA O FILAMENT PARA O PROJETO confira a versao)
php artisan filament:install               (INSTALA O FILAMENT NO PROJETO)
php artisan filament:install --panels     (CRIA UMA ROTA PARA O ADM)
php artisan make:filament-user             (CRIA UM ADMIN DO FILAMENT NO TERMINAL BASTA DIGITAR O NOME EMAIL E SENHA)
php artisan make:filament-resource Produto  (Isso vai gerar as telas de listagem, formulário e edição automaticamente, já puxando os dados do MySQL)



composer require darryldecode/cart    (INSTALA O PACOTE CARRINHO)
php artisan vendor:publish --provider="Darryldecode\Cart\CartServiceProvider" --tag="config" (PUBLICA O ARQUIVO DE CONFIGURAÇAO ISSO CRIA config/cart.php)
) 



php artisan jwt:secret (Esse "token" é o token de autenticação (JWT, Sanctum ou Passport). O erro aparece porque o Laravel não conseguiu gerar esse token ao validar seu login. Normalmente é problema de senha incorreta, chave JWT ausente, ou configuração errada no .env)



php artisan tinker 

Shift + Insert → funciona como “colar” dentro do tinker


