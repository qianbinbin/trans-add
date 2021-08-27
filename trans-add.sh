#!/usr/bin/env sh

MAGNETS_FILE="$HOME/.config/transmission-daemon/trans-add.magnet"
[ -n "$1" ] && MAGNETS_FILE="$1"

error() { echo "$@" >&2; }

log() {
  while read -r REPLY; do
    error "[$(date +%F-%T)] $REPLY"
  done
}

exist() { which "$1" >/dev/null 2>&1; }

exist curl || { error "curl not found"; exit 127; }
exist transmission-remote || { error "transmission-remote not found"; exit 127; }

URLS=$(cat)

if [ -z "$URLS" ]; then
  error "Usage: trans-add [MAGNETS_FILE] [<URLS_FILE]"
  error "Read urls from standard input."
  exit 2
fi

for url in $URLS; do
  content=$(curl -fsSL "$url")
  magnets=$(echo "$content" | grep "magnet:?[^[:space:]\"']*" -o)
  for magnet in $magnets; do
    # magnet:?xt=urn:btih:c12fe1c06bba254a9dc9f519b335aa7c1367a88a
    urn=$(echo "$magnet" | grep -i "=urn:.*:[^&]*" -o | cut -c2-)
    if grep -qs "$urn" "$MAGNETS_FILE"; then
      echo "Skipping: $urn" | log
      continue
    fi
    echo "Adding: $urn" | log
    transmission-remote -a "$magnet" && echo "$magnet" >>"$MAGNETS_FILE"
  done
done
