function ytdl -a url --description 'Download audio from a YouTube URL as an mp3 file'
    if test -n "$url"
        set targetURL $url.tar
    else
        echo "URL required!"
        return
    end

    youtube-dl -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 --embed-thumbnail "$url"

    echo "Done!"
end
