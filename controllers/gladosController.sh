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
#glados_show_image
#glados_play_audio "/home/lau/.config/GitKraken/scripts/glados/resources/voices/general/bienvenido.wav"
#glados_show_status

# 🔁 Bucle interactivo
while true; do
  echo -ne "\e[38;2;255;204;0m🧠 ?: \e[0m"
  read -r input

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
    *)
      echo -e "\e[38;2;255;153;0m❓ Comando desconocido: '$input'. Fascinante. Has inventado un nuevo error.\e[0m"
      ;;
  esac
done
