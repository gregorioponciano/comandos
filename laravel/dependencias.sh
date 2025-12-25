composer show laravel/framework
# ↑ Mostra detalhes do pacote Laravel
composer remove laravel/sanctum
#Para remover completamente o Sanctum
# Para outras dependências, substitua laravel/sanctum pelo nome do pacote.

🔐 Autenticação

# 1. Laravel Breeze (Recomendado para 2024)

composer require laravel/breeze --dev
# ↑ Instala o Breeze APENAS para desenvolvimento (--dev)
php artisan breeze:install
# ↑ Instala a interface de autenticação básica (Blade/API)
php artisan breeze:install vue
# ↑ Instala Breeze com VUE.js no frontend
php artisan breeze:install react
# ↑ Instala Breeze com REACT.js no frontend
npm install && npm run dev
# ↑ DEPOIS do Breeze, instala dependências NPM e compila


# 2. Laravel UI (Legado - EVITE no Laravel 12)

composer require laravel/ui
# ↑ Instala pacote LEGADO de autenticação (não recomendado para Laravel 12)
php artisan ui bootstrap --auth
# ↑ Gera views com Bootstrap + sistema de login/registro
php artisan ui vue --auth
# ↑ Gera views com Vue + autenticação


# 3. Laravel Sanctum (APIs)

composer require laravel/sanctum
# ↑ Instala sistema de autenticação para APIs (tokens)
php artisan vendor:publish --provider="Laravel\Sanctum\SanctumServiceProvider"
# ↑ Publica arquivos de configuração do Sanctum
php artisan migrate
# ↑ Cria tabela 'personal_access_tokens' no banco de dados


# 4. Laravel Socialite (Login Social)

composer require laravel/socialite
# ↑ Instala sistema de login com Facebook, Google, GitHub, etc.


🎨 Frontend & Styling

# 1. Filament v3 (Admin Panel Moderno)

composer require filament/filament:"^3.0"
# ↑ Instala Filament v3 (COMPATÍVEL com Laravel 12)
php artisan filament:install --panels
# ↑ Configura Filament no projeto
php artisan make:filament-user
# ↑ Cria primeiro usuário admin do Filament


# 2. Livewire v3 (Componentes Dinâmicos)

composer require livewire/livewire
# ↑ Instala Livewire (cria componentes PHP dinâmicos sem JS)
php artisan livewire:publish --config
# ↑ Publica arquivo de configuração do Livewire
php artisan make:livewire CreatePost
# ↑ Cria um novo componente Livewire chamado 'CreatePost'

# 3. Tailwind CSS (Framework CSS Moderno)

npm install -D tailwindcss postcss autoprefixer
# ↑ Instala Tailwind + dependências como DEV dependencies (-D)
npm install -D tailwindcss@3 postcss autoprefixer
# para instalar outra versao (Tailwind CSS v4 NÃO vem mais com o CLI embutido.)
npx tailwindcss init -p
# ↑ Cria arquivos de configuração: tailwind.config.js e postcss.config.js
npm run dev
# ↑ Compila CSS com Tailwind (depois de configurar)


# 4. Bootstrap 5 (Framework CSS Tradicional)

npm install bootstrap @popperjs/core
# ↑ Instala Bootstrap 5 e Popper.js (para dropdowns/tooltips)
# No arquivo app.js ou resources/js/app.js adicione:
import 'bootstrap';
import 'bootstrap/dist/css/bootstrap.min.css';



🗄️ Banco de Dados & ORM

# 1. Spatie Laravel Permission (Controle de Acessos)

composer require "spatie/laravel-permission:^6.0"
# ↑ Instala sistema de roles (papéis) e permissions (permissões)
php artisan vendor:publish --provider="Spatie\Permission\PermissionServiceProvider"
# ↑ Publica migrations e configurações
php artisan migrate
# ↑ Cria tabelas: roles, permissions, model_has_permissions, etc.
php artisan make:seeder PermissionSeeder
# ↑ Cria seeder para popular roles/permissions iniciais


# 2. Spatie Media Library (Uploads de Arquivos)

composer require "spatie/laravel-medialibrary:^11.0"
# ↑ Instala sistema para upload e gerenciamento de mídias

php artisan vendor:publish --provider="Spatie\MediaLibrary\MediaLibraryServiceProvider"
# ↑ Publica arquivo de configuração
php artisan migrate
# ↑ Cria tabela 'media' no banco
# No Model que vai ter mídias:
use HasMedia;
use InteractsWithMedia;



🔌 APIs & HTTP Clients

# 1. Guzzle HTTP (Requisições Externas)

composer require guzzlehttp/guzzle
# ↑ Instala cliente HTTP para fazer requisições para APIs externas
# Exemplo de uso:
use GuzzleHttp\Client;
$client = new Client();
$response = $client->get('https://api.example.com');


# 2. Laravel HTTP Client (Já Vem com Laravel)

# Não precisa instalar, já vem com Laravel 12
# Exemplo:
Http::get('https://api.example.com/users');
Http::post('https://api.example.com/users', ['name' => 'John']);



