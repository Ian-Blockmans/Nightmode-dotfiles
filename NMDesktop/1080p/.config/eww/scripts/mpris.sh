#!/bin/bash

######################################################################
## You need to install playerctl
######################################################################

get_music_title() {
    playerctl metadata -p spotify xesam:title
}

get_music_artist() {
    playerctl metadata -p spotify xesam:artist
}

get_music_cover() {
    playerctl metadata --follow mpris:artUrl
}

get_music_status() {
    status=$(playerctl status --no-messages)

    if [ "$status" == "Playing" ]; then
        echo "playing"
    else
        echo ""
    fi
}

get_music_player_name() {
    player=$(playerctl -l --no-messages | awk 'NR == 1 {print $1}')

    if [ "${player:0:7}" == "firefox" ]; then
        echo "Firefox"
    elif [ "$player" == "spotify" ]; then
        echo "Spotify"
    fi
}

get_music_player_icon() {
    player=$(playerctl -l --no-messages | awk 'NR == 1 {print $1}')
    
    if [ "${player:0:7}" == "firefox" ]; then
        echo "󰈹"
    elif [ "$player" == "spotify" ]; then
        echo "󰓇"
    fi
}

get_music_player_position() {
    lengthbig=$(playerctl metadata mpris:length)
    length=$(($(playerctl metadata mpris:length) / 1000000))
    #echo "$length"
    position=$(playerctl -p spotify position | awk '{print int($1)}')
    #echo "$position"
    normalized=$(( ($((position)) * 100) / $((length)) ))
    echo "$normalized"
}

music_player_seek() {
    length=$(($(playerctl metadata mpris:length) / 1000000))
    #echo "$length"
    #seektopercent="$1"
    #echo "$1"
    seekto=$(( $((length)) * $(("$1")) / 100 ))
    echo "$seekto"
    playerctl -p spotify position "$seekto"
}

# Main
case "$1" in
    "--title"       ) get_music_title ;;
    "--artist"      ) get_music_artist ;;
    "--cover"       ) get_music_cover ;;
    "--status"      ) get_music_status ;;
    "--toggle"      ) playerctl play-pause --no-messages ;;
    "--next"        ) playerctl next --no-messages ;;
    "--prev"        ) playerctl previous --no-messages ;;
    "--player_name" ) get_music_player_name ;;
    "--player_icon" ) get_music_player_icon ;;
    "--position"    ) get_music_player_position ;;
    "--seek"        ) music_player_seek "$2" ;;
esac





