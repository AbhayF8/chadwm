#!/bin/sh
echo "moving chadwm directory to the .config directory"
mv chadwm ~/.config
sleep 1
echo "changing directory to chadwm/chadwm inside .config that was just copied"
cd ~/.config/chadwm/chadwm
sleep 1
echo "Copying the required fonts"
sleep 1
cp fonts/* ~/.local/share/fonts
echo "Making the dwm using make"
sudo make install
sleep 1
echo "Creating a desktop entry with name chadwm.desktop which will run the autostart file inside chadwm"
touch /usr/share/xsessions/chadwm.desktop  
sleep 1
sudo cp chadwm.desktop /usr/share/xsessions/chadwm.desktop
echo 'Copying desktop file for starting a xsession'
echo "Done"
