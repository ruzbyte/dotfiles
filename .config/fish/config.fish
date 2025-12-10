# source /usr/share/cachyos-fish-config/cachyos-config.fish
source (/usr/bin/starship init fish --print-full-init | psub)
fastfetch
# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end
