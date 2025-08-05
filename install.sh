#!/bin/bash

source paths.sh
source logging.sh

create_path() {
  if [[ ! -d $1 ]]; then
    log "Creating $1 path..."
    mkdir -p $1
  fi
}

create_path $ICONS_PATH
create_path $APPLICATIONS_PATH

log "Copying logo to $ICONS_PATH ..."
cp Kindle.png $ICONS_PATH

log "Installing NPM dependecies ..."
npm i

log "Making flatpak distribution ..."
npm run make

log "Installing flatpak ..."
flatpak install --user io.atom.electron.kindle

log "Installing kindle.desktop to ~/.config/local/share/applications ..."
desktop-file-install --dir=$APPLICATIONS_PATH kindle.desktop

log "Updating application database ..."
update-desktop-database $APPLICATIONS_PATH
