# GUIA RÁPIDO DO GIT - 100 COMANDOS ESSENCIAIS

## 1. Configuração Inicial e Identidade
git config --global user.name "O Teu Nome" - Definir o nome de utilizador global.
git config --global user.email "seu-email@link.com" - Definir o email global do utilizador.
git config --global core.editor "code --wait" - Definir o VS Code como editor padrão.
git config --global init.defaultBranch main - Definir "main" como o nome da branch padrão.
git config --global color.ui true - Ativar cores na saída do terminal.
git config --list - Listar todas as configurações ativas.
git config user.name - Verificar o nome de utilizador atual.
git config user.email - Verificar o email atual.
git config --global alias.st status - Criar um atalho (alias) para o comando status.
git config --global alias.co checkout - Criar um atalho (alias) para o comando checkout.

## 2. Criação e Clonagem de Repositórios
git init - Inicializar um novo repositório Git local.
git init nome-do-projeto - Criar uma pasta e inicializar o Git nela.
git clone url-do-repositorio - Clonar um repositório remoto existente.
git clone url-do-repositorio pasta-destino - Clonar um repositório para uma pasta específica.
git clone --branch nome-branch url - Clonar apenas uma branch específica.
git clone --depth 1 url - Clonar apenas o último commit (clone raso/leve).
git clone --bare url - Clonar um repositório sem a árvore de trabalho (servidores).

## 3. Fluxo de Trabalho Básico (Status, Add, Commit)
git status - Mostrar o estado atual do diretório de trabalho.
git status -s - Mostrar o estado de forma curta e simplificada.
git add arquivo.txt - Adicionar um ficheiro específico à área de preparação (Staging).
git add pasta/ - Adicionar uma pasta inteira ao Staging.
git add . - Adicionar todas as modificações e novos ficheiros ao Staging.
git add -A - Adicionar todas as alterações, incluindo ficheiros eliminados.
git add -p - Adicionar alterações em partes (interativo/linha por linha).
git commit -m "Mensagem do commit" - Gravar as alterações do Staging no histórico.
git commit -am "Mensagem" - Adicionar ficheiros modificados e fazer commit num só comando.
git commit --amend -m "Nova mensagem" - Alterar a mensagem do último commit local.
git commit --amend --no-edit - Adicionar novos ficheiros ao último commit sem mudar a mensagem.

## 4. Visualização do Histórico e Logs
git log - Mostrar o histórico completo de commits.
git log -n 5 - Mostrar apenas os últimos 5 commits.
git log --oneline - Mostrar o histórico resumido (uma linha por commit).
git log --graph - Mostrar o histórico com representação gráfica em árvore.
git log --graph --oneline --decorate --all - O comando de log visual mais completo.
git log -p - Mostrar as alterações detalhadas (diff) em cada commit.
git log --stat - Mostrar estatísticas de ficheiros alterados por commit.
git log --author="Nome" - Filtrar os commits por um autor específico.
git log --grep="bug" - Procurar commits por palavra-chave na mensagem.
git log --since="2 weeks ago" - Mostrar commits das últimas duas semanas.
git log -- arquivo.txt - Mostrar o histórico de um ficheiro específico.
git blame arquivo.txt - Mostrar quem alterou cada linha de um ficheiro e quando.
git shortlog - Resumir o log agrupando por autor.
git shortlog -sn - Mostrar o número de commits por autor em ordem decrescente.

## 5. Comparação de Alterações (Diff)
git diff - Mostrar alterações no diretório de trabalho que não foram para o Staging.
git diff --staged - Mostrar alterações no Staging prontas para o commit.
git diff --cached - Sinónimo de --staged (mostra o que está no Staging).
git diff branch1 branch2 - Comparar as diferenças entre duas branches.
git diff commit1 commit2 - Comparar as diferenças entre dois commits específicos.
git diff --stat - Mostrar apenas o resumo dos ficheiros alterados no diff.

## 6. Gestão de Branches (Ramificações)
git branch - Listar todas as branches locais.
git branch -r - Listar todas as branches remotas.
git branch -a - Listar todas as branches (locais e remotas).
git branch nome-da-branch - Criar uma nova branch.
git checkout nome-da-branch - Mudar para a branch especificada.
git switch nome-da-branch - Comando moderno para mudar de branch.
git checkout -b nova-branch - Criar uma nova branch e mudar para ela imediatamente.
git switch -c nova-branch - Comando moderno para criar e mudar de branch.
git branch -d nome-da-branch - Eliminar uma branch local com segurança (se integrada).
git branch -D nome-da-branch - Forçar a eliminação de uma branch local.
git branch -m novo-nome - Renomear a branch atual.
git branch --merged - Listar branches que já foram integradas na atual.
git branch --no-merged - Listar branches que ainda têm alterações pendentes.

