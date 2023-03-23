# Multi line strings, break this

function posix-source-beta
	for i in (cat $argv)
		if test (echo $i | sed -E 's/^[[:space:]]*(.).+$/\\1/g') != "#"
			set arr (string split -m1 = $i)
			if [ (string length $arr[1]) != 0 ]

                set -l clean (echo $arr[2] | tr -d '"')
				echo "Setting:" $arr[1]"="$clean
				set -gx $arr[1] $arr[2]
			end
		end
	end
end
