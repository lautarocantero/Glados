#!/bin/bash

# 📥 Importar modelo y vista
source "$(dirname "$0")/../models/gladosModel.sh"
source "$(dirname "$0")/../views/gladosView.sh"
source "${dirname "$0"}/common/kill_mp3.sh"

# 🧩 Cargar frases
load_glados_dialogs || exit 1

# 🎭 Fase 1: GLaDOS (imagen + audio)
if [ "$1" = "glados" ]; then
  glados_show_image
  glados_play_audio >/dev/null 2>&1 &
  exit 0
fi

# 💬 Fase 2: Mostrar texto
if [ "$1" = "texto" ]; then
  glados_show_text "$(get_random_dialog)"
  glados_show_status
  exit 0
fi

# fetchear glados
if [ "$1" = "ayudame" ]; then
  prompt="${@:2}"
  echo "🧠 Prompt capturado: $prompt"
  get_fetched_character_script "$prompt"
  exit 0
fi

# callar glados 
if [ "$1" = 'callate' ]; then
  kill_mp3_players
  exit 0
fi

# 🧠 Fase única si no hay argumentos
glados_show_image
glados_play_audio >/dev/null 2>&1 &
glados_show_text "$(get_random_dialog)"
glados_show_status
