#!/bin/sh
echo "Removing any existing chadwm installation"
sleep 1
yes | rm -r ~/.config/chadwm
echo "Going to temp directory"
sleep 1
cd /tmp
sleep 1
echo "Cloning"
git clone "https://github.com/AbhayF8/chadwm"
sleep 1
echo "Moving chadwm directory to the .config directory"
mv chadwm ~/.config
sleep 1
echo "Changing directory to chadwm/chadwm inside .config that was just copied"
cd ~/.config/chadwm
sleep 1
echo "Copying the required fonts"
sleep 1
cp fonts/* ~/.local/share/fonts
echo "Making the dwm using make SUDO PASSWORD WILL BE ASKED"
cd chadwm
sudo make install
sleep 1
echo "Touching and copying the chadwm.desktop desktop entry file which will run the autostart file inside chadwm"
sudo touch /usr/share/xsessions/chadwm.desktop  
sleep 1
sudo cp ../chadwm.desktop /usr/share/xsessions/chadwm.desktop
echo "Done"
