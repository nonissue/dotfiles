# Author: Brett Terpstra https://github.com/ttscoff
# Source: https://github.com/ttscoff/fish_files/blob/master/functions/cl.fish

function cl -d 'copy output of last command to clipboard'
	set -l last (history --max=1|sed -e 's/^ +//')
	eval $last | pbcopy
end