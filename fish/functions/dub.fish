function dub -a path
	if test -n "$path"
		set TARGET $path
	else
		echo "path required!"
		return
	end

	# echo $path

	du -Lsbc $path | awk '
    function hr(bytes) {
        hum[1024**4]="TiB";
        hum[1024**3]="GiB";
        hum[1024**2]="MiB";
        hum[1024]="kiB";
        for (x = 1024**4; x >= 1024; x /= 1024) {
            if (bytes >= x) {
                return sprintf("%8.2f %s", bytes/x, hum[x]);
            }
        }
        return sprintf("%4d     B", bytes);
    }

    {
    	out=""; for(i=2;i<=NF;i++){out=out" "$i};
        print hr($1) "\t" out
    }
'
end
