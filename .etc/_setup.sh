#!/bin/bash

echo "================================================================"
echo "                      - Software Setup -"
echo "================================================================"
sudo apt-get install vim dialog screen tmux git

echo "================================================================"
echo "                         - GIT Setup -"
echo "================================================================"
echo -n "Enter user's full name: "
read git_user;
echo -n "Enter user email: "
read git_email
git config --global user.name "${git_user}"
git config --global user.email "${git_email}"


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

