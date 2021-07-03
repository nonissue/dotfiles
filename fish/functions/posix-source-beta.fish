function posix-source-beta
	for i in (cat $argv)
		if test (echo $i | sed -E 's/^[[:space:]]*(.).+$/\\1/g') != "#"
			set arr (string split -m1 = $i)
			set -gx $arr[1] $arr[2]
		end
	end
end
