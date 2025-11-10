# 📥 Importar modelo

source "/home/lau/.config/GitKraken/scripts/glados/models/gladosModel.sh" || {
  echo -e "\e[38;2;255;102;102m❌ gladosModel.sh no se importó. Qué sorpresa. Es casi como si confiaras en tu código.\e[0m"
  exit 1
}

# 🧠 Inicializar importes desde el modelo
inicializar_importes_glados


AUDIO_PATH="/home/lau/.config/GitKraken/scripts/glados/resources/voices/general/bienvenido.wav"

if ! mpv "$AUDIO_PATH" 2>/dev/null; then
  echo -e "\e[38;2;255;102;102m❌ No se pudo reproducir '$AUDIO_PATH'. Qué irónico. Nadie te da la bienvenida, ni siquiera tu propio script.\e[0m"
  exit 1
fi

DIALOGS_PATH="/home/lau/.config/GitKraken/scripts/glados/resources/voices/gladosScript/gladosDialogs.json"

# Verificamos si el archivo existe
if [[ ! -f "$DIALOGS_PATH" ]]; then
  echo -e "\e[38;2;255;102;102m❌ El archivo que necesitabas?. no existe. Qué adorablemente incompetente. ¿Esperabas que apareciera por arte de magia?. ('$DIALOGS_PATH')\e[0m"
  exit 1
fi

# Intentamos reproducirlo, silenciando errores
if !jq empty "$JSON_PATH" 2>/dev/null; then
  echo -e "\e[38;2;255;102;102m❌ El JSON existe, pero está tan roto que ni siquiera 'jq' quiere tocarlo. Felicitaciones. (El archivo no es un json) \e[0m"
  exit 1
fi

# 🎭 Fase 1: GLaDOS (imagen + audio)
# if [ "$1" = "glados" ]; then
  # glados_show_image || {
    # echo -e "\e[38;2;255;102;102m❌ Falló la visualización de la imagen de GLaDOS\e[0m"
  # }

  # audio_path="/home/lau/.config/GitKraken/scripts/glados/resources/voices/bienvenido.wav"
  
  # if [ ! -f "$audio_path" ]; then
    # echo -e "\e[38;2;255;102;102m❌ Archivo de audio no encontrado: $audio_path\e[0m"
  # elif ! command -v ffplay &> /dev/null; then
    # echo -e "\e[38;2;255;102;102m❌ ffplay no está instalado. No se puede reproducir audio\e[0m"
  # else
    # glados_play_audio "$audio_path"
    # if [ $? -eq 0 ]; then
      # echo -e "\e[32m✅ Audio reproducido con éxito\e[0m"
    # else
      # echo -e "\e[38;2;255;102;102m❌ Error al reproducir el audio. GLaDOS está decepcionada.\e[0m"
    # fi
  # fi

  # exit 0
# fi

# if [ "$1" = "texto" ]; then
  # dialog="$(get_random_dialog)"
  # if [ -z "$dialog" ]; then
    # echo -e "\e[38;2;255;102;102m❌ No se pudo obtener un diálogo de GLaDOS\e[0m"

    # # 🎭 Reproducir sonido de error aleatorio
    # error_dir="/home/lau/.config/GitKraken/scripts/glados/resources/voices/error"
    # error_files=("$error_dir"/*.wav)
    # total_errors=${#error_files[@]}

    # if [ "$total_errors" -gt 0 ]; then
      # random_index=$((RANDOM % total_errors))
      # selected_error="${error_files[$random_index]}"
      # paplay "$selected_error" &>/dev/null &
    # else
      # echo -e "\e[38;2;255;102;102m⚠️ No se encontraron archivos de error en $error_dir\e[0m"
    # fi

  # else
    # glados_show_text_right_of_image "$dialog"
    # glados_show_status
  # fi
  # exit 0
# fi

# # 🧠 Fase 3: fetchear glados
# if [ "$1" = "ayudame" ]; then
  # prompt="${@:2}"
  # if [ -z "$prompt" ]; then
    # echo -e "\e[38;2;255;102;102m❌ No se proporcionó ningún prompt para GLaDOS\e[0m"
  # else
    # echo "🧠 Prompt capturado: $prompt"
    # get_fetched_character_script "$prompt" || {
      # echo -e "\e[38;2;255;102;102m❌ Falló la generación del script de personaje\e[0m"
    # }
  # fi
  # exit 0
# fi

# 🧼 Fase 4: callar glados
# if [ "$1" = 'callate' ]; then
  # kill_mp3_players || {
    # echo -e "\e[38;2;255;102;102m❌ No se pudieron detener los reproductores de audio\e[0m"
  # }
  # exit 0
# fi

# 🔌 Fase 5: Apagar la computadora con estilo
# if [ "$1" = "apagate" ]; then
  # kill_mp3_players

  # glados_show_image || {
    # echo -e "\e[38;2;255;102;102m❌ No se pudo mostrar la imagen de GLaDOS antes de apagar\e[0m"
  # }

  # glados_show_text_right_of_image "Adios sr. 💀"
  # glados_show_status

  # audio_path="/home/lau/.config/GitKraken/scripts/glados/resources/voices/adios.wav"
  # if [ -f "$audio_path" ] && command -v ffplay &> /dev/null; then
    # glados_play_audio "$audio_path"
    # sleep 3  # Espera para que se escuche el audio antes de apagar
  # fi

  # echo -e "\e[38;2;255;102;102m⚠️  GLaDOS ha iniciado la secuencia de apagado...\e[0m"
  # sleep 2
  # systemctl poweroff
  # exit 0
# fi


# 🧠 Fase única si no hay argumentos
glados_show_image || {
  echo -e "\e[38;2;255;102;102m❌ Falló la visualización de la imagen de GLaDOS\e[0m"
}

audio_path="/home/lau/.config/GitKraken/scripts/glados/resources/voices/general/bienvenido.wav"
if [[ -f "$audio_path" ]]; then
  if ! ffplay -nodisp -autoexit "$audio_path" 2>/dev/null; then
    echo -e "\e[38;2;255;102;102m❌ Lamento no poder responderte con mi voz. Se rompió. Como todo lo que tocas.\e[0m"
    exit 1
  fi
else
  echo -e "\e[38;2;255;102;102m❌ El archivo de audio no existe. Qué conveniente. Hasta los bits te abandonan.\e[0m"
  exit 1
fi

while true; do