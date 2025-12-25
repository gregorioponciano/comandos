composer create-project laravel/laravel:^10.0  ./ ou o nome-projeto      (# Instalar versão específica do Laravel)
composer create-project laravel/laravel exemplo   (# Instalar última versão do Laravel)

php artisan --version (# Verificar versão do Laravel)
			app_key
php artisan key:generate  (# Gerar chave da aplicação)
			flags
Flag	Significado	O que cria
-a	All (tudo)	Model + Migration + Factory + Seeder
-m	Migration	Model + Migration
-c	Controller	Model + Controller
-s	Seeder	Model + Seeder
-f	Factory	Model + Factory
-mc	Migration + Controller	Model + Migration + Controller
-ms	Migration + Seeder	Model + Migration + Seeder
-mf	Migration + Factory	Model + Migration + Factory
-mcs	Migration+Controller+Seeder	Model + Migration + Controller + Seeder
			cache
php artisan optimize:clear # Limpar todo o cache
php artisan config:clear   # Limpar cache de configuração
php artisan config:cache   # Limpar cache de configuração
php artisan route:clear    # Limpar cache de rotas
php artisan route:cache    # Limpar cache de rotas
php artisan view:clear     # Limpar cache de views
php artisan view:cache     # Limpar cache de views
			controller
php artisan make:controller MeuController                                  (# Criar controller básico)
php artisan make:controller ProdutoController --resource                   (# Criar controller com métodos resource (CRUD))
php artisan make:controller ProdutoController --resource --model=Produto   (# Criar controller resource com modelo específico)
php artisan make:controller ProdutoController --api                        (# Criar controller API (sem métodos create/edit))
			model
php artisan make:model Produto                             				(# Criar modelo básico)
php artisan make:model Produto -m                           				(# Criar modelo com migração)
php artisan make:model Produto -ms                          				(# Criar modelo com migração e seeder)
php artisan make:model Produto -a    all                                                (# Criar modelo com migração, seeder, factory e controller)
php artisan make:model Categoria --migration --controller --resource --seed --factory   (# Criar modelo completo (todas as opções))
			migration - rollback + seed
php artisan make:migration create_produtos_table                                        (# Criar migration de tabela)
php artisan make:migration adicionar_coluna_preco_to_produtos_table --table=produtos    (# Criar migration para modificar tabela) 
php artisan make:migration alterar_nome_tabela_produtos                                 (# Criar migration para renomear tabela)
php artisan migrate                                                                     (# Executar migrações)
php artisan migrate --path=database/migrations/nome_arquivo.php                         (# Executar migração específica)
php artisan migrate:status                                                              (# Status das migrações)
php artisan migrate:rollback                                                            (# Rollback da última migração)
php artisan migrate:reset                                                               (# Rollback todas as migrações)
php artisan migrate:refresh                                                             (# Rollback e re-executar migrações)
php artisan migrate:refresh --seed                                                       # Com seeders
php artisan migrate:fresh                                                               (# Deletar e recriar banco completo)
php artisan migrate:fresh --seed                                                         # Com seeders
php artisan migrate --force                                                             (# Forçar migrações (em produção))
			seeders
php artisan make:seeder UsersSeeder      (# Criar seeder)                       
php artisan db:seed                      (# Executar seeders)                               
php artisan db:seed --class=UsersSeeder  (# Executar um seeder especifico)
			factory
php artisan make:factory CategoriaFactory                (# Criar factory)
php artisan make:factory ProdutoFactory --model=Produto  (?)
			banco de dados com tinker
php artisan tinker        (# Popular banco com factories)
>>> \App\Models\Produto::factory()->count(50)->create()  (# Dentro do tinker:)

php artisan make:seeder ProdutoSeeder --force   (# Criar dados fake via seeder)
			breeze
composer require laravel/breeze --dev   (# Instalar Breeze)
php artisan breeze:install blade   (# Instalar Breeze com Blade)
php artisan migrate
npm install && npm run dev
php artisan breeze:install react   (# Instalar Breeze com React)
php artisan breeze:install vue     (# Instalar Breeze com Vue)
			sanctum
composer require laravel/sanctum           (# Instalar Sanctum)
php artisan vendor:publish --provider="Laravel\Sanctum\SanctumServiceProvider"
php artisan migrate
			jetstream
composer require laravel/jetstream      (# Instalar Jetstream com Livewire)
php artisan jetstream:install livewire
php artisan migrate
npm install && npm run build
php artisan jetstream:install inertia   (# Instalar Jetstream com Inertia)
			filament
composer require filament/filament:"^3.3"  		(# baixa Filament versão especifica)
composer require filament/filament        		(# baixa Filament)
php artisan filament:install               		((# Instalar Filament)
php artisan make:filament-panel admin      		(# Criar painel)
php artisan make:filament-resource Produto         	(# Criar recurso)
php artisan make:filament-resource Produto --generate   (?)
php artisan make:filament-widget StatsOverview     	(# Criar widget)
php artisan make:filament-page Relatorios    		(# Criar página)
php artisan make:filament-user                          (# Criar usuário admin)
			packagist darry/cart
composer require darryldecode/cart                      					 (# Instalar Darryldecode Cart)
php artisan vendor:publish --provider="Darryldecode\Cart\CartServiceProvider" --tag="config"     (# Publicar configurações)
php artisan vendor:publish --provider="Darryldecode\Cart\CartServiceProvider" --tag="migrations" (# Publicar migrações (se houver))
			idioma
composer require laravellegends/pt-br-validator   (# Validação em português)

'locale' => 'pt_BR',             (# Configurar idioma. Adicionar em config/app.php)
'fallback_locale' => 'pt_BR',    (# Configurar idioma. Adicionar em config/app.php)
			debug
composer require barryvdh/laravel-debugbar --dev  (# Debugbar para desenvolvimento)
composer require maatwebsite/excel        (# Excel/CSV export)
composer require barryvdh/laravel-dompdf  (# PDF generation)
composer require intervention/image       (# Image intervention)
			middleware
php artisan make:middleware IsAdmin        (# Criar middleware)
php artisan make:middleware CheckRole    (# Criar middleware com parâmetros)
			otmizar
php artisan optimize     	(# Otimizar aplicação)
php artisan cache:clear  	(# Limpar cache bootstrap)
php artisan clear-compiled  	(# Recompilar classes)
composer dump-autoload		(# Atualizar autoload)
composer dump-autoload -o       (# Otimizado)
			atualizar projeto
composer update   (# Atualizar dependências)
composer upgrade  (# Atualizar dependências)

composer show laravel/framework    (# Verificar versões)
composer outdated                  (?)
			teste -unit
php artisan make:test UserTest            (# Criar teste)
php artisan make:test UserTest --unit     (?)
php artisan test                          (# Executar testes)
php artisan test --filter=nome_do_teste   (# Executar testes)
php artisan test --coverage
			banco de dados com tinker
php artisan tinker   (# Iniciar Tinker exemplo para banco de dados) 
>>> \App\Models\User::count()			 	(# Exemplos no Tinker:)
>>> \App\Models\Produto::where('ativo', 1)->get()	(# Exemplos no Tinker:)
>>> $user = \App\Models\User::find(1)			(# Exemplos no Tinker:)
>>> $user->update(['is_admin' => 1])			(# Exemplos no Tinker:)
>>> DB::table('users')->count()         (# Comandos SQL via Tinker)
>>> DB::select('SHOW TABLES') 		(# Comandos SQL via Tinker)
>>> exit                                (# Sair do Tinker)
			jwt
php artisan jwt:secret            		(# Criar chave JWT (se usar jwt-auth))
php artisan passport:install      		(# Criar chave Passport (se usar passport))
php artisan passport:keys	  		(# Criar chave Passport (se usar passport))
php artisan env:encrypt		  		(# Gerar encriptação)
php artisan env:decrypt		  		(# Gerar encriptação)
php artisan down		  		(# Manutenção)
php artisan down --retry=60 	  		(# Manutenção)
php artisan down --secret="senha-temporaria"    (# Manutenção)
php artisan up                    		(# Manutenção)
			atalhos no terminal
Ctrl + C → Cancelar comando atual
Ctrl + D → Sair do Tinker
Ctrl + L → Limpar terminal
Shift + Insert → Colar no terminal (Linux)
Ctrl + V → Colar no terminal (Windows/Mac)
			arquivos de configurações importante
text
.env                    # Variáveis de ambiente
config/app.php         # Configuração geral
config/database.php    # Configuração do banco
config/auth.php        # Configuração de autenticação
config/filesystems.php # Sistema de arquivos

php artisan serve		   # Iniciar servidor local
php artisan serve --port=8080 	   # Iniciar servidor local
php artisan serve --host=0.0.0.0   # Iniciar servidor local

npm run dev
npm run build			   # Compilar assets
npm run watch

php artisan route:list                (# Ver rotas)
php artisan route:list --name=produto
php artisan route:list --method=GET