## 7. Integração de Alterações (Merge e Rebase)
git merge nome-da-branch - Integrar as alterações da branch especificada na branch atual.
git merge --no-ff branch - Forçar a criação de um commit de merge (evita Fast-Forward).
git merge --abort - Cancelar o processo de merge em caso de conflitos.
git merge --continue - Continuar o merge após resolver os conflitos manualmente.
git rebase nome-da-branch - Aplicar os commits atuais no topo da branch especificada.
git rebase -i HEAD~3 - Iniciar um rebase interativo para os últimos 3 commits.
git rebase --abort - Cancelar o processo de rebase em execução.
git rebase --continue - Continuar o rebase após resolver conflitos.

## 8. Sincronização com Repositórios Remotos (Push, Pull, Fetch)
git remote -v - Listar os repositórios remotos configurados e as suas URLs.
git remote add origin url - Conectar o repositório local a um repositório remoto.
git remote rename velho novo - Renomear o nome de um repositório remoto.
git remote remove nome - Remover a conexão com um repositório remoto.
git fetch origin - Descarregar as novidades do servidor sem alterar os ficheiros locais.
git pull origin main - Procurar as novidades do servidor e integrá-las na branch atual.
git pull --rebase origin main - Fazer pull aplicando rebase em vez de merge.
git push origin main - Enviar os commits locais da branch main para o servidor.
git push -u origin nome-branch - Enviar uma nova branch local e configurar o rastreamento automático.
git push origin --delete nome-branch - Eliminar uma branch diretamente no servidor remoto.
git push origin --tags - Enviar todas as tags locais para o servidor remoto.

## 9. Desfazer Alterações e Correções
git checkout -- arquivo.txt - Descartar alterações locais num ficheiro (voltar ao último commit).
git restore arquivo.txt - Comando moderno para descartar alterações no ficheiro.
git restore --staged arquivo.txt - Remover um ficheiro da área de Staging (tirar do git add).
git reset HEAD arquivo.txt - Comando clássico para remover um ficheiro do Staging.
git reset --soft HEAD~1 - Voltar o último commit, mantendo as alterações no Staging.
git reset --mixed HEAD~1 - Voltar o último commit, movendo as alterações para fora do Staging.
git reset --hard HEAD~1 - Destruir o último commit e apagar todas as alterações feitas nele.
git reset --hard origin/main - Forçar o repositório local a ficar exatamente igual ao servidor.
git revert ID-DO-COMMIT - Criar um novo commit que reverte as alterações de um commit antigo.
git rm arquivo.txt - Eliminar o ficheiro do disco e agendar a remoção no Git.
git rm --cached arquivo.txt - Remover o ficheiro do Git, mas mantê-lo fisicamente no computador.
git clean -df - Eliminar permanentemente todos os ficheiros e pastas não monitorizados.

## 10. Salvamento Temporário (Stash)
git stash - Guardar temporariamente as alterações modificadas para limpar a árvore de trabalho.
git stash save "mensagem" - Guardar o stash com uma mensagem descritiva.
git stash -u - Guardar o stash incluindo ficheiros novos (não monitorizados).
git stash list - Listar todos os salvamentos temporários guardados.
git stash show - Mostrar o resumo das alterações contidas no último stash.
git stash apply - Aplicar as alterações do último stash sem o eliminar da lista.
git stash pop - Aplicar as alterações do último stash e removê-lo da lista.
git stash apply stash@{2} - Aplicar um stash específico da lista.
git stash drop stash@{1} - Eliminar um stash específico da lista.
git stash clear - Apagar permanentemente todos os stashes guardados.

## 11. Tags (Etiquetas de Versão)
git tag - Listar todas as tags (versões) criadas.
git tag v1.0.0 - Criar uma tag leve no commit atual.
git tag -a v1.0.0 -m "Versão de lançamento" - Criar uma tag anotada com mensagem.
git tag -d v1.0.0 - Eliminar uma tag localmente.
git show v1.0.0 - Ver as informações detalhadas de uma tag específica.

## 12. Inspeção Avançada e Recuperação
git status --ignored - Listar todos os ficheiros que estão a ser ignorados pelo `.gitignore`.
git reflog - Mostrar o histórico de movimentações do HEAD (útil para recuperar commits "perdidos").
git cherry-pick ID-COMMIT - Copiar um commit específico de outra branch e aplicá-lo na branch atual.
git fsck - Verificar a integridade da base de dados do Git (e encontrar ficheiros soltos).
