function read_confirm --description 'Ask the user for confirmation' --argument prompt
    if test -z "$prompt"
        set prompt "Continue? [y/n]"
    end

    while true
        read -p 'printf "%s\n>  \n" $prompt' confirm

        switch $confirm
            case Y y
                return 0
            case '' N n
                return 1
        end
    end
end

function redock --description "Stop, remove, and rerun docker compose for a specific container in one go."

    #begin
    set sep1 "============================================="
    set sep2 ---------------------------------------------
    set timestamp (date +"%y-%m-%d %T")
    # set logpath "/home/ops/logs/redockerize.log"
    set start_dir (pwd)

    pushd .

    # printf "\n%s\n\n  %s\n" $sep1 $timestamp | tee -a $logpath

    # config for parsing command line args
    # set -l options ''
    # argparse -n redock $options -- $argv



    printf '\nSpecified container: %s' $argv

    set target_container $argv

    # set container_found (docker ps -a | grep asdfasdf | read x && echo true || false)
    # set container_found (docker ps -a | grep asdfasdf && echo true || echo false)

    # if string match -e $argv echo (docker ps -a | grep $argv) &>/dev/null
    #     set container_found true
    # else
    #     set container_found false
    # end
    set -l container_found false

    # search for exact match
    docker inspect $argv &>/dev/null
    if test $status -eq 0
        set container_found true
        printf '\nExact container (%s) found!\n\nDo you wish to REDOCKERIZE it?\nWarning: this is a dumb function and a dumb idea, probably.\n\n' $target_container

        if read_confirm 'Fuck it, lets get weird with it?'
            printf '\n%s\nREDOCKERIZING specified container!\n%s\n' $sep2 $sep2
        end
    else
        set container_found false
        printf '\nMultiple containers match provided string: \n'
        docker ps --format '{{.Names}}' | grep $target_container
        printf '\nBe exact!\n'

    end

    # next we should check for partial matches
    # docker ps --format '{{.Names}}' | grep $target_container
    # docker ps -a | grep $argv

    # we could also use the result of docker inspect?
    # docker inspect $argv &> /dev/null; echo $status

    printf '\nContainer found? %s' $container_found

    printf '\n\n'
end

# docker stop $argv; docker rm $argv; 

