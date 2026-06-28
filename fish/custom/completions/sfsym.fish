# fish completion for sfsym — install via:
#   sfsym completions fish > ~/.config/fish/completions/sfsym.fish

# Subcommands
complete -c sfsym -n '__fish_use_subcommand' -a export      -d 'render a symbol to a file'
complete -c sfsym -n '__fish_use_subcommand' -a batch       -d 'bulk exports from stdin'
complete -c sfsym -n '__fish_use_subcommand' -a list        -d 'enumerate symbol names'
complete -c sfsym -n '__fish_use_subcommand' -a info        -d 'report layer metadata'
complete -c sfsym -n '__fish_use_subcommand' -a modes       -d 'list supported rendering modes'
complete -c sfsym -n '__fish_use_subcommand' -a schema      -d 'machine-readable CLI schema (JSON)'
complete -c sfsym -n '__fish_use_subcommand' -a completions -d 'generate shell completion script'
complete -c sfsym -n '__fish_use_subcommand' -a version     -d 'print version'
complete -c sfsym -n '__fish_use_subcommand' -a help        -d 'print help'

# Dynamic symbol names for export / info / modes
complete -c sfsym -n '__fish_seen_subcommand_from export info modes; and not __fish_seen_subcommand_from (sfsym list)' \
    -a '(sfsym list)' -d 'symbol'

# Flags shared by export
complete -c sfsym -n '__fish_seen_subcommand_from export' -s f -l format -xa 'pdf png svg'       -d 'output format'
complete -c sfsym -n '__fish_seen_subcommand_from export'      -l mode   -xa 'monochrome hierarchical palette multicolor' -d 'rendering mode'
complete -c sfsym -n '__fish_seen_subcommand_from export'      -l weight -xa 'ultralight thin light regular medium semibold bold heavy black' -d 'font weight'
complete -c sfsym -n '__fish_seen_subcommand_from export'      -l scale  -xa 'small medium large' -d 'symbol scale'
complete -c sfsym -n '__fish_seen_subcommand_from export'      -l size   -x                       -d 'point size'
complete -c sfsym -n '__fish_seen_subcommand_from export'      -l color  -x                       -d 'tint color'
complete -c sfsym -n '__fish_seen_subcommand_from export'      -l palette -x                      -d 'palette colors (comma-separated)'
complete -c sfsym -n '__fish_seen_subcommand_from export'      -l viewbox -xa 'nominal tight'      -d 'SVG viewBox mode'
complete -c sfsym -n '__fish_seen_subcommand_from export'      -l current-color                   -d 'SVG fills use currentColor'
complete -c sfsym -n '__fish_seen_subcommand_from export'      -l no-dimensions                   -d 'SVG omits width/height'
complete -c sfsym -n '__fish_seen_subcommand_from export'      -l inline-svg                      -d 'SVG omits XML prolog/xmlns'
complete -c sfsym -n '__fish_seen_subcommand_from export'      -l web-inline                      -d 'SVG web-inline preset'
complete -c sfsym -n '__fish_seen_subcommand_from export' -s o -l out    -r                       -d 'output path'

# info / list / modes flags
complete -c sfsym -n '__fish_seen_subcommand_from info list modes' -l json -d 'JSON output'
complete -c sfsym -n '__fish_seen_subcommand_from list' -l prefix -x -d 'filter by prefix'
complete -c sfsym -n '__fish_seen_subcommand_from list' -l limit  -x -d 'cap count'

# batch
complete -c sfsym -n '__fish_seen_subcommand_from batch' -l fail-fast -d 'exit on first error'

# completions shell name
complete -c sfsym -n '__fish_seen_subcommand_from completions' -xa 'bash zsh fish'
