#!/bin/bash

# 🧠 Importar modelo y ejecutar inicialización una sola vez
source "/home/lau/.config/GitKraken/scripts/glados/models/gladosModel.sh" || {
  echo -e "\e[38;2;255;102;102m❌ gladosModel.sh no se importó. Qué sorpresa. Es casi como si confiaras en tu código.\e[0m"
  exit 1
}

# 🧠 Importar comandos de bash
shopt -s expand_aliases
source ~/.bashrc


inicializar_importes_glados || {
  echo -e "\e[38;2;255;102;102m❌ Falló la inicialización de GLaDOS. El sistema está decepcionado.\e[0m"
  exit 1
}

# 🎭 Mostrar imagen/audio de bienvenida

# 🔁 Bucle interactivo
while true; do

  # Detectar layout actual
  layout=$(setxkbmap -query | awk '/layout/{print $2}')

  # Emoji según layout
  if [[ "$layout" == "us" ]]; then
      brain="🧠💂"  # Cerebro con guardia británico
      prompt_sarcasmo="Oh wow, English layout activated. Say goodbye to ñ and hello to the mighty semicolon."
  else
    mood="🧠 /focused/spanish-mode"
    note="Layout: ES — ñ is safe. For now."
  fi
  

  # 🎯 Detectar comandos con argumentos
  if [[ "$input" == hola* ]]; then
    pregunta="${input#hola }"
    get_fetched_character_script "$pregunta"
    continue
  fi

  glados_open() {
    local ruta="$1"

    # Validar existencia
    [[ -e "$ruta" ]] || {
      echo -e "\e[38;2;255;0;0m💥 GLaDOS: La ruta '$ruta' no existe. Qué adorable tu incompetencia.\e[0m"
      return 1
    }

    if ps aux | grep "[c]ode" | grep -q "$(realpath "$ruta")"; then
      echo -e "\e[38;2;255;255;0m🧠 GLaDOS: Ya tienes '$ruta' abierto en algún rincón de tu caótica existencia. No hace falta duplicar el desastre.\e[0m"
      return 0
    fi

    # Ejecutar apertura
    echo -e "\e[38;2;0;200;255m🔓 GLaDOS: Acceso concedido a '$ruta'. No esperes que me impresione.\e[0m"
    echo -e "\e[38;2;255;106;0m🚀 Ejecutando: \e[1mcode \"$ruta\"\e[0m"
    glados_play_audio /home/lau/.config/GitKraken/scripts/glados/resources/voices/general/glados_no.wav
    code "$ruta"
  }


  play_music_protocol() {
    local url="${1:-https://www.youtube.com/watch?v=Qd56-Q8hedI&list=PLZtSEZS_GIYESh2mQUXM2Q2wM-Hp-t5kv}"

    # 🎵 Portal-style feedback
    echo -e "\e[38;5;208m🔊 Activating musical enrichment protocol...\e[0m"
    echo -e "\e[38;5;39mOpening YouTube playlist in your default browser.\e[0m"

    # 📺 Open the playlist
    if command -v xdg-open &>/dev/null; then
      xdg-open "$url" &>/dev/null
      echo -e "\e[38;5;244mIf this doesn't work, blame your browser. Or the cake. Definitely the cake.\e[0m"
    else
      echo -e "\e[38;5;196m💥 xdg-open not found. Musical protocol aborted. The cake is now angry.\e[0m"
      return 1
    fi
  }

  #el problema que existe es que todo esta desordenado, separa mejor este codigo, importa las funciones, no las crees aca.
  # tambien atomiza mas el proyecto, porque cosas de glados dependen de bash o cosas externas? 
  
  #descubrir porque glados solo acepta un comando y luego se estropea, maldita sea.

  case "$input" in
    "despertar")
      echo 'despertar'
      break
      ;;
    "salir"|"exit")
      echo -e "\e[38;2;255;102;102m❌ Cerrando sesión. GLaDOS se va. Vos te quedás con tus errores.\e[0m"
      break
      ;;
    "estado")
      echo -e "\e[38;2;102;255;178m✅  Estado del sistema: funcional, a pesar de vos.\e[0m"
      ;;
    "ayuda")
      glados_open /home/lau/.config/GitKraken/scripts/glados
      echo -e "\e[38;2;178;102;255m📖 Comandos disponibles: hola <pregunta>, estado, ayuda, salir. No esperes milagros.\e[0m"
      ;;
    "musica")
      play_music_protocol
      ;;
    "ingles")
      setxkbmap us
      echo -e "\eOh, you prefer the English keyboard layout? How *exotic*—nothing screams adventure like abandoning ñ and embracing the mighty semicolon.\e[0m"
      glados_prompt
      ;;
      
    *)
        # Mostrar estado sin salto de línea
        echo -ne "\e[38;2;255;204;0m📍 /where/am/I/$mood → $note \e[0m"

        # Leer input en la misma línea
        read -r input

      ;;
  esac
done
