#!/usr/bin/env bash
#script for lock screen
# man i3lock-color to see options

background=#96AFC360
foreground=#FFFFFFB0
alert=#FF393BA0
verify=#8169D4A0
transparant=#00000000

if [[ "$1" = "ring" ]]; then
    yoffset=300
    xoffset=330

    i3lock-color \
        -i ~/44Bars/home/shared/wallpaper/screen-saver/rebecca_good_ending_snowflake_50_blur.png \
        -e \
        --force-clock \
        --indicator \
        --radius="120" \
        \
        --color="#00000000" \
        --bshl-color="$alert" \
        --keyhl-color="$foreground" \
        --bar-color="$background" \
        \
        --inside-color="$transparant" \
        --ring-color="$background" \
        --insidever-color="$transparant" \
        --ringver-color="$verify" \
        --insidewrong-color="$transparant" \
        --ringwrong-color="$alert" \
        \
        --layout-color="$foreground" \
        --time-color="$foreground" \
        --date-color="$foreground" \
        --greeter-color="$foreground" \
        \
        --date-str="%d-%m-%Y" \
        --time-str="%I:%M %p" \
        --greeter-text="Welcome!" \
        --verif-text="" \
        --wrong-text="" \
        --noinput-text="" \
        \
        --greeter-font="Dancing Script:style=Regular" \
        --time-font="Dancing Script:style=Regular" \
        --date-font="Dancing Script:style=Regular" \
        --greeter-size=50 \
        --time-size=42 \
        --date-size=16 \
        \
        --time-pos="$xoffset:$yoffset-30" \
        --date-pos="$xoffset:$yoffset-5" \
        --greeter-pos="$xoffset:$yoffset+50" \
        --ind-pos="$xoffset:$yoffset"
fi

if [[ "$1" = "bar" ]]; then
    xoffset=250
    yoffset=200

    i3lock-color \
        -i ~/44Bars/home/shared/wallpaper/screen-saver/rebecca_good_ending_snowflake_50_blur.png \
        -e \
        --force-clock \
        --bar-indicator \
        --bar-orientation="vertical" \
        --bar-total-width="170" \
        \
        --date-str="%d-%m-%Y" \
        --time-str="%I:%M %p" \
        --greeter-text="Welcome!" \
        --verif-text="" \
        --wrong-text="" \
        --noinput-text="" \
        \
        --color="#00000000" \
        --ringver-color="$verify" \
        --ringwrong-color="$alert" \
        --bar-color="$background" \
        --keyhl-color="$foreground" \
        --bshl-color="$alert" \
        \
        --layout-color="$foreground" \
        --time-color="$foreground" \
        --date-color="$foreground" \
        --greeter-color="$foreground" \
        \
        --greeter-font="Dancing Script:style=Regular" \
        --time-font="Dancing Script:style=Regular" \
        --date-font="Dancing Script:style=Regular" \
        --greeter-size=50 \
        --time-size=42 \
        --date-size=16 \
        \
        --time-pos="$xoffset+120:$yoffset+50" \
        --date-pos="$xoffset+120:$yoffset+75" \
        --greeter-pos="$xoffset+120:$yoffset+140" \
        --bar-pos="$xoffset:$yoffset"
fi
