# ==========================================================
# --- CONFIGURAÇÃO DO OH MY ZSH ---
# ==========================================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

# SUPER LISTA DE PLUGINS (Mais ferramentas para produtividade)
plugins=(
  git                   # Comandos rápidos para Git
  zsh-autosuggestions   # Sugestões automáticas (comando cinza)
  zsh-syntax-highlighting # Cores nos comandos (verde/vermelho)
  docker npm node composer extract sudo web-search history copyfile copypath
)

source $ZSH/oh-my-zsh.sh

# ==========================================================
# --- PERSONALIZAÇÃO VISUAL GPWEB (ESTILO REGGAE + ÍCONE) ---
# ==========================================================

# Limpa o terminal para um visual limpo ao iniciar
clear

# Verifica se o figlet está instalado
if command -v figlet > /dev/null; then
    # 1. Gera o banner e guarda na variável
    BANNER_TEXT=$(figlet "GPWeb")
    
    # 2. Define o ícone da folha (🍁)
    LEAF=" 🍁"

    # 3. Processa o banner linha por linha para aplicar o degradê e a folha
    # O contador 'i' controla a cor de cada linha (Verde, Amarelo, Vermelho)
    i=0
    while IFS= read -r line; do
        i=$((i + 1))
        
        # Define a cor da linha atual (Degradê Reggae)
        if [ $i -le 2 ]; then
            COLOR="\e[1;32m" # Verde
        elif [ $i -le 4 ]; then
            COLOR="\e[1;33m" # Amarelo
        else
            COLOR="\e[1;31m" # Vermelho
        fi

        # Se for a linha do meio (linha 3), coloca a folha ao lado do nome
        if [ $i -eq 3 ]; then
            echo -e "${COLOR}${line}${LEAF}\e[0m"
        else
            echo -e "${COLOR}${line}\e[0m"
        fi
    done <<< "$BANNER_TEXT"
else
    # Caso não tenha figlet, mostra o nome simples na mesma linha
    echo -e "\e[1;32mGP\e[1;33mWeb \e[1;32m🍁\e[0m"
fi

# PERSONALIZAÇÃO DO PROMPT (Linha onde você digita)
# [GP]Web 🍁 em cores reggae
PROMPT='%F{green}[GP]%F{yellow}Web%f %F{green}🍁%f %F{white}%~%f $ '

# ==========================================================
# --- CONFIGURAÇÕES DE AMBIENTE & ATALHOS ---
# ==========================================================

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# ATALHOS RÁPIDOS (ALIASES)
alias cls='clear && source ~/.zshrc'        # Limpa e recarrega o terminal
alias att='sudo apt update && sudo apt upgrade -y' # Atualiza o sistema
alias zshconfig="nano ~/.zshrc"             # Edita estas configurações
alias ..='cd ..'
alias git-gui='github-desktop'
