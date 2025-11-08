#!/bin/bash

# Ruta al audio de GLaDOS
audio_path="$GLADOS_AUDIO_PATH"

glados_show_image() {
  local image_url="https://i1.theportalwiki.net/img/7/79/GLaDOS_P2.png"
  local controller_path="/home/lau/.config/GitKraken/scripts/glados/controllers/glados.sh"

  # 🧪 Verificar si estamos en Kitty
  if [ "$TERM" != "xterm-kitty" ]; then
    echo -e "\e[33m⚠️ No estás en Kitty. Intentando iniciar Kitty para mostrar la imagen...\e[0m"

    if command -v kitty &> /dev/null; then
      kitty --detach bash "$controller_path" || {
        echo -e "\e[38;2;255;102;102m[ ERROR ] No se pudo iniciar Kitty. Imagen no mostrada ❌\e[0m"
        return 1
      }
      exit 0
    else
      echo -e "\e[38;2;255;102;102m[ ERROR ] Kitty no está instalado. No se puede mostrar la imagen ❌\e[0m"
      return 1
    fi
  fi

  # 🖼️ Mostrar imagen si estamos en Kitty
  if ! kitty +kitten icat --clear --align left --scale-up "$image_url"; then
    echo -e "\e[38;2;255;102;102m[ ERROR ] Falló la visualización de la imagen con icat ❌\e[0m"
    return 1
  fi

  sleep 0.5
}

# 💬 Mostrar texto alineado a la derecha del terminal

glados_show_text() {
  local mensaje="$1"
  local delay=0.015
  local color="\e[38;2;255;154;0m"

  echo -ne "$color"
  local count=0
  for ((i=0; i<${#mensaje}; i++)); do
    printf "%s" "${mensaje:$i:1}"
    sleep "$delay"
    ((count++))
    if (( count % 50 == 0 )); then
      echo
    fi
  done
  echo -e "\e[0m"
}



# ❌ Mostrar error con estilo GLaDOS
glados_show_error() {
  local mensaje="$1"
  echo -e "\n                                                                                          \e[38;2;255;102;102m[ ERROR ] $mensaje ❌\e[0m"
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
