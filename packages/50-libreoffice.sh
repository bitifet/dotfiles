#!/usr/bin/env bash
# LibreOffice: latest via PPA

CATEGORY="libreoffice"
DESCRIPTION="LibreOffice (latest via PPA)"

install() {
    if command -v libreoffice &>/dev/null; then
        ok "LibreOffice already installed"
        return 0
    fi

    info "Adding LibreOffice PPA..."
    sudo add-apt-repository -y ppa:libreoffice/ppa
    sudo apt-get update -qq
    apt_install libreoffice libreoffice-l10n-ca libreoffice-help-ca 2>/dev/null || apt_install libreoffice
}
