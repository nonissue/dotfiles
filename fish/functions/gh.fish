# modified version of original here https://github.com/gf3/dotfiles/blob/master/.config/fish/functions/gh.fish
# for some reason the original didn't work
# the repo one liner is goddamn disgusting, but i don't know perl well enough to do better
# [x] issue with repos with periods in the url (ie. github.com/nonissue/plainest.git)

function gh
  set url 'https://github.com'
  set branch (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
  # set repo (git remote show -n origin | perl -lne 'print $1 if /Fetch URL:(.*)/' | perl -lne 'print $1 if /github.com\/(.*)/' | perl -lne '/(.*)\.git/ ? print $2 : print')
  # Breaks on repos with a period in them like github.com/nonissue/nonissue.org
  # EDIT: I think it's fixed!
  set repo (git remote show -n origin | perl -lne 'print $1 if /Fetch URL:(.*)/' | perl -lne 'print $1 if /github.com[\/:](.*[^.git].)/')
  # Build GitHub URL
  set url "$url/$repo"

  if test (count $argv) -gt 0
    # Find file path relative to git root
    pushd (dirname $argv[1])
      set pwd (pwd)
      set git_dir (git rev-parse --show-toplevel)
      set file (echo $pwd | sed 's#'$git_dir'##')
      set file $file'/'(basename $argv[1])
      set file (echo $file | sed 's/:\([0-9]*\)$/#L\1/')

      set url (echo "$url/blob/$branch/$file" | sed 's#//#/#g')
    popd
  else
    set url "$url/tree/$branch"
  end
  echo $url
  # Go go go
  open $url
end
