# Open GitHub for current repo/branch or a specific file
# Usage:
#   ogh                     -> opens https://github.com/<owner>/<repo>/tree/<branch-or-default>
#   ogh path/to/file[:123]  -> opens https://github.com/<owner>/<repo>/blob/<ref>/path/to/file#L123
function ogh --description "Open current repo (or file) on GitHub"
    # 1) Ensure we're in a git repo
    if not git rev-parse --is-inside-work-tree >/dev/null 2>&1
        echo "ogh: not inside a git repository." >&2
        return 1
    end

    # 2) Ensure 'origin' exists and is GitHub.com
    set -l origin_url (git config --get remote.origin.url 2>/dev/null)
    if test -z "$origin_url"
        echo "ogh: no 'origin' remote found." >&2
        return 1
    end

    # Only handle GitHub.com (adjust here if you want to allow enterprise hosts)
    if not string match -q -r 'github\.com' -- "$origin_url"
        echo "ogh: origin is not on github.com: $origin_url" >&2
        return 1
    end

    # 3) Extract owner/repo from origin url
    #    Supports:
    #    - git@github.com:owner/repo(.git)
    #    - https://github.com/owner/repo(.git)
    set -l repo_path (string replace -r '^(git@|https?://)github\.com[:/](.+?)(\.git)?$' '$2' -- "$origin_url")
    if test -z "$repo_path"
        echo "ogh: failed to parse owner/repo from: $origin_url" >&2
        return 1
    end

    set -l base "https://github.com/$repo_path"

    # 4) Find current ref:
    #    - branch name if on branch
    #    - otherwise commit SHA if detached
    set -l curr_branch (git symbolic-ref --quiet --short HEAD 2>/dev/null)
    set -l detached 0
    if test -z "$curr_branch"
        set detached 1
        set -l sha (git rev-parse --verify --short=12 HEAD)
        if test -z "$sha"
            echo "ogh: cannot resolve HEAD." >&2
            return 1
        end
    end

    # 5) Determine remote default branch (origin/HEAD) -> usually "main" or "master"
    set -l remote_head (git symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null)
    set -l default_branch
    if test -n "$remote_head"
        # remote_head like "origin/main" -> strip "origin/"
        set default_branch (string replace -r '^origin/' '' -- "$remote_head")
    else
        # Fallback: pick main or master if present; otherwise just "main"
        if git rev-parse --verify --quiet origin/main >/dev/null 2>&1
            set default_branch main
        else if git rev-parse --verify --quiet origin/master >/dev/null 2>&1
            set default_branch master
        else
            set default_branch main
        end
    end

    # 6) Choose the ref to use in the URL
    set -l ref_for_url
    if test $detached -eq 1
        # Detached: point to the exact commit
        set ref_for_url (git rev-parse --verify --short=12 HEAD)
    else
        # On a branch: make sure it exists on remote; else fall back to default branch
        if git rev-parse --verify --quiet "refs/remotes/origin/$curr_branch" >/dev/null 2>&1
            set ref_for_url "$curr_branch"
        else
            set ref_for_url "$default_branch"
        end
    end

    # 7) Optional argument: file path (with optional :<line>)
    if test (count $argv) -gt 0
        set -l arg "$argv[1]"
        set -l filepath "$arg"
        set -l lineno ""

        # Parse :<line> suffix
        if string match -q -r ':[0-9]+$' -- "$arg"
            set lineno (string replace -r '.*:([0-9]+)$' '$1' -- "$arg")
            set filepath (string replace -r ':(?:[0-9]+)$' '' -- "$arg")
        end

        # Compute repo-relative path
        set -l repo_root (git rev-parse --show-toplevel)
        if test -z "$repo_root"
            echo "ogh: unable to determine repo root." >&2
            return 1
        end

        # Turn filepath into an absolute path, then strip repo_root prefix
        set -l abs
        if command -q realpath
            set abs (realpath "$filepath" 2>/dev/null)
        end
        if test -z "$abs"
            # Fall back: try to resolve via git; if it’s tracked, this gives a clean relative path
            set abs_candidate (git ls-files --full-name -- "$filepath")
            if test -n "$abs_candidate"
                set abs "$repo_root/$abs_candidate"
            else
                # Last resort: join with $PWD
                set abs (pwd)"/$filepath"
            end
        end

        # Normalize: strip the repo root prefix (escape repo_root for regex)
        set -l repo_root_re (string escape --style=regex -- "$repo_root")
        # Remove "$repo_root/" prefix without capture groups to avoid $1 parsing issues
        set -l rel (string replace -r "^$repo_root_re/?" "" -- "$abs")
        if test -z "$rel"
            # If replacement failed, try using git ls-files one more time directly
            set rel (git ls-files --full-name -- "$filepath")
            if test -z "$rel"
                # If still empty, just use the raw (possibly relative) path
                set rel "$filepath"
            end
        end

        # Build blob URL
        set -l url "$base/blob/$ref_for_url/$rel"
        if test -n "$lineno"
            set url "$url#L$lineno"
        end
        echo $url
        open $url
        return
    end

    # 8) No file provided: open tree view at chosen ref
    set -l url "$base/tree/$ref_for_url"
    echo $url
    open $url
end
