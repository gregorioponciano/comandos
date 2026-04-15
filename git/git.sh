                Arsenal de Comandos Git - Guia Completo
ssh

ls -al ~/.ssh
ssh-keygen -t ed25519 -C "seu_email@exemplo.com"
cat ~/.ssh/id_ed25519.pub
ssh -T git@github.com

Para que o Git use SSH em um repositório existente, a URL remota deve usar o formato SSH, não HTTPS. Você pode conferir e alterar com: 

# Ver URL atual
git remote -v

# Alterar para SSH (exemplo GitHub)
git remote set-url origin git@github.com:USUARIO/REPOSITORIO.git


# 📋 CONFIGURAÇÃO INICIAL

# Configurar usuário

# Configurar nome de usuário global
git config --global user.name "Seu Nome"

# Configurar email global
git config --global user.email "seu@email.com"

# Configurar editor padrão
git config --global core.editor "code --wait"  # VS Code
git config --global core.editor "vim"          # Vim
git config --global core.editor "nano"         # Nano

# Listar todas as configurações
git config --list

# Verificar configuração específica
git config user.name
git config user.email

# Configurar alias (atalhos)
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status


# Configurações úteis #

# Habilitar coloração
git config --global color.ui auto
# Configurar linha de comando para mostrar branch atual (bash)
git config --global prompt.sh true
# Configurar merge tool
git config --global merge.tool vimdiff
# Configurar padrão de linha (importante para Windows/Linux)
git config --global core.autocrlf true      # Windows
git config --global core.autocrlf input     # Linux/Mac


# 📁 REPOSITÓRIOS

# Inicializar repositório

# Inicializar novo repositório
git init
# Inicializar com branch main (nova convenção)
git init -b main
# Clonar repositório existente
git clone https://github.com/usuario/repositorio.git
# Clonar com nome específico
git clone https://github.com/usuario/repositorio.git meu-projeto
# Clonar apenas branch específica
git clone -b develop --single-branch https://github.com/usuario/repositorio.git
# Clonar com profundidade limitada (shallow clone)
git clone --depth 1 https://github.com/usuario/repositorio.git


# Repositórios remotos

# Verificar remotos
git remote -v
# Adicionar remote
git remote add origin https://github.com/usuario/repositorio.git
# Alterar URL do remote
git remote set-url origin https://github.com/usuario/novo-repositorio.git
# Renomear remote
git remote rename origin upstream
# Remover remote
git remote remove origin
# Mostrar informações do remote
git remote show origin

# 📝 TRABALHO DIÁRIO - ESTADO E ATUALIZAÇÃO

# Verificar status

# Status básico
git status
# Status resumido
git status -s
git status --short

# Mostrar branch no prompt (bash)
export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 " (%s)")\$ '


# Adicionar arquivos

# Adicionar arquivo específico
git add arquivo.txt
# Adicionar todos os arquivos modificados
git add .
# Adicionar arquivos interativamente
git add -i
git add -p  # Patch mode - adiciona partes específicas
# Adicionar todos os arquivos (incluindo deletados)
git add -A
git add --all
# Adicionar arquivos por extensão
git add *.js
# Adicionar arquivos de um diretório
git add src/

# Commits

# Commit com mensagem
git commit -m "Mensagem do commit"
# Commit com mensagem multi-linha
git commit -m "Título" -m "Descrição detalhada"
# Adicionar e commitar em um comando
git commit -am "Mensagem"
# Alterar último commit
git commit --amend
# Alterar último commit mantendo mensagem
git commit --amend --no-edit
# Abrir editor para commit interativo
git commit
# Commit vazio (útil para tags)
git commit --allow-empty -m "Iniciando projeto"
# Commit com data específica
git commit --date="2024-01-01T12:00:00" -m "Commit com data específica"

# 🔄 HISTÓRICO E LOG

# Visualizar histórico

# Histórico completo
git log

# Histórico resumido (uma linha por commit)
git log --oneline

# Histórico com gráfico de branches
git log --oneline --graph --all

# Histórico com estatísticas
git log --stat

# Histórico com diff
git log -p

# Histórico por autor
git log --author="Nome"

# Histórico por período
git log --since="2024-01-01"
git log --until="2024-12-31"
git log --since="2 weeks ago"
# Histórico por número de commits
git log -10  # Últimos 10 commits
# Histórico de arquivo específico
git log -- arquivo.txt
# Histórico com busca na mensagem
git log --grep="bug"
# Histórico formatado
git log --pretty=format:"%h - %an, %ar : %s"

