# 函数名称: _installSymLink
# 参数:
#   $1: 符号链接的名称(没啥用，随便填也行)
#   $2: 符号链接的路径(目标路径，如果存在就做删除处理)
#   $3: 源路径，符号链接将指向该路径
#   $4: 目标路径，符号链接将被创建到该路径
#
# 说明:
#   该函数用于创建符号链接。在创建之前，会检查符号链接的存在，并根据类型进行相应的处理。
#   如果符号链接已存在，将删除旧的符号链接，然后创建新的符号链接。
#   输出相应的信息，以便用户了解执行的操作。
#
# 用法示例:
#   _installSymLink "my_link" "/path/to/my_link" "/source/path" "/target/path"
#
_installSymLink() {
    name="$1"
    symlink="$2";
    linksource="$3";
    linktarget="$4";
    
    if [ -L "${symlink}" ]; then
        rm ${symlink}
        ln -s ${linksource} ${linktarget} 
        echo "Symlink ${linksource} -> ${linktarget} created."
    else
        if [ -d ${symlink} ]; then
            rm -rf ${symlink}/ 
            ln -s ${linksource} ${linktarget}
            echo "Symlink for directory ${linksource} -> ${linktarget} created."
        else
            if [ -f ${symlink} ]; then
                rm ${symlink} 
                ln -s ${linksource} ${linktarget} 
                echo "Symlink to file ${linksource} -> ${linktarget} created."
            else
                ln -s ${linksource} ${linktarget} 
                echo "New symlink ${linksource} -> ${linktarget} created."
            fi
        fi
    fi
}


####################################
#  hyprland dotfile link script.  #
####################################

## general
_installSymLink .bashrc ~/.bashrc ~/dotfiles/.bashrc ~/.bashrc
_installSymLink wal ~/.config/wal ~/dotfiles/wal/ ~/.config
_installSymLink rofi ~/.config/rofi ~/dotfiles/rofi/ ~/.config
_installSymLink dunst ~/.config/dunst ~/dotfiles/dunst/ ~/.config
_installSymLink hypr ~/.config/hypr ~/dotfiles/hypr/ ~/.config
_installSymLink waybar ~/.config/waybar ~/dotfiles/waybar/ ~/.config
_installSymLink swappy ~/.config/swappy ~/dotfiles/swappy/ ~/.config
_installSymLink starship ~/.config/starship.toml ~/dotfiles/starship/starship.toml ~/.config/starship.toml
_installSymLink alacritty ~/.config/alacritty ~/dotfiles/alacritty/ ~/.config

_installSymLink swaylock ~/.config/swaylock ~/dotfiles/swaylock/ ~/.config
_installSymLink wlogout ~/.config/wlogout ~/dotfiles/wlogout/ ~/.config

## custom
# _installSymLink Code ~/.config/Code ~/dotfiles/Code/ ~/.config
_installSymLink fcitx5 ~/.config/fcitx5 ~/dotfiles/fcitx5/ ~/.config
_installSymLink Thunar ~/.config/Thunar ~/dotfiles/Thunar/ ~/.config
_installSymLink spicetify ~/.config/spicetify ~/dotfiles/spicetify/ ~/.config
_installSymLink firefox-chrome ~/.mozilla/firefox/*.default/chrome ~/dotfiles/FireFox/chrome/ ~/.mozilla/firefox/*.default
_installSymLink firefox-user.js ~/.mozilla/firefox/*.default/user.js ~/dotfiles/FireFox/user.js ~/.mozilla/firefox/*.default/user.js

