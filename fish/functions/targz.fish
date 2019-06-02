function targz -a name target 
    
    if test -n "$name"
        set tmpFile $name.tar
    else 
        echo "tar.gz name required!"
        return
    end

    if test -n "$target"
        set target $target
    else
        set target "."
    end

	tar -cvf "$tmpFile" --exclude=".DS_Store" --exclude "$name.tar" "$target"; or return 1;

    set size (stat -f"%z" "$tmpFile" 2> /dev/null || stat -c"%s" "$tmpFile" 2> /dev/null) 
    set -l cmd gzip

    echo "Compressing .tar" (math $size / 1000) "kB using `$cmd`…";

	"$cmd" -v "$tmpFile" || return 1;

    set zippedSize (stat -f"%z" "$name.tar.gz" 2> /dev/null || stat -c"%s" "$name.tar.gz" 2> /dev/null) 
    echo "$tmpFile.gz " (math $zippedSize / 1000) "kB created successfully.";
end