# Outras formas de visualizar

# Mostrar quem modificou cada linha
git blame arquivo.txt
# Mostrar resumo do repositório
git shortlog
# Mostrar resumo por autor
git shortlog -s -n
# Mostrar referências (tags, branches)
git show-ref
# Visualizar árvore do repositório
git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit


# 🌿 BRANCHES

# Gerenciamento de branches

# Listar branches locais
git branch
# Listar branches remotas
git branch -r
# Listar todas as branches
git branch -a
# Criar nova branch
git branch nova-branch
# Criar e mudar para branch
git checkout -b nova-branch
# Mudar para branch existente
git checkout nome-branch
# Mudar para branch anterior
git checkout -
# Renomear branch
git branch -m nome-antigo nome-novo
# Deletar branch local
git branch -d nome-branch
# Forçar deleção de branch
git branch -D nome-branch
# Deletar branch remota
git push origin --delete nome-branch


# Tracking branches

# Configurar upstream (tracking)
git branch --set-upstream-to=origin/main main
# Verificar branches com tracking
git branch -vv
# Criar branch com tracking
git checkout -b nova-branch origin/develop

# 🔀 MERGE E REBASE

# Merge

# Merge de branch para branch atual
git merge nome-branch
# Merge com commit
git merge --no-ff nome-branch
# Merge sem commit automático
git merge --no-commit nome-branch
# Abortar merge em conflito
git merge --abort
# Continuar merge após resolver conflitos
git merge --continue

# Rebase

# Rebase interativo
git rebase -i HEAD~3
# Rebase da branch atual sobre main
git rebase main
# Rebase com squash
git rebase -i HEAD~5  # Depois trocar 'pick' por 'squash'
# Continuar rebase após resolver conflitos
git rebase --continue
# Pular commit durante rebase
git rebase --skip
# Abortar rebase
git rebase --abort

# ⚡ STASH

# Guardar alterações temporárias

# Guardar alterações
git stash
# Guardar com mensagem
git stash save "Mensagem descritiva"
# Guardar incluindo arquivos não trackeados
git stash -u
# Guardar tudo (incluindo ignored)
git stash -a
# Listar stashes
git stash list
# Aplicar último stash
git stash apply
# Aplicar stash específico
git stash apply stash@{2}
# Aplicar e remover do stash
git stash pop
# Criar branch a partir de stash
git stash branch nome-branch stash@{1}
# Ver diff do stash
git stash show -p stash@{0}
# Limpar todos os stashes
git stash clear
# Deletar stash específico
git stash drop stash@{1}

# 📤 PUSH E PULL

# Enviar para remoto

# Push para branch atual
git push
# Push para branch específica
git push origin nome-branch
# Push forçado (CUIDADO!)
git push --force
git push --force-with-lease  # Mais seguro
# Push com tags
git push --tags
# Push para upstream configurado
git push -u origin nome-branch
# Push deletando branch remota
git push origin :nome-branch

# Receber do remoto

# Fetch (apenas baixa, não merge)
git fetch
# Fetch de remote específico
git fetch origin
# Fetch todas as branches
git fetch --all
# Pull (fetch + merge)
git pull
# Pull com rebase
git pull --rebase
# Pull de branch específica
git pull origin nome-branch

# 🏷️ TAGS

# Gerenciamento de tags

# Listar tags
git tag
# Listar tags com padrão
git tag -l "v1.*"
# Criar tag leve
git tag v1.0.0
# Criar tag anotada
git tag -a v1.0.0 -m "Versão 1.0.0"
# Criar tag em commit específico
git tag v1.0.0 abc123
# Mostrar informações da tag
git show v1.0.0
# Deletar tag local
git tag -d v1.0.0
# Deletar tag remota
git push origin --delete v1.0.0
# Push de tags para remoto
git push origin --tags
# Push de tag específica
git push origin v1.0.0
# Checkout de tag
git checkout v1.0.0

# 🔍 DIFF E COMPARAÇÕES

# Ver diferenças

