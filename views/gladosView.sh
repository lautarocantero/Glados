#!/bin/bash

# Ruta al audio de GLaDOS

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

glados_show_text_async() {
  local mensaje="$1"
  local delay=0.03
  local color="\e[38;2;255;154;0m"

  (
    tput civis  # Ocultar cursor temporalmente
    echo -ne "$color"
    local cols=$(tput cols)
    local row=2

    for ((i=0; i<${#mensaje}; i++)); do
      tput cup "$row" "$((cols - 50))"
      printf "%s" "${mensaje:$i:1}"
      sleep "$delay"
      ((row++))
      if (( row > $(tput lines) - 2 )); then
        row=2
      fi
    done
    echo -e "\e[0m"
    tput cnorm  # Restaurar cursor
  ) &
}

glados_show_text_right_of_image() {
  local mensaje="$1"
  local delay=0.03
  local color="\e[38;2;255;154;0m"

  (
    tput civis  # Ocultar cursor
    echo -ne "$color"

    local cols=$(tput cols)
    local lines=$(tput lines)
    local start_col=$((cols / 2 + 10))  # Ajustá según el ancho de la imagen
    local row=2

    for ((i=0; i<${#mensaje}; i++)); do
      tput cup "$row" "$start_col"
      printf "%s" "${mensaje:$i:1}"
      sleep "$delay"
      ((row++))
      if (( row > lines - 2 )); then
        row=2
      fi
    done

    echo -e "\e[0m"
    tput cnorm  # Restaurar cursor
  ) &
}


# ❌ Mostrar error con estilo GLaDOS
glados_show_error() {
  echo 'hubo un error'
  local mensaje="$1"
  echo -e "\n                                                                                          \e[38;2;255;102;102m[ ERROR ] $mensaje ❌\e[0m"
}

# ✅ Mostrar estado final
glados_show_status() {
  echo -e "\n                                                                                          \e[32m✅ Éxito\e[0m"
}

# 🔊 Reproducir audio si existe
glados_play_audio() {
  audio_path="$1"
  if [ -f "$audio_path" ]; then
    ffplay -nodisp -autoexit "$audio_path" > /dev/null 2>&1
  else
    echo -e "\e[33m⚠️ No se encontró el archivo de audio: $audio_path, lamentablemente, era la solucion a tu problema \e[0m"
  fi
}

glados_audio_state() {
  local audio="$1"
  if [ -f "$audio" ]; then
    ffplay -nodisp -autoexit "$audio" > /dev/null 2>&1
    return 0  # Éxito
  else
    return 1  # Fallo
  fi
}