📧 Email & Notifications

# 1. Configurar Email

php artisan make:mail WelcomeEmail
# ↑ Cria classe para enviar emails (app/Mail/WelcomeEmail.php)
php artisan make:notification InvoicePaid
# ↑ Cria notificação (app/Notifications/InvoicePaid.php)
# Configurar .env com:
MAIL_MAILER=smtp
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=seuemail@gmail.com
MAIL_PASSWORD=sua-senha-app
MAIL_ENCRYPTION=tls



🔍 Debugging & Development

# 1. Laravel Debugbar (Debugging Visual)

composer require barryvdh/laravel-debugbar --dev
# ↑ Instala barra de debug na parte inferior da página (APENAS desenvolvimento)
# Aparece automaticamente em localhost
# Mostra queries SQL, rotas, views carregadas, etc.

# 2. Laravel IDE Helper (Autocomplete Melhor)

composer require barryvdh/laravel-ide-helper --dev
# ↑ Melhora autocomplete no VSCode/PHPStorm
php artisan ide-helper:generate
# ↑ Gera arquivo _ide_helper.php para melhor autocomplete
php artisan ide-helper:models
# ↑ Gera PHPDoc para todos os Models
php artisan ide-helper:meta
# ↑ Gera metadados para o editor entender facades

# 3. Laravel Telescope (Painel de Monitoramento)

composer require laravel/telescope --dev
# ↑ Instala painel completo para monitorar app (como requests, exceptions, jobs)
php artisan telescope:install
# ↑ Publica assets e configurações
php artisan migrate
# ↑ Cria tabelas do Telescope no banco
php artisan telescope:publish
# ↑ Publica arquivos de configuração para personalizar
# Acesse em: http://seu-site.test/telescope

# 🛡️ Segurança 

# 1. Laravel Honeypot (Proteção contra Spam)

composer require spatie/laravel-honeypot
# ↑ Adiciona campo "honeypot" invisível em formulários para bloquear bots
php artisan vendor:publish --provider="Spatie\Honeypot\HoneypotServiceProvider"
# ↑ Publica configurações
// No form blade:
@honeypot

# 2. Laravel Backup (Backup Automático)

composer require spatie/laravel-backup
# ↑ Cria backups automáticos do banco e arquivos
php artisan vendor:publish --provider="Spatie\Backup\BackupServiceProvider"
# ↑ Publica arquivo config/backup.php
php artisan backup:run
# ↑ Executa backup manualmente
php artisan backup:clean
# ↑ Limpa backups antigos



📁 Uploads & Storage

# 1. Intervention Image (Manipulação de Imagens)

composer require intervention/image
# ↑ Instala biblioteca para redimensionar, cortar, comprimir imagens
# Exemplo:
Image::make('photo.jpg')->resize(300, 200)->save('thumb.jpg');

# 2. Laravel Excel (Importar/Exportar Excel)

composer require maatwebsite/excel
# ↑ Importa/exporta arquivos Excel/CSV
php artisan vendor:publish --provider="Maatwebsite\Excel\ExcelServiceProvider"
# ↑ Publica configurações
php artisan make:export UsersExport
# ↑ Cria classe para exportar dados

# 3. Laravel DomPDF (Gerar PDFs)

composer require barryvdh/laravel-dompdf
# ↑ Converte views HTML em arquivos PDF
# Exemplo:
return PDF::loadView('invoice', $data)->download('invoice.pdf');



🔄 Cache & Performance

# 1. Redis Cache (Cache em Memória)

composer require predis/predis
# ↑ Instala cliente Redis para PHP (alternativa: phpredis/phpredis)
# Configurar .env:
CACHE_DRIVER=redis
REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379

# 2. Laravel Octane (Performance Boost)

composer require laravel/octane
# ↑ Acelera Laravel usando Swoole ou RoadRunner
php artisan octane:install
# ↑ Configura Octane no projeto
php artisan octane:start
# ↑ Inicia servidor Octane (muito mais rápido que artisan serve)



📊 Queues & Jobs

# 1. Laravel Queues (Filas de Processamento)

php artisan queue:table
# ↑ Cria migration para tabela de jobs
php artisan migrate
# ↑ Executa migration
php artisan make:job ProcessPodcast
# ↑ Cria job para processamento em background
php artisan queue:work
# ↑ Inicia worker para processar jobs da fila

# 2. Laravel Horizon (Dashboard para Redis Queues)

composer require laravel/horizon
# ↑ Painel bonito para monitorar filas Redis
php artisan horizon:install
# ↑ Configura Horizon
php artisan horizon
# ↑ Inicia Horizon dashboard



🌐 Internacionalização (Multi-idiomas)

# 1. mcamara/laravel-localization

composer require mcamara/laravel-localization
# ↑ Adiciona suporte a múltiplos idiomas no Laravel
php artisan vendor:publish --provider="Mcamara\LaravelLocalization\LaravelLocalizationServiceProvider"
# ↑ Publica configurações
# URLs ficam: /en/products, /pt/produtos, /es/productos


🧪 Testing

# 1. Pest PHP (Framework de Testes Moderno)