# Diff não staged
git diff
# Diff staged
git diff --staged
git diff --cached
# Diff entre branches
git diff main..develop
# Diff entre commits
git diff abc123..def456
# Diff de arquivo específico
git diff -- arquivo.txt
# Diff estatístico
git diff --stat
# Diff por palavra
git diff --word-diff
# Diff entre HEAD e working directory
git diff HEAD
# Diff visual (usando ferramenta configurada)
git difftool

# Comparações específicas

# O que será commitado
git diff --cached HEAD
# Mudanças desde último commit
git diff HEAD~
# Mudanças de um autor
git log -p --author="nome"

# ↩️ DESFAZER COISAS

# Desfazer modificações

# Descartar mudanças não commitadas
git checkout -- arquivo.txt
# Descartar todas as mudanças não commitadas
git checkout -- .
# Reset staged (tira da área de staging)
git reset HEAD arquivo.txt
# Reset suave (mantém mudanças no working directory)
git reset --soft HEAD~1
# Reset misto (default - mantém working, remove staging)
git reset --mixed HEAD~1
# Reset hard (PERIGOSO - descarta tudo)
git reset --hard HEAD~1
# Reset para commit específico
git reset --hard abc123
# Reverter commit (cria novo commit desfazendo)
git revert abc123
# Reverter merge
git revert -m 1 abc123

# Recuperar commits perdidos

# Ver reflog (histórico de ações)
git reflog
# Recuperar commit do reflog
git reset --hard HEAD@{2}
# Ver commits órfãos
git fsck --lost-found

# 🧹 LIMPEZA

# Limpar arquivos

# Ver o que será removido
git clean -n
# Remover arquivos não trackeados
git clean -f
# Remover diretórios não trackeados
git clean -fd
# Remover também arquivos ignored
git clean -xfd
# Interativo
git clean -i

# 🔧 COMANDOS AVANÇADOS

# Bisect (encontrar bug)

# Iniciar bisect
git bisect start
# Marcar commit como ruim
git bisect bad
# Marcar commit como bom
git bisect good abc123
# Automatizar com script
git bisect run npm test
# Finalizar bisect
git bisect reset

# Cherry-pick

# Aplicar commit específico
git cherry-pick abc123
# Aplicar sem commit automático
git cherry-pick -n abc123
# Continuar após conflito
git cherry-pick --continue

# Submódulos

# Adicionar submódulo
git submodule add https://github.com/usuario/repo.git
# Inicializar submódulos
git submodule init
# Atualizar submódulos
git submodule update
# Atualizar recursivo
git submodule update --init --recursive
# Status de submódulos
git submodule status

# Worktree

# Adicionar worktree
git worktree add ../nova-pasta nome-branch
# Listar worktrees
git worktree list
# Remover worktree
git worktree remove ../nova-pasta

# Patch

# Criar patch
git format-patch HEAD~3
# Aplicar patch
git apply arquivo.patch
# Verificar patch
git apply --check arquivo.patch

# 📊 ESTATÍSTICAS E INSIGHTS

# Estatísticas de commits por autor
git shortlog -s -n --all
# Linhas de código por autor
git log --pretty=format:"%an" --numstat | awk '{author=$1; added+=$2; deleted+=$3} END {print author, "+"added, "-"deleted}'
# Histórico de arquivo
git log --follow -p -- arquivo.txt
# Arquivos mais modificados
git log --pretty=format: --name-only | sort | uniq -c | sort -rg | head -10
# Heatmap de commits
git log --pretty=format:"%ad" --date=short | uniq -c
# Tamanho do repositório
git count-objects -vH
# Verificar integridade
git fsck

# 🚨 COMANDOS DE EMERGÊNCIA

# Recuperação de dados

# Recuperar arquivo deletado não commitado
git fsck --lost-found
# Ver arquivos em .git/lost-found/

# Recuperar branch deletada
git reflog
git checkout -b branch-recuperada HEAD@{3}

# Desfazer push forçado
git reflog
git reset --hard HEAD@{5}
git push --force


# Correção de problemas comuns 

# Reparar permissões de arquivos
git config core.filemode false
# Ignorar alterações de linha (CRLF/LF)
git config core.autocrlf true
# Corrigir merge conflitado
git reset --merge
# Limpar cache de credenciais
git credential-cache exit
# Reparar referências corrompidas
git update-ref -d REF


🎯 WORKFLOWS E BOAS PRÁTICAS

# Commit semântico

