#!/bin/bash
# Bu dosya, ~/.bashrc veya ~/.bash_profile dosyasına eklenebilir.

# source /usr/share/cachyos-fish-config/cachyos-config.fish

# >>> conda initialize (Lazy Load) >>>
# Conda'yı sadece gerektiğinde yüklemek için
__conda_setup() {
  # Conda'nın asıl başlatma komutunu (hook) çalıştır
  if [ -f /home/melih/anaconda3/bin/conda ]; then
    eval "$('/home/melih/anaconda3/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"
  fi
}

conda() {
  # Bu geçici fonksiyonu sil
  unset -f conda
  # Asıl conda kurulumunu yap
  __conda_setup
  # Şimdi gerçek conda komutunu kullanıcının argümanları ile çalıştır
  command conda "$@"
}
# <<< conda initialize <<<

fastfetch

# --- Değişken Tanımlamaları ---
export CHROME_EXECUTABLE="/usr/bin/google-chrome-stable"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export LINUXTOOLBOXDIR="$HOME/linuxtoolbox"
export EDITOR="nvim"
export VISUAL="nvim"

# Akış kontrolünü (Ctrl+S/Ctrl+Q) devre dışı bırakır
stty -ixon

# --- PATH Yönetimi ---
# PATH'e yinelenen kayıtları eklememek için bir yardımcı fonksiyon
add_to_path_prepend() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    export PATH="$1:$PATH" # Başa ekle
  fi
}

add_to_path_append() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    export PATH="$PATH:$1" # Sona ekle
  fi
}

add_to_path_prepend "/home/melih/FlutterEnv/flutter/bin"
add_to_path_append "$HOME/.local/bin"
add_to_path_append "$HOME/.cargo/bin"
add_to_path_append "/var/lib/flatpak/exports/bin"
# Orijinal dosyada 'fish_add_path -g "/.local/share/flatpak/exports/bin"' vardı.
# Bunun '$HOME/.local/share/...' olması gerektiği varsayıldı.
add_to_path_append "$HOME/.local/share/flatpak/exports/bin"

# --- Alias (Kısayol) Tanımlamaları ---
alias spico='sudo pico'
alias snano='sudo nano'
alias vim='nvim'
alias vi='nvim'
alias svi='sudo nvim'
alias vis='nvim "+set si"'

# grep için ripgrep (rg) kontrolü
if command -v rg &>/dev/null; then
  alias grep='rg'
else
  alias grep='/usr/bin/grep --color=auto'
fi

# config.bash dosyasını düzenle (efishc -> ebashc olarak değiştirildi)
alias ebashc='nvim ~/.bashrc'

# Tarih alias'ı
alias da='date "+%Y-%m-%d %A %T %Z"'

# Değiştirilmiş komutlar
alias cp='cp -i'
alias mv='mv -i'
alias rm='trash -v' # Çöp kutusuna taşı
alias mkdir='mkdir -p'
alias ps='ps auxf'
alias ping='ping -c 10'
alias less='less -R'
alias cls='clear'
alias apt-get='sudo apt-get'
alias multitail='multitail --no-repeat -c'
alias freshclam='sudo freshclam'
alias yayf="yay -Slq | fzf --multi --preview 'yay -Sii {1}' --preview-window=down:75% | xargs -ro yay -S"

# Dizin değiştirme alias'ları
alias home='cd ~'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias bd='cd "$OLDPWD"' # Fish'teki '$dirprev' yerine Bash'te '$OLDPWD' kullanılır

# Dizin ve içeriğini sil (rm alias'ını bypass eder)
alias rmd='/bin/rm --recursive --force --verbose'

# eza (ls alternatifi) için alias'lar
alias ls='eza -la --icons --git --header'
alias l='eza --icons --git'
alias ll='eza -l --icons --git --header'
alias la='eza -la --icons --git --header'
alias l.='eza -laD --icons --git --header'
alias lt='eza -la --sort=modified --reverse --icons --git --header'
alias lS='eza -la --sort=size --reverse --icons --git --header'
alias lx='eza -la --sort=ext --icons --git --header'
alias T='eza --tree --level=3 --icons --git'
alias Ta='eza --tree --level=3 -a --icons --git'
alias lf='eza -l --icons --git --no-dir'
alias ldir='eza -lD --icons --git'

# chmod alias'ları
alias mx='chmod a+x'
alias 000='chmod -R 000'
alias 644='chmod -R 644'
alias 666='chmod -R 666'
alias 755='chmod -R 755'
alias 777='chmod -R 777'

# Arama alias'ları
alias h='history | grep'
alias p="ps aux | grep"
alias topcpu="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"
alias f="find . | grep"

