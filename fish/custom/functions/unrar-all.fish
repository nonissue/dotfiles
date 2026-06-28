# finds all '.r00' files in dir tree, and extracts them to specified folder

function unrar-all
    find . \( -name "*.rar" -o -name "*.r00" \) -execdir unrar e -o- {} ~/files/downloads/complete/tv/extracted/ \;
end
