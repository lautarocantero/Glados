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