# Diğer alias'lar
alias checkcommand="type -t"
alias openports='netstat -nape --inet'
alias rebootsafe='sudo shutdown -r now'
alias rebootforce='sudo shutdown -r -n now'
alias diskspace="du -S | sort -n -r | more"
alias folders='du -h --max-depth=1'
alias folderssort='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
alias tree='tree -CAhF --dirsfirst'
alias treed='tree -CAFd'
alias mountedinfo='df -hT'
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'
alias sha1='openssl sha1'
#alias logs="sudo find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]\$' | xargs tail -f"
alias clickpaste='sleep 3; xdotool type "$(xclip -o -selection clipboard)"'
alias kssh="kitty +kitten ssh"
alias docker-clean='docker container prune -f; docker image prune -f; docker network prune -f; docker volume prune -f'
alias hug="systemctl --user restart hugo"
alias lanm="systemctl --user restart lan-mouse"

# cat'i bat olarak kullanmak için (eğer yüklüyse)
if command -v bat &>/dev/null; then
  alias cat='bat'
fi

#######################################################
# FONKSİYONLAR
#######################################################
# Not: Bash'te fonksiyonlar 'function name { ... }' bloğu ile tanımlanır.
# Argümanlar '$argv' yerine '$@' (tümü), '$1', '$2' olarak alınır.

# Arşiv çıkarma fonksiyonu
function extract {
  for archive in "$@"; do
    if [ -f "$archive" ]; then
      case "$archive" in
      *.tar.bz2 | *.tbz2) tar xvjf "$archive" ;;
      *.tar.gz | *.tgz) tar xvzf "$archive" ;;
      *.bz2) bunzip2 "$archive" ;;
      *.rar) unrar x "$archive" ;;
      *.gz) gunzip "$archive" ;;
      *.tar) tar xvf "$archive" ;;
      *.zip) unzip "$archive" ;;
      *.Z) uncompress "$archive" ;;
      *.7z) 7z x "$archive" ;;
      *) echo "Bilinmeyen arşiv türü: '$archive'" ;;
      esac
    else
      echo "'$archive' geçerli bir dosya değil!"
    fi
  done
}

# Dosya içinde metin arama
function ftext {
  grep -iIHrn --color=always "$1" . | less -r
}

# İlerleme çubuğu ile dosya kopyalama
function cpp {
  local total_size
  total_size=$(stat -c '%s' "$1")
  strace -q -ewrite cp -- "$1" "$2" 2>&1 |
    awk -v total_size="$total_size" '{
            count += $NF
            if (count % 10 == 0) {
                percent = count / total_size * 100
                printf "%3d%% [", percent
                for (i=0;i<=percent;i++) printf "="
                printf ">"
                for (i=percent;i<100;i++) printf " "
                printf "]\r"
            }
        }
        END { print "" }'
}

# Kopyala ve o dizine git
function cpg {
  if [ -d "$2" ]; then
    cp "$1" "$2" && cd "$2"
  else
    cp "$1" "$2"
  fi
}

# Taşı ve o dizine git
function mvg {
  if [ -d "$2" ]; then
    mv "$1" "$2" && cd "$2"
  else
    mv "$1" "$2"
  fi
}

# Dizin oluştur ve içine gir
function mkdirg {
  mkdir -p "$1" && cd "$1"
}

# Belirtilen sayıda yukarı dizine çık
function up {
  # ${1:-1} -> $1 varsa onu, yoksa 1'i kullanır
  local limit=${1:-1}
  local path=""
  for i in $(seq 1 "$limit"); do
    path="../$path"
  done
  cd "$path"
}

# cd komutundan sonra ls çalıştır
function cd {
  builtin cd "$@" && ls
}

# Çalışılan dizinin son iki bölümünü göster
function pwdtail {
  pwd | awk -F/ '{nlast = NF -1;print $nlast"/"$NF}'
}

# Linux dağıtımını bul
function distribution {
  local dtype="unknown"
  if [ -r /etc/os-release ]; then
    # 'source' yerine '. ' kullanmak daha güvenlidir
    . /etc/os-release
    case "$ID" in
    fedora | rhel | centos) dtype="redhat" ;;
    sles | "opensuse"*) dtype="suse" ;;
    ubuntu | debian) dtype="debian" ;;
    gentoo) dtype="gentoo" ;;
    arch | manjaro) dtype="arch" ;;
    slackware) dtype="slackware" ;;
    *)
      # Fish'teki 'set -q ID_LIKE' -> Bash'te '[ -n "$ID_LIKE" ]'
      if [ -n "$ID_LIKE" ]; then
        case "$ID_LIKE" in
        *fedora* | *rhel* | *centos*) dtype="redhat" ;;
        *sles* | *opensuse*) dtype="suse" ;;
        *ubuntu* | *debian*) dtype="debian" ;;
        *gentoo*) dtype="gentoo" ;;
        *arch*) dtype="arch" ;;
        *slackware*) dtype="slackware" ;;
        esac
      fi
      ;;
    esac
  fi
  echo "$dtype"
}

