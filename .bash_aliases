# gems are good
export PATH=$PATH:/var/lib/gems/1.8/bin

alias sshvm="ssh -X cnuapp@vbox"
alias ll='ls -l'
alias la='ls -A'
alias md='mkdir'

# runs its arguments through less
l () { $* | less ; }

#### Common CNU Aliases #####
alias selstart='java -jar /home/dradcliffe/selRC1/selenium-remote-control-1.0-SNAPSHOT/selenium-server-1.0-SNAPSHOT/selenium-server.jar'
alias dingo='espeak -s 110 -p 35 "Deengo ayt mah bay be"'

#### Dean Dev Aliases #####
alias relinksql='ln -s /var/run/mysqld/mysqld.sock /tmp/mysql.sock'
alias vpn='sudo /etc/init.d/vpnclient_init start; vpnclient connect CNUVPN'
alias cew='cd /export/web'
alias wtf='time wtf' # lets keep tabs on its runtime, and keep it under 10 secondsbg
alias gs="git status"
alias stats='rake stats > doc/stats.txt'
alias fastri="fastri-server -a 192.168.56.0/24 -s 192.168.56.1"

alias sshfsvm='sshfs cnuapp@dradcliffe-hg:/export/web /export/web -o allow_other -o uid=1000 -o workaround=rename'
alias sshvm='ssh cnuapp@dradcliffe-hg'

# alias sshfsvm='sshfs cnuapp@dradcliffe-au:/export/web /export/web -o allow_other -o uid=1000 -o workaround=rename'
# alias sshvm='ssh cnuapp@dradcliffe-au'

# alias sshvm="ssh -X cnuapp@vbox"
# alias sshfsvm='sudo sshfs cnuapp@vbox:/export/web /export/vm -o allow_other -o uid=1000 -o workaround=rename'

#### P4 fun #### 
alias cp="cp -P"
p4i () { p4 integrate $* 1> /dev/null ; p4 resolve -as ... ; p4 resolve ... 1> /dev/null; }
alias p4d="p4 delete"
alias p4e="p4 edit"

#### Mini funcs ####
clipcopy() {  # runs a command, copying its output between pre tags to the X clipboard
  echo "<pre>"  | (xsel --clipboard -i)
  ( "$@" ) 2>&1 | tee >(xsel --clipboard -a)
  echo "</pre>" | (xsel --clipboard -a)
}

# quickly run and puts some ruby code
function rr() { ruby -r pp -e "puts $1" ; }

#### This Laptop Aliases #####
alias netrestart="sudo /etc/init.d/NetworkManager restart && sleep 3 && sudo /etc/init.d/networking restart"
alias soundrestart="sudo alsa force-reload"
alias nvidia="~/local/src/disper/src/cli.py"
alias nvidia-laptop_display_only="~/local/src/disper/src/cli.py -i < ~/nvidia_solo_laptop.nvid"
alias nvidialaptop_only='~/local/src/disper/src/cli.py -i < ~/nvidia_solo_laptop.nvid'
alias nvidiaright_display="~/local/src/disper/src/cli.py -i < ~/nvidia_dell_monitor_right.nvid"
alias nvidiaconf_room='~/local/src/disper/src/cli.py -i < ~/nvidiaconf_room.nvid'
alias arg1="history | tail -2 | head -1 | awk '{print $3}'"
alias blackenemacs="xrdb -merge ~/.Xdefaults"
