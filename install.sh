export ORIGINAL_PATH=`pwd`

echo "Check and install Vundle."

# if we don't have folder vimfiles, create it.
if [ ! -d "./vimfiles/" ]; then
    mkdir ./vimfiles/
fi
cd ./vimfiles/

# if we don't have bundle, create it.
if [ ! -d "./bundle/" ]; then
    mkdir ./bundle/
fi
cd ./bundle/

# download or update vundle in ./vimfiles/bundle/
if [ ! -d "./vundle/" ]; then
    git clone https://github.com/gmarik/vundle.git vundle
fi

# download and install bundles through Vundle in this repository
echo "Update vim-plugins."
cd ${ORIGINAL_PATH}
vim -u .vimrc --cmd "let g:exvim_dev=1" --cmd "set rtp=./vimfiles,\$VIMRUNTIME,./vimfiles/after" +PluginInstall +qall

# install powerline-fonts on MacOSX
if [ "$(uname)" == "Darwin" ]; then
    # cd ./ext/powerline-fonts/DejaVuSansMono/
    # if [ ! -f "~/Library/Fonts/DejaVu\ Sans\ Mono\ Bold\ Oblique\ for\ Powerline.ttf" ]; then 
    #     cp ./DejaVu\ Sans\ Mono\ Bold\ Oblique\ for\ Powerline.ttf ~/Library/Fonts/
    # fi
    # if [ ! -f "~/Library/Fonts/DejaVu\ Sans\ Mono\ Bold\ for\ Powerline.ttf" ]; then 
    #     cp ./DejaVu\ Sans\ Mono\ Bold\ for\ Powerline.ttf ~/Library/Fonts/
    # fi
    # if [ ! -f "~/Library/Fonts/DejaVu\ Sans\ Mono\ Oblique\ for\ Powerline.ttf" ]; then 
    #     cp ./DejaVu\ Sans\ Mono\ Oblique\ for\ Powerline.ttf ~/Library/Fonts/
    # fi
    # if [ ! -f "~/Library/Fonts/DejaVu\ Sans\ Mono\ for\ Powerline.ttf" ]; then 
    #     cp ./DejaVu\ Sans\ Mono\ for\ Powerline.ttf ~/Library/Fonts/
    # fi
    echo "Please install powerline-fonts manually."

# install powerline-fonts on Linux
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    echo "Please install powerline-fonts manually."

# install powerline-fonts on MINGW32
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    echo "Please install powerline-fonts manually."

fi

# go back
cd ${ORIGINAL_PATH}

#
echo "|"
echo "exVim installed successfully!"
echo "|"
echo "You can run 'sh mvim_dev.sh' to preview exVim."
echo "You can also run 'sh replace.sh' to replace exVim with your Vim."