# Padrão: tipo(escopo): descrição
git commit -m "feat(login): adiciona autenticação OAuth"
git commit -m "fix(api): corrige timeout na requisição"
git commit -m "docs(readme): atualiza instruções de instalação"
git commit -m "style(css): formatação do código"
git commit -m "refactor(auth): extrai lógica de validação"
git commit -m "test(login): adiciona testes de integração"
git commit -m "chore(deps): atualiza dependências"

# Git Hooks (exemplos)

# 🛠️ FERRAMENTAS EXTERNAS E INTEGRAÇÕES

# GUI integrada
git gui
gitk

# Buscar por string no histórico
git log -S "funcionalidade" --oneline
# Ver mudanças em arquivo entre branches
git diff main...feature -- arquivo.txt
# Ver commits únicos de uma branch
git log main..feature --oneline
# Ver commits comuns entre branches
git log main...feature --oneline --left-right

# 📋 GIT LFS

# Instalação 

# Ubuntu/Debian
sudo apt-get install git-lfs

# macOS (Homebrew)
brew install git-lfs

# Windows (Chocolatey)
choco install git-lfs

# Ou baixar do site oficial:
https://git-lfs.github.com/

# Configuração inicial

# Inicializar Git LFS no repositório
git lfs install
# Verificar se está instalado
git lfs version
# Verificar status da instalação
git lfs env
# Atualizar Git LFS
git lfs update

# 📝 CONFIGURANDO ARQUIVOS PARA TRACKING

# Padrões básicos

# Trackear por extensão
git lfs track "*.psd"
git lfs track "*.mp4"
git lfs track "*.zip"

# Trackear por diretório
git lfs track "assets/videos/*"
git lfs track "data/*.csv"

# Trackear arquivo específico
git lfs track "database/production.db"

# Trackear padrões complexos
git lfs track "**/*.blend"
git lfs track "models/**/*.obj"

# Configurações avançadas

# Trackear múltiplos padrões
git lfs track "*.{psd,ai,indd}"
git lfs track "*.{mp4,mov,avi}"
# Excluir subpadrões
git lfs track "*.psd" !"*.thumb.psd"
# Ver padrões trackeados
git lfs track
# Listar todos os padrões
git lfs track --list
# Ver arquivos .gitattributes
cat .gitattributes

# Editar .gitattributes manualmente
# Exemplo de conteúdo:
# *.psd filter=lfs diff=lfs merge=lfs -text
# *.mp4 filter=lfs diff=lfs merge=lfs -text


# 🔄 WORKFLOW DIÁRIO

# Adicionar arquivos grandes

# 1. Primeiro, trackear o tipo de arquivo
git lfs track "*.mp4"
# 2. Adicionar .gitattributes (MUITO IMPORTANTE)
git add .gitattributes
# 3. Adicionar arquivos grandes
git add video.mp4
# 4. Commit
git commit -m "Adiciona vídeo grande via LFS"
# 5. Push
git push origin main

# Verificar arquivos trackeados

# Ver quais arquivos estão sendo trackeados por LFS
git lfs ls-files
# Ver com detalhes
git lfs ls-files --long
# Ver por branch
git lfs ls-files --branch=develop
# Ver arquivos LFS em staging
git lfs status
# Ver todos os ponteiros LFS
find . -name "*.gitattributes" -exec cat {} \;

# 📤 PUSH E PULL COM LFS

# Upload de arquivos

# Push normal (LFS é automaticamente tratado)
git push origin main
# Forçar push de objetos LFS
git lfs push origin main --all
# Push apenas objetos LFS específicos
git lfs push origin main --object-id=oid123
# Ver progresso do push LFS
git lfs push --verbose origin main

# Status e logs

# Status do LFS
git lfs status
# Ver logs do LFS
git lfs logs last
git lfs logs show
git lfs logs inspect
# Ver estatísticas
git lfs stats
# Ver storage usado
du -sh .git/lfs

# 🧹 LIMPEZA E OTIMIZAÇÃO

# Limpar cache LFS

# Ver tamanho do cache
git lfs prune --dry-run
# Limpar cache mantendo últimos 7 dias
git lfs prune
# Limpar cache com configuração específica
git lfs prune --verbose --recent=3
git lfs prune --verbose --older-than=7d
# Limpar tudo exceto referenciado
git lfs prune --force
# Configurar auto limpeza
git config lfs.pruneoffsetdays 30
