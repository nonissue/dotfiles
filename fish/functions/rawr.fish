function read_confirm --description 'Ask the user for confirmation' --argument prompt
    if test -z "$prompt"
        set prompt "Continue? [y/n]"
    end

    while true
        read -p 'printf "  %s\n  >  \n" $prompt' confirm

        switch $confirm
            case Y y
                return 0
            case '' N n
                return 1
        end
    end
end

function rawr --description 'Unrar all rar archives in subfolders (to optional directory)'
    # set -l options '-s/source=? d/destination=?'
    set -l options 's/source=?' 'd/destination=?' 'p/pattern='

    argparse -n rawr $options -- $argv

    # echo $argv
    if set -q _flag_d
        if test -d $_flag_d
            set dest_dir $_flag_d
        else
            echo "invalid directory specified"
            return 1
        end
    else
        set _flag_d false
        # echo 'setting dest dir to ~/files/downloads/complete/tv/extracted'
        set dest_dir /home/ops/files/downloads/complete/tv/extracted
    end

    if set -q _flag_s
        if test -d $_flag_s
            set source_dir $_flag_s
        else
            echo "invalid source dir specified"
            return 1
        end
    else
        set _flag_s false
        # echo 'setting source dir to current dir'
        set source_dir (pwd)
    end



    set -x string_patterns
    # echo $_flag_p
    if set -q _flag_paa
        set -l length (string split ',' $_flag_p | count)
        set -l split_strings (string split ',' $_flag_p)
        
        # echo $length
        for i in (seq $length)
            # echo $i

            if set -q i
                set -l test $split_strings[$i]
                # set -a string_patterns (echo "-name \""(echo "*" | string unescape)"."$test\")

                set -a string_patterns $test
                if [ $i != $length ]
                    set -a string_patterns -o
                end

            else
                echo 'i is empty'
            end
            # if [ $i = $length ]

            #     set -a string_patterns "\\)"
            # end
        end

        echo $string_patterns

    else
        set _flag_paa false
        echo 'using default str patterns (.r00, .rar)'
        set -x string_patterns '*.conf'

    end

    # find . \( -name $test_string -o -name "*.r00" \) -execdir unrar e -o- {} ~/files/downloads/complete/tv/extracted/ \;
    # find . (echo "$string_patterns" ) -execdir echo {} \;



    set -l split_strings (string split ',' $_flag_p)
    set -l length (string split ',' $_flag_p | count)

    for i in (seq $length) 
        echo $split_strings[$i]
        find ~/tmp/clean -name (echo "*."$split_strings[$i])
    end




end
