# config
My config files for Manjaro Gnome terminal with i3-gaps


### packages that needs to be installed before applying i3 config IMPORTANT!!!!

i3-lock, i3wm and i3-gaps\
sudo pacman -S i3blocks

# Feh for wallpaper
sudo pacman -S feh

# For fonts
sudo pacman -S lxappearance

# For themes
sudo pacman -S autoconf\
sudo pacman -S automake\
sudo pacman -S arc-gtk-theme

# open lxappearance and apply

# in firefox browser add arc darker theme fireox add on

# for rofi
sudo pacman -S rofi

# for picom
sudo pacman -S picom
# the config files need to be put in ~/.config/picom/

#### End of what needs to be installed pre i3 config

### Fix fakeroots
sudo pacman -S binutils make gcc pkg-config fakeroot

### Get yaourt
git clone https://aur.archlinux.org/package-query.git\      
cd package-query.git\
makepkg -si\
cd ..\
git clone https://aur.archlinux.org/yaourt.git\
cd yaourt\
makepkg -si\

### Now time for some zoomer shell

sudo pacman -S zsh

chsh -l\
# use /bin/zsh

chsh -c /bin/zsh\

sudo reboot -n

# go through installation proccess after reboot
# next up OH-MY-ZOOMER
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# POWERLEVEL9K
sudo pacman -S zsh-theme-powerlevel9k\
echo 'source /usr/share/zsh-theme-powerlevel9k/powerlevel9k.zsh-theme' >> ~/.zshrc

# POWERLINE
# get the fonts
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf\
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf

# move fonts to right place, might need to make dir
mv PowerlineSymbols.otf ~/.local/share/fonts/

# clear cache
fc-cache -vf ~/.local/share/fonts/

# moves the other fonts to the other location. Again, might need to make dir
mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/

# ZOOMER highlight
git clone https://aur.archlinux.org/zsh-syntax-highlighting-git.git\
cd zsh-syntax-highlighting-git\
makepkg -si   

# Now one can copy paste the .zshrc

# Last but not least. VIM settings
Incase vim is not installed\
sudo pacman -S vim

# For vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim



