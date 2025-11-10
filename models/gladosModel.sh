#!/bin/bash

# 🧠 Definir variables de entorno antes de usarlas
GLADOS_AUDIO_KILLER="/home/lau/.config/GitKraken/scripts/common/kill_mp3.sh"
GLADOS_DIALOGS_PATH="/home/lau/.config/GitKraken/scripts/glados/resources/voices/gladosScript/gladosDialogs.json"
GLADOS_AUDIO_PATH="/home/lau/.config/GitKraken/scripts/glados/resources/voices/general/bienvenido.wav"
GLADOS_ASCII="/home/lau/.config/GitKraken/scripts/glados/resources/gladosAsciiVisual.txt"
GLADOS_README="/home/lau/.config/GitKraken/scripts/git/create_readme_with_glados.sh"
GLADOS_ENV="/home/lau/.config/GitKraken/scripts/glados/.env"

if [[ ! -f "$GLADOS_AUDIO_KILLER" ]]; then
  echo -e "\e[38;2;255;102;102m❌ El archivo GLADOS_AUDIO_KILLER no existe. Qué adorablemente inútil.\e[0m"
  exit 1
fi

source "$GLADOS_AUDIO_KILLER" || {
  echo -e "\e[38;2;255;102;102m❌ kill_mp3.sh no se pudo importar. Tal vez los MP3s prefieren vivir. Qué egoístas.\e[0m"
  exit 1
}

# 📦 Cargar configuración desde .env (ruta fija)
env_path=$GLADOS_ENV
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
  glados_show_status

  # audios
  session_flag="/tmp/glados_audio_played_$$"

  if [ -z "$GLADOS_SESSION_STARTED" ]; then
    export GLADOS_SESSION_STARTED=1
    glados_play_audio >/dev/null 2>&1 &
  fi
  # textos 
  echo -e "\e[38;2;102;255;178m✅ Componentes de GLaDOS importados con éxito. Qué milagro.\e[0m"
  echo -ne "\e[38;2;255;204;0m🧠 ?: \e[0m"
  read -r input

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
  bash "$GLADOS_AI_PATH"
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

inicializar_importes_glados() {
  local base_dir="$(dirname "$0")/.."

  source "$base_dir/views/gladosView.sh" || {
    echo -e "\e[38;2;255;102;102m❌ gladosView.sh falló. Pero no te preocupes, seguro que el resto también lo hará.\e[0m"
    exit 1
  }

}




