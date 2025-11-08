#!/bin/bash

# Ruta al audio de GLaDOS
audio_path="$HOME/Música/Voz_glados.mp3"

# 🖼️ Mostrar imagen de GLaDOS con Kitty
glados_show_image() {
  kitty +kitten icat --clear --align right --scale-up \
    "https://i1.theportalwiki.net/img/7/79/GLaDOS_P2.png"
  sleep 0.5
}

# 💬 Mostrar texto alineado a la derecha
glados_show_text() {
  local mensaje="$1"
  IFS=$'\n' read -rd '' -a lines <<< "$(echo "$mensaje" | fold -s -w 50)"
  for linea in "${lines[@]}"; do
    printf "%90s\n" "$linea"
  done
}

# ✅ Mostrar estado final
glados_show_status() {
  echo -e "\n                                                                                          \e[32m✅ Éxito\e[0m"
}

# 🔊 Reproducir audio si existe
glados_play_audio() {
  if [ -f "$audio_path" ]; then
    ffplay -nodisp -autoexit "$audio_path" > /dev/null 2>&1
  else
    echo -e "\e[33m⚠️ No se encontró el archivo de audio: $audio_path\e[0m"
  fi
}
