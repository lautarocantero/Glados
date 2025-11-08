#!/bin/bash

# 📦 Cargar configuración desde .env (ruta fija)
env_path="/home/lau/.config/GitKraken/scripts/glados/.env"
if [ -f "$env_path" ]; then
  source "$env_path"
else
  echo -e "\e[38;2;255;187;102m[ ERROR ] No se encontró el archivo .env en $env_path ❌\e[0m"
  exit 1
fi

# 📥 Importar funciones visuales
source "$(dirname "$0")/../views/gladosView.sh"

# 📁 Rutas desde .env
json_path="$GLADOS_DIALOGS_PATH"
audio_path="$GLADOS_AUDIO_PATH"

# 🧠 Sesión GLaDOS con prompt naranja temporal
glados_session() {
  local original_ps1="$PS1"
  export PS1="

\[\e[38;2;255;154;0m\]

\u@\h:\w\$ 

\[\e[0m\]

"

  glados_show_image

  # audios
  session_flag="/tmp/glados_audio_played_$$"

  if [ -z "$GLADOS_SESSION_STARTED" ]; then
    export GLADOS_SESSION_STARTED=1
    glados_play_audio >/dev/null 2>&1 &
  fi
  # textos 
  # glados_show_text "Hola, Nika. Estoy observando..."

  export PS1="$original_ps1"
}

# ✅ Validar JSON y cargar frases
load_glados_dialogs() {
  if [ ! -f "$json_path" ]; then
    glados_show_error "No se encontró dialogs.json en $json_path"
    return 1
  fi

  mapfile -t glados_dialogs < <(jq -r '.[]' "$json_path")
  if [ ${#glados_dialogs[@]} -eq 0 ]; then
    glados_show_error "dialogs.json está vacío o malformado"
    return 1
  fi

  return 0
}

# 🎲 Obtener frase aleatoria
get_random_dialog() {
  local index=$((RANDOM % ${#glados_dialogs[@]}))
  echo "${glados_dialogs[$index]}"
}

# hacer fetching de dialogo

get_fetched_character_script() {
  local prompt="$1"
  echo -e "\e[38;5;208m📡 Fechteando a GLaDOS con el prompt: \"$prompt\"\e[0m"
}

# 🚦 Router de comandos para el modelo
case "$1" in
  "session")
    glados_session
    ;;
  "random")
    load_glados_dialogs && get_random_dialog
    ;;
  *)
    echo -e "\e[38;2;255;187;102m[ GLaDOS ] Comando desconocido: '$1' ❌\e[0m"
    ;;
esac