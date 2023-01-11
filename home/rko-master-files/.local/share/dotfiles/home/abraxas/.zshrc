# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#$HOME/bin/create-hosts.sh          
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi
echo "v 3.3 2812"
echo ".zshrc"
echo
echo "this is $(hostname)"
source ~/.zsh.env
source $HOME/myq/zshrc_check.sh >/dev/null 2>/dev/null
$HOME/bin/mydotfiles.sh force
#$HOME/bin/ppab.sh $HOME/bin/make-mine.sh >/dev/null 2>/dev/null &
echo
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi
#$HOME/bin/sudo.sh chown abraxas: -R /home & >/dev/null 2>/dev/null
#sudo chmod +x /home/abraxas/bin/* &
eval "$(direnv hook zsh)"
[[ ! -d $HOME/tmp  ]] && mkdir $HOME/tmp >/dev/null 2>/dev/null

#ip=$(hostname)

#echo $ip
#echo create symbolic links
#$HOME/bin/create-links-home.sh 
#echo done 1/2
#ln -s /home/abraxas/sync_home/* $HOME
#echo done 2/2

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

5Aexport SSH_AUTH_SOCK=/home/abraxas678/keeagent.socket
export PATH=$HOME/bin:/usr/local/bin:$PATH
source ~/bin/path.dat
ZSH_THEME="powerlevel10k/powerlevel10k"
COMPLETION_WAITING_DOTS="true"

#source ~/powerlevel10k/powerlevel10k.zsh-theme
#To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export TERM=xterm-256color

# This is just for git commits - you should always use emacs!!!
export VISUAL=nano
export EDITOR="$VISUAL"

# Some useful aliases
alias ze="$EDITOR ~/.zshrc"
#alias zs="source ~/.zshrc"
#alias zs='exec zsh'

# Path to your oh-my-zsh install
export ZSH="$HOME/.oh-my-zsh"

#source ~/bin/zsh_plugins.dat

# Big cheese!! 🧀!! We're going to install a zsh package manager!

# Using the nightly, with:
[[ ! -f ~/antigen.zsh ]] && curl -s -L git.io/antigen-nightly > ~/antigen.zsh
source ~/antigen.zsh

# Load the oh-my-zsh library
antigen use oh-my-zsh

# zsh has a ton of nice builtins!
# here just my favs (I haven't even seen them all)
antigen bundle git # autocompletions
antigen bundle pip # autocompletions

# A bit more exciting 😎
antigen bundle command-not-found # suggests commands
antigen bundle z # jump around!
antigen bundle colored-man-pages # Neat man pages bro

# zsh-users bundles (an awesome group of devs 🙏)
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions # Game changer!

antigen bundle zsh-users/zsh-completions

antigen bundle zsh-autocomplete
antigen bundle magic-enter 
antigen bundle safe-paste 
antigen bundle tmux 
antigen bundle fzf 
#antigen bundle copypath 
#antigen bundle cp 
#antigen bundle copybuffer

antigen bundle bat
antigen bundle ctop
antigen bundle tig
antigen bundle navi
antigen bundle peco

antigen bundle supercrabtree/k
antigen bundle sudo

antigen bundle zsh-interactive-cd 
antigen bundle zsh-navigation-tools
#antigen autotitle zsh-tmux-auto-title

# Shhh secret 🤫 bundles
#antigen bundle thefuck 

# ESSENTIAL
antigen bundle SinaKhalili/ignore-dollarsign

# Experimental zone
#antigen bundle desyncr/auto-ls 
antigen bundle andrewferrier/fzf-z 

# Cool gitignore creation module
antigen bundle voronkovich/gitignore.plugin.zsh 
# Nicer git diffing
#antigen bundle zdharma/zsh-diff-so-fancy

# Let's add a theme! 
antigen theme romkatv/powerlevel10k
source ~/.p10k.zsh

# Always remember to antigen apply!! 🤗🤗
antigen apply

#export PATH="$HOME/.basher/bin:$PATH"
#eval "$(basher init - zsh)" # replace `bash` with `zsh` if you use zsh

# Secret environments
#eval $(thefuck --alias) &
source ~/bin/alias.dat
#source $HOME/bin/function-converted.dat

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

DISABLE_AUTO_TITLE=”false”

cd $(cat $HOME/start-dir.dat)
echo '/home/abraxas/' > $HOME/start-dir.dat

source $HOME/bin/functions.dat

/usr/bin/keychain $HOME/.ssh/id_ed25519
source $HOME/.keychain/$(hostname)-sh

#### Bashhub.com Installation
if [ -f ~/.bashhub/bashhub.zsh ]; then
    source ~/.bashhub/bashhub.zsh
fi


export RICH=$(which rich)
$PUEUED -d >/home/abraxas/tmp/result 2>>/home/abraxas/tmp/result
$RICH -s "#888888" --panel rounded --print "$(cat /home/abraxas/tmp/result)"
echo
rm -f /home/abraxas/tmp/result



# Fig post block. Keep at the bottom of this file.
#[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"


alias tv='tidy-viewer'
#source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
echo done