# İşletim sistemi versiyonunu göster
function ver {
  local dtype
  dtype=$(distribution)
  case "$dtype" in
  redhat)
    if [ -s /etc/redhat-release ]; then
      cat /etc/redhat-release
    else
      cat /etc/issue
    fi
    uname -a
    ;;
  suse) cat /etc/SuSE-release ;;
  debian) lsb_release -a ;;
  gentoo) cat /etc/gentoo-release ;;
  arch) cat /etc/os-release ;;
  slackware) cat /etc/slackware-version ;;
  *)
    if [ -s /etc/issue ]; then
      cat /etc/issue
    else
      echo "Hata: Bilinmeyen dağıtım"
      return 1
    fi
    ;;
  esac
}

# Gerekli destek dosyalarını kur
function install_bashrc_support {
  local dtype
  dtype=$(distribution)
  local FASTFETCH_URL
  case "$dtype" in
  redhat) sudo yum install multitail tree zoxide trash-cli fzf fastfetch ;;
  suse) sudo zypper install multitail tree zoxide trash-cli fzf fastfetch ;;
  debian)
    sudo apt-get install multitail tree zoxide trash-cli fzf
    FASTFETCH_URL=$(curl -s https://api.github.com/repos/fastfetch-cli/fastfetch/releases/latest | grep "browser_download_url.*linux-amd64.deb" | cut -d '"' -f 4)
    curl -sL "$FASTFETCH_URL" -o /tmp/fastfetch_latest_amd64.deb
    sudo apt-get install /tmp/fastfetch_latest_amd64.deb
    ;;
  arch) sudo paru -S multitail tree zoxide trash-cli fzf fastfetch ;;
  slackware) echo "Slackware için kurulum desteği yok" ;;
  *) echo "Bilinmeyen dağıtım" ;;
  esac
}

# IP adresi bulma
alias whatismyip='whatsmyip'
function whatsmyip {
  echo -n "Dahili IP: "
  if command -v ip &>/dev/null; then
    ip addr show wlan0 | grep "inet " | awk '{print $2}' | cut -d/ -f1
  else
    ifconfig wlan0 | grep "inet " | awk '{print $2}'
  fi

  echo -n "Harici IP: "
  curl -4 ifconfig.me
}

# GitHub Fonksiyonları
function gcom {
  git add .
  git commit -m "$1"
}

function lazyg {
  git add .
  git commit -m "$1"
  git push
}

#######################################################
# SON AYARLAMALAR VE ENTEGRASYONLAR
#######################################################

# Ctrl+f için özel tuş ataması
# 'zi' yazıp enter'a basar (zoxide interactive)
#
# !! UYARI !!: Bash'te Ctrl+F varsayılan olarak 'imleci bir karakter ileri'
# taşır. Bu atama, bu davranışı ezecektir.
# Eğer bu davranışı korumak istiyorsanız, başka bir tuş kombinasyonu
# (örneğin Alt+F, '\e[f' veya '\ef') kullanmayı düşünün.
bind '"\C-f": "zi\n"'

# Zoxide'ı başlat
#
# NOT: Fish yapılandırmanızda 'z' ve 'zi' komutlarını 'ls'
# çalıştıracak şekilde manuel olarak sarmalamışsınız.
# Bash (ve zoxide) için bunun doğru yolu '--hook ls' bayrağını
# kullanmaktır. Aşağıdaki komut, hem zoxide'ı başlatır
# hem de 'z' veya 'zi' kullandıktan sonra otomatik 'ls'
# çalıştırılmasını sağlar. (Source 47-49'daki kod bloklarının
# yerine geçer).
eval "$(zoxide init bash)"

z() {
  # Orijinal zoxide 'z' fonksiyonunu çağır
  __zoxide_z "$@"
  # Çıkış kodunu (başarı durumunu) al
  local_status=$?

  # Eğer 'cd' işlemi başarılı olduysa (çıkış kodu 0 ise) 'ls' çalıştır
  if [ $local_status -eq 0 ]; then
    # ls (Bu komut, sizin 'eza ...' olarak tanımladığınız alias'ı
    # otomatik olarak kullanacaktır)
    ls
  fi

  # Orijinal çıkış kodunu koru (hata durumlarını iletmek için önemli)
  return $local_status
}

zi() {
  # Orijinal zoxide 'zi' (interaktif) fonksiyonunu çağır
  __zoxide_zi "$@"
  local_status=$?

  if [ $local_status -eq 0 ]; then
    ls
  fi

  return $local_status
}

[[ $- == *i* ]] && source /usr/share/blesh/ble.sh
