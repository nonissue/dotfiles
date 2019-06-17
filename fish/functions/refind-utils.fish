
function refind-utils --description "utilities for refind"

    set -l options 'h/help' 'r/recover'
    argparse -n fdel $options -- $argv

    if set -q _flag_h
        echo "Utilities for refind."
        echo "Options: -r/--recover: renables refind boot after it has been disabled"
    end

    if set -q _flag_r
        if not test -d "/Volumes/ESP"
            sudo mkdir /Volumes/ESP > /dev/null
        else
            echo "Error! /Volumes/ESP already exists"
            echo "Please confirm directory is empty then remove it"
            return 1
        end

        sudo mount -t msdos /dev/disk0s1 /Volumes/ESP && sudo bless --mount /Volumes/ESP --setBoot --file /Volumes/ESP/EFI/refind/refind_x64.efi --shortform && diskutil unmount /Volumes/ESP > /dev/null
        set -l result $status

        if test $result -eq 3
            echo "ERROR: unnsuccessful. Likely SIP is enabled"
            echo "INFO: Attemping to cleanup"
            if test -d "/Volumes/ESP"
                diskutil unmount /Volumes/ESP > /dev/null
            end
            return 1
        else if test $result -eq 77
            echo "ERROR: Volume already mounted on target"
            echo "Please unmount anything on /Volumes/ESP and try again"
            return 1
        else if test $result -eq 1
            echo "ERROR: Likely unable to mount /Volumes/ESP"
        else if test $result -eq 0
            echo "Process completed successfully"
        end
    end
end

