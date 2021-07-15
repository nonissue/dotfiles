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
    set -l options 's/source=' 'd/destination=' 'p/pattern='

    argparse -n rawr $options -- $argv

    if set -q _flag_d
        echo $_flag_d
        if test -d $_flag_d
            set dest_dir $_flag_d
        else
            echo "Error: invalid destination dir specified!"
            echo "Exiting..."

            return 1
        end
    else
        set _flag_d false
        echo 'Info: Using default dest dir'(pwd)
        set dest_dir (pwd)
    end


    if set -q _flag_s
        if test -d $_flag_s
            set source_dir $_flag_s
        else
            echo "Error: invalid source dir specified."
            echo "Exiting..."

            return 1
        end
    else
        set _flag_s false
        echo 'setting source dir ~/tmp'
        set source_dir (echo $HOME"/tmp")
    end

    set -x string_patterns

    # echo $_flag_p
    echo ""
    echo "Results:!"
    if set -q _flag_p
        set -l split_strings (string split ',' $_flag_p)
        set -l length (string split ',' $_flag_p | count)


        for i in (seq $length)
            find $source_dir -name (echo "*."$split_strings[$i])
        end
    else
        set _flag_p false
        echo 'using default str patterns (.r00, .rar)'

        set -l split_strings (string split ',' 'r00,rar')
        set -l length (string split ',' 'r00,rar' | count)
        for i in (seq $length)

            find $source_dir -name (echo "*."$split_strings[$i])
        end
    end
    echo ""






end
