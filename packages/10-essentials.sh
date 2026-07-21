#!/usr/bin/env bash
# Essentials: system tools required for everything else.
# Installs: git, curl, stow, build-essential, dialog/whiptail

CATEGORY="essentials"
DESCRIPTION="System essentials (git, curl, stow, build tools)"

install() {
    apt_install git curl stow build-essential g++ make ssh
    apt_install whiptail dialog 2>/dev/null || true
}

post_install() {
    # Nothing extra needed
    :
}
