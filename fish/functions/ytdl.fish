function ytdl -a url
    if test -n "$url"
        set targetURL $url.tar
    else
        echo "URL required!"
        return
    end

    youtube-dl -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 --embed-thumbnail "$url"

    echo "Done!"
end
