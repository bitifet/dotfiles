#!/bin/bash

echo "================================================================"
echo "                      - Software Setup -"
echo "================================================================"
sudo apt-get install vim dialog screen tmux git subversion git-svn ssh curl g++ python make


echo "================================================================"
echo "                         - GIT Setup -"
echo "================================================================"
echo -n "Enter user's full name: "
read git_user;
echo -n "Enter user email: "
read git_email
git config --global user.name "${git_user}"
git config --global user.email "${git_email}"
git config --global push.default simple
git config --global diff.noprefix true
echo "Setting aliases..."
echo "'git l' for 'git log --graph --all --decorate'"
git config --global alias.l 'log --graph --all --decorate'


echo "================================================================"
echo "                        - NodeJS Setup -"
echo "================================================================"
echo "Installing Node Version Manager (nvm):"
if [ \! -e ~/.nvm ]; then
    curl https://raw.githubusercontent.com/creationix/nvm/v0.11.1/install.sh | bash
    export NVM_DIR="/home/joanmi/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
    latestNode=$(nvm ls-remote | tail -n 1 | perl -pe 's/^\D*//');
    echo "Installing latest Node version (${latestNode}):"
    nvm install $latestNode
    echo "Setting it as default version:"
    nvm alias default $latestNode

    echo "Installing Miscellaneous Utilities:"
    echo "  - Underscore..."
    npm install -g underscore-cli
else
    echo "nvm already installed."
fi


echo "================================================================"
echo "                    - Miscellaneous Setup -"
echo "================================================================"
echo "Updating ~/.bashrc..."
cat ~/.bashrc | grep 'DotFiles Setup' > /dev/null && (
    echo "Already done."
) || ((
    echo "" >> ~/.bashrc
    echo "# DotFiles Setup:" >> ~/.bashrc
    echo "source ~/.etc/bashrc" >> ~/.bashrc
) && echo "Ok.");

echo "Setting vim as default editor:"
sudo update-alternatives --set editor /usr/bin/vim.basic && echo "Ok."