composer require pestphp/pest --dev --with-all-dependencies
# ↑ Instala Pest (alternativa ao PHPUnit)
php artisan pest:install
# ↑ Configura Pest no projeto
php artisan make:test UserTest --pest
# ↑ Cria teste usando Pest
./vendor/bin/pest
# ↑ Executa todos os testes


# 2. Laravel Dusk (Testes no Navegador)

composer require laravel/dusk --dev
# ↑ Instala Dusk para testar como se fosse um usuário real
php artisan dusk:install
# ↑ Configura Dusk
php artisan dusk:make LoginTest
# ↑ Cria teste de navegador
php artisan dusk
# ↑ Executa testes Dusk








































📦 Comandos Úteis Gerais
Manutenção e Limpeza
bash
php artisan optimize:clear
# ↑ Limpa TUDO: cache, views, routes, config, compiled

php artisan cache:clear
# ↑ Limpa apenas cache da aplicação

php artisan view:clear
# ↑ Limpa cache de views compiladas

php artisan route:clear
# ↑ Limpa cache de rotas

php artisan config:clear
# ↑ Limpa cache de configurações

php artisan migrate:fresh --seed
# ↑ APAGA todas tabelas e recria + roda seeders (CUIDADO!)
Criar Classes
bash
php artisan make:model Product -mcr
# ↑ Cria Model, Migration, Controller e Resource (tudo junto)
# -m = migration, -c = controller, -r = resource

php artisan make:controller ProductController --resource
# ↑ Cria controller com métodos CRUD prontos

php artisan make:middleware CheckAdmin
# ↑ Cria middleware para verificar se usuário é admin

php artisan make:request StoreProductRequest
# ↑ Cria Form Request para validação
Ver Informações
bash
php artisan route:list
# ↑ Mostra TODAS as rotas da aplicação

php artisan tinker
# ↑ Abre console interativo para testar código Laravel

php artisan --version
# ↑ Mostra versão do Laravel instalada

composer show laravel/framework
# ↑ Mostra detalhes do pacote Laravel
🚀 Script de Instalação Completa
Para Iniciante - Projeto Laravel 12 Completo:
bash
# 1. CRIAR PROJETO (Laravel 12)
composer create-project laravel/laravel meu-ecommerce
# ↑ Cria projeto novo com Laravel 12

cd meu-ecommerce
# ↑ Entra na pasta do projeto

# 2. AUTENTICAÇÃO (Breeze + Vue)
composer require laravel/breeze --dev
# ↑ Instala Breeze para desenvolvimento

php artisan breeze:install vue
# ↑ Instala autenticação com Vue.js

# 3. BANCO DE DADOS (criar .env primeiro!)
cp .env.example .env
# ↑ Copia arquivo de ambiente

php artisan key:generate
# ↑ Gera chave de segurança da aplicação

# Edite .env com suas credenciais de banco:
# DB_DATABASE=laravel
# DB_USERNAME=root
# DB_PASSWORD=

php artisan migrate
# ↑ Cria tabelas no banco de dados

# 4. DEPENDÊNCIAS NPM (Frontend)
npm install
# ↑ Instala Vue, Tailwind, Vite e outras dependências

npm run build
# ↑ Compila JavaScript e CSS para produção

# 5. PACOTES IMPORTANTES
composer require laravel/sanctum
# ↑ Para autenticação via API (se fizer mobile/app)

composer require spatie/laravel-permission
# ↑ Para sistema de roles (admin, user, editor)

composer require barryvdh/laravel-debugbar --dev
# ↑ Para ver queries SQL e debugar (só em desenvolvimento)

php artisan vendor:publish --provider="Spatie\Permission\PermissionServiceProvider"
php artisan migrate
# ↑ Publica e executa migrations do Spatie Permission

# 6. TESTAR APLICAÇÃO
php artisan serve
# ↑ Inicia servidor local em http://localhost:8000

# 7. CRIAR USUÁRIO ADMIN
php artisan tinker
# No tinker:
$user = App\Models\User::create(['name'=>'Admin', 'email'=>'admin@test.com', 'password'=>bcrypt('123456')]);
$user->assignRole('admin');
⚠️ Notas Importantes Laravel 12:
NÃO TEM Kernel.php - Middlewares são em bootstrap/app.php:

php
// Em bootstrap/app.php:
->withMiddleware(function (Middleware $middleware) {
    $middleware->alias([
        'auth' => \App\Http\Middleware\Authenticate::class,
        'admin' => \App\Http\Middleware\CheckAdmin::class,
    ]);
})
Service Providers - Muitos removidos, adicione em bootstrap/providers.php

Sempre verifique compatibilidade:

bash
composer why laravel/framework
# ↑ Mostra por que um pacote está instalado

composer outdated
# ↑ Mostra pacotes desatualizados

composer update --dry-run
# ↑ Simula update para ver se quebra algo
Laravel 12 precisa PHP 8.2+:

bash
php -v
# ↑ Verifique se tem PHP 8.2 ou 8.3

composer check-platform-reqs
# ↑ Verifica requisitos do sistema