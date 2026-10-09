function _evalcache
    if test (count $argv) -eq 0
        return
    end

    if test -z "$FISH_EVALCACHE_DIR"
        set -gx FISH_EVALCACHE_DIR "$HOME/.fish-evalcache"
    end

    set -f cmdHash noHash

    if command -v md5 >/dev/null
        set -f cmdHash (echo -n "$argv" | md5)
    else if command -v md5sum >/dev/null
        set -f cmdHash (echo -n "$argv" | md5sum | cut -d' ' -f1)
    end

    set -f cmd (basename $argv[1])
    set -f cacheFile "$FISH_EVALCACHE_DIR/init-$cmd-$cmdHash.fish"

    if test "$FISH_EVALCACHE_DISABLE" = true
        eval ($argv | source)
    else if test -s "$cacheFile"
        source "$cacheFile"
    else
        if type "$argv[1]" >/dev/null
            echo "$argv[1] initialization not cached, caching output of: $argv" 1>&2
            mkdir -p "$FISH_EVALCACHE_DIR"

            for fName in "$FISH_EVALCACHE_DIR/init-$cmd-"*".fish"
                set -l baseName (basename $fName)
                echo "[INFO] Different arguments cache found, deleting: $baseName"
                rm -f "$fName"
            end

            $argv >"$cacheFile"
            source "$cacheFile"
        else
            echo "evalcache ERROR: $cmd is not installed or in PATH"
        end
    end
end
