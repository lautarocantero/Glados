#!/bin/bash

# Archivos
json_path="/home/lau/.config/GitKraken/scripts/glados/dialogs.json"

# Verificar existencia de archivo JSON
if [ ! -f "$json_path" ]; then
  echo -e "\e[31mError:\e[0m No se encontró dialogs.json ❌"
  exit 1
fi

# Cargar frases desde dialogs.json
mapfile -t glados_dialogs < <(jq -r '.[]' "$json_path")

if [ ${#glados_dialogs[@]} -eq 0 ]; then
  echo -e "\e[31mError:\e[0m dialogs.json está vacío o malformado ❌"
  exit 1
fi

# Mostrar imagen con Kitty desde URL
kitty +kitten icat --transfer-mode=stream "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fi1.theportalwiki.net%2Fimg%2F7%2F79%2FGLaDOS_P2.png&f=1&nofb=1&ipt=8dcf0a2c11a669d4f63f929c9d97061fa857b72d529d78cae92e01a4f976c628"

# Pausa breve para efecto dramático
sleep 0.5

# Seleccionar respuesta aleatoria
index=$((RANDOM % ${#glados_dialogs[@]}))
respuesta="${glados_dialogs[$index]}"

# Dividir respuesta en líneas si es larga
IFS=$'\n' read -rd '' -a respuesta_lines <<< "$(echo "$respuesta" | fold -s -w 50)"

# Imprimir respuesta alineada a la derecha
for ((i = 0; i < ${#respuesta_lines[@]}; i++)); do
  texto="${respuesta_lines[$i]}"
  printf "%90s\n" "$texto"
done

# Emoji de estado final
echo -e "\n                                                                                          \e[32m✅ Éxito\e[0m"
