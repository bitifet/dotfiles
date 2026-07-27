#!/usr/bin/env bash
# LibreOffice: latest via PPA

CATEGORY="libreoffice"
DESCRIPTION="LibreOffice (latest via PPA)"

install() {
    # Check if PPA version is already installed
    if apt-cache policy libreoffice 2>/dev/null | grep -q 'ppa.launchpadcontent.net/libreoffice'; then
        ok "LibreOffice PPA version already installed"
        return 0
    fi

    # If installed but from distro repo, offer upgrade
    if command -v libreoffice &>/dev/null; then
        info "LibreOffice found (distro version, not PPA)"
        if ! confirm "Replace with latest PPA version?"; then
            return 0
        fi
        sudo apt-get remove -y libreoffice* 2>/dev/null || true
    fi

    info "Adding LibreOffice PPA..."
    ensure_add_apt_repository
    sudo add-apt-repository -y ppa:libreoffice/ppa
    sudo apt-get update -qq
    apt_install libreoffice libreoffice-l10n-ca libreoffice-help-ca 2>/dev/null || apt_install libreoffice
}
