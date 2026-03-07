#!/usr/bin/env bash
# credit https://github.com/develcooking/hyprland-dotfiles/blob/main/.config/rofi/wallpaper-launcher.sh

wall_dir="${HOME}/44Bars/home/wallpapers"
cacheDir="${HOME}/.cache/wallpapers"
rofi_theme="${HOME}/44Bars/home/scripts/WallSelect.rasi"

mkdir -p $cacheDir

icon_size=400
rofi_override="element-icon{size:${icon_size}px;border-radius:0px;}"

rofi_command="rofi -dmenu -theme ${rofi_theme} -theme-str ${rofi_override}"

for imagen in "$wall_dir"/*.{jpg,jpeg,png,webp}; do
	if [ -f "$imagen" ]; then
		name=$(basename "$imagen")
		if [ ! -f "${cacheDir}/${name}" ]; then
			magick "$imagen" \
				-strip \
				-resize 500x500^ \
				-gravity center \
				-crop 500x500+0+0 +repage \
				"${cacheDir}/${name}"
		fi
	fi
done

# Select a picture with rofi
wall_selection=$(find "${wall_dir}" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -exec basename {} \; | sort | while read -r A; do echo -en "$A\x00icon\x1f""${cacheDir}"/"$A\n"; done | $rofi_command)

# safe and set the wallpaper
[[ -n "$wall_selection" ]] || exit 1
echo "${wall_dir}/${wall_selection}" > "${HOME}/.cache/current-wallpaper"
pkill swaybg || true
swaybg -m fill -i "${wall_dir}/${wall_selection}" &

exit 0
