git remote show -n origin | perl -lne 'print $1 if /Fetch URL:(.*)/' | perl -lne 'print $1 if /github.com[\/:](.*[^.git])/'
