function peco_ssh
  awk '
    tolower($1)=="host" {
      for(i=2;i<=NF; i++) {
        if ($i !~ "[*?]") {
          print $i
        }
      }
    }
  ' ~/.ssh/config | sort | peco | read line
  if test -n "$line"
    ssh $line
  end
  set -e line
end
alias s "peco_ssh"
