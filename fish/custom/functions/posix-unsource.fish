function posix-unsource
	for i in (cat $argv)
            # split line on "="
	    set arr (echo $i |tr = \n)
            # capture first char so we can check it
            set -l firstchar (string sub --length 1 $arr[1]) 
            # Make sure current line isn't empty
            if [ (string length $arr[1]) != 0 ]
                # if firstchar = "#" we skip it since it is a comment
                if [ $firstchar != "#" ]
                    # echo what we are doing
                    echo "UNSETTING:" $arr[1]
                    # set variable
                    set -e $arr[1]
                end
            end 
	end
end
