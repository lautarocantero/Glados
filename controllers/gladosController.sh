#!/bin/bash

# 📥 Importar modelo y vista
source "$(dirname "$0")/../models/gladosModel.sh"
source "$(dirname "$0")/../views/gladosView.sh"

# 🧠 Nombre de la sesión tmux
SESSION="glados_session"

# 🔍 Verificar si tmux está instalado
if ! command -v tmux &> /dev/null; then
  echo -e "\e[33m⚠️ tmux no está instalado. Intentando instalar...\e[0m"
  if command -v apt &> /dev/null; then
    sudo apt update && sudo apt install -y tmux
    if [ $? -ne 0 ]; then
      glados_show_error "No se pudo instalar tmux automáticamente."
      exit 1
    fi
  else
    glados_show_error "No se encontró apt. Instalación manual requerida."
    exit 1
  fi
fi

# 🚦 Si no estamos dentro de tmux, iniciar sesión dividida
if [ -z "$TMUX" ]; then
  tmux new-session -d -s "$SESSION" \; \
    split-window -h \; \
    select-pane -t 0 \; \
    send-keys "bash \"$0\"" C-m \; \
    select-pane -t 1 \; \
    send-keys "clear" C-m \; \
    attach-session -t "$SESSION"
  exit 0
fi

# 🧩 Cargar frases
load_glados_dialogs || exit 1

# 🎭 Fase 1: GLaDOS (imagen + audio)
if [ "$1" = "glados" ]; then
  glados_show_image
  glados_play_audio
  exit 0
fi

# 💬 Fase 2: Mostrar texto en panel derecho
if [ "$1" = "texto" ]; then
  sleep 1.5
  glados_show_text "$(get_random_dialog)"
  glados_show_status
  exit 0
fi
# 🧩 Cargar frases
load_glados_dialogs || exit 1

# 🎭 Fase 1: GLaDOS (imagen + audio)
if [ "$1" = "glados" ]; then
  glados_show_image
  glados_play_audio
  exit 0
fi

# 💬 Fase 2: Mostrar texto en panel derecho
if [ "$1" = "texto" ]; then
  sleep 1.5
  glados_show_text "$(get_random_dialog)"
  glados_show_status
  exit 0
fi
# 🧩 Cargar frases
load_glados_dialogs || exit 1

# 🎭 Fase 1: GLaDOS (imagen + audio)
if [ "$1" = "glados" ]; then
  glados_show_image
  glados_play_audio
  exit 0
fi

# 💬 Fase 2: Mostrar texto en panel derecho
if [ "$1" = "texto" ]; then
  sleep 1.5
  glados_show_text "$(get_random_dialog)"
  glados_show_status
  exit 0
fi
# 🧩 Cargar frases
load_glados_dialogs || exit 1

# 🎭 Fase 1: GLaDOS (imagen + audio)
if [ "$1" = "glados" ]; then
  glados_show_image
  glados_play_audio
  exit 0
fi

# 💬 Fase 2: Mostrar texto en panel derecho
if [ "$1" = "texto" ]; then
  sleep 1.5
  glados_show_text "$(get_random_dialog)"
  glados_show_status
  exit 0
fi
# 🧩 Cargar frases
load_glados_dialogs || exit 1

# 🎭 Fase 1: GLaDOS (imagen + audio)
if [ "$1" = "glados" ]; then
  glados_show_image
  glados_play_audio
  exit 0
fi

# 💬 Fase 2: Mostrar texto en panel derecho
if [ "$1" = "texto" ]; then
  sleep 1.5
  glados_show_text "$(get_random_dialog)"
  glados_show_status
  exit 0
fi
# 🧩 Cargar frases
load_glados_dialogs || exit 1

# 🎭 Fase 1: GLaDOS (imagen + audio)
if [ "$1" = "glados" ]; then
  glados_show_image
  glados_play_audio
  exit 0
fi

# 💬 Fase 2: Mostrar texto en panel derecho
if [ "$1" = "texto" ]; then
  sleep 1.5
  glados_show_text "$(get_random_dialog)"
  glados_show_status
  exit 0
fi
# 🧩 Cargar frases
load_glados_dialogs || exit 1

# 🎭 Fase 1: GLaDOS (imagen + audio)
if [ "$1" = "glados" ]; then
  glados_show_image
  glados_play_audio
  exit 0
fi

# 💬 Fase 2: Mostrar texto en panel derecho
if [ "$1" = "texto" ]; then
  sleep 1.5
  glados_show_text "$(get_random_dialog)"
  glados_show_status
  exit 0
fi
# 🧩 Cargar frases
load_glados_dialogs || exit 1

# 🎭 Fase 1: GLaDOS (imagen + audio)
if [ "$1" = "glados" ]; then
  glados_show_image
  glados_play_audio
  exit 0
fi

# 💬 Fase 2: Mostrar texto en panel derecho
if [ "$1" = "texto" ]; then
  sleep 1.5
  glados_show_text "$(get_random_dialog)"
  glados_show_status
  exit 0
fi
# 🧩 Cargar frases
load_glados_dialogs || exit 1

# 🎭 Fase 1: GLaDOS (imagen + audio)
if [ "$1" = "glados" ]; then
  glados_show_image
  glados_play_audio
  exit 0
fi

# 💬 Fase 2: Mostrar texto en panel derecho
if [ "$1" = "texto" ]; then
  sleep 1.5
  glados_show_text "$(get_random_dialog)"
  glados_show_status
  exit 0
fi
# 🧩 Cargar frases
load_glados_dialogs || exit 1

# 🎭 Fase 1: GLaDOS (imagen + audio)
if [ "$1" = "glados" ]; then
  glados_show_image
  glados_play_audio
  exit 0
fi

# 💬 Fase 2: Mostrar texto en panel derecho
if [ "$1" = "texto" ]; then
  sleep 1.5
  glados_show_text "$(get_random_dialog)"
  glados_show_status
  exit 0
fi
