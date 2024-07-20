#!/bin/bash

set -o errexit
set -o xtrace

TMP_DIR="$(dirname $0)/tmp"
BUILD_DIR=$(if [[ -z $1 ]]; then echo "./"; else echo $1; fi)
HOMEBREW_DIR=switch
OVERLAY_DIR=switch/.overlays

UNZIP_COMMAND="unzip -o"

Themezer() {
    download_url=$(curl -s https://api.github.com/repos/suchmememanyskill/themezer-nx/releases/latest | jq -r ".assets[0].browser_download_url")
    curl -O -L $download_url --output-dir $TMP_DIR
    cp $TMP_DIR/themezer-nx.nro -d $BUILD_DIR/$HOMEBREW_DIR
}

SaltyNX() {
    download_url=$(curl -s https://api.github.com/repos/masagrator/SaltyNX/releases/latest | jq -r ".assets[0].browser_download_url")
    curl -O -L $download_url --output-dir $TMP_DIR
    $UNZIP_COMMAND $TMP_DIR/SaltyNX*.zip -d $BUILD_DIR/
}

ThemeInjector() {
    download_url=$(curl -s https://api.github.com/repos/exelix11/SwitchThemeInjector/releases/latest | jq -r ".assets[0].browser_download_url")
    curl -O -L $download_url --output-dir $TMP_DIR
    cp $TMP_DIR/NXThemesInstaller.nro -d $BUILD_DIR/$HOMEBREW_DIR
}

DBI() {
    download_url=$(curl -s https://api.github.com/repos/rashevskyv/dbi/releases/latest | jq -r ".assets[1].browser_download_url")
    curl -O -L $download_url --output-dir $TMP_DIR
    cp $TMP_DIR/DBI.nro -d $BUILD_DIR/$HOMEBREW_DIR/DBI
}

Appstore() {
    download_url=$(curl -s https://api.github.com/repos/fortheusers/hb-appstore/releases/latest | jq -r ".assets[0].browser_download_url")
    curl -O -L $download_url --output-dir $TMP_DIR
    cp $TMP_DIR/appstore.nro -d $BUILD_DIR/$HOMEBREW_DIR
}

Switchfin() {
    download_url=$(curl -s https://api.github.com/repos/dragonflylee/switchfin/releases/latest | jq -r ".assets[6].browser_download_url")
    curl -O -L $download_url --output-dir $TMP_DIR
    cp $TMP_DIR/Switchfin.nro -d $BUILD_DIR/$HOMEBREW_DIR/Switchfin
}

Edizon() {
    download_url=$(curl -s https://api.github.com/repos/proferabg/Edizon-Overlay/releases/latest | jq -r ".assets[0].browser_download_url")
    curl -O -L $download_url --output-dir $TMP_DIR
    $UNZIP_COMMAND $TMP_DIR/EdiZon-Overlay.zip -d $BUILD_DIR/
}

ReverseNX() {
    download_url=$(curl -s https://api.github.com/repos/masagrator/ReverseNX-RT/releases/latest | jq -r ".assets[0].browser_download_url")
    curl -O -L $download_url --output-dir $TMP_DIR
    cp $TMP_DIR/ReverseNX-RT-ovl.ovl -d $BUILD_DIR/$OVERLAY_DIR
}

SysModules() {
    download_url=$(curl -s https://api.github.com/repos/WerWolv/ovl-sysmodules/releases/latest | jq -r ".assets[0].browser_download_url")
    curl -O -L $download_url --output-dir $TMP_DIR
    cp $TMP_DIR/ovlSysmodules.ovl -d $BUILD_DIR/$OVERLAY_DIR
}

Sys-Clk() {
    download_url=$(curl -s https://api.github.com/repos/retronx-team/sys-clk/releases/latest | jq -r ".assets[0].browser_download_url")
    curl -O -L $download_url --output-dir $TMP_DIR
    $UNZIP_COMMAND $TMP_DIR/sys-clk*.zip -x README.md -d $BUILD_DIR/
}

Emuiibo() {
    download_url=$(curl -s https://api.github.com/repos/XorTroll/emuiibo/releases/latest | jq -r ".assets[0].browser_download_url")
    curl -O -L $download_url --output-dir $TMP_DIR
    $UNZIP_COMMAND $TMP_DIR/emuiibo.zip -d $TMP_DIR
    cp -r $TMP_DIR/SdOut/* $BUILD_DIR
}

StatusMonitor() {
    download_url=$(curl -s https://api.github.com/repos/masagrator/Status-Monitor-Overlay/releases/latest | jq -r ".assets[0].browser_download_url")
    curl -O -L $download_url --output-dir $TMP_DIR
    $UNZIP_COMMAND $TMP_DIR/Status-Monitor-Overlay.zip -d $BUILD_DIR/
}

Ultrahand() {
    download_url=$(curl -s https://api.github.com/repos/ppkantorski/Ultrahand-Overlay/releases/latest | jq -r ".assets[1].browser_download_url")
    curl -O -L $download_url --output-dir $TMP_DIR
    cp $TMP_DIR/ovlmenu.ovl -d $BUILD_DIR/$OVERLAY_DIR
}

mkdir $TMP_DIR
mkdir -p $OVERLAY_DIR

# Homebrews
Themezer
ThemeInjector
SaltyNX
DBI
Appstore
Switchfin

# Overlays
Edizon
ReverseNX
SysModules
Sys-Clk
Emuiibo
StatusMonitor
Ultrahand

rm -rf $TMP_DIR
