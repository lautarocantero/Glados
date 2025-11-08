#!/usr/bin/env bash

# 📄 Ruta del README a crear
readme_path="./README.md"

# 📄 Ruta del contenido base estilo GLaDOS
glados_template="/home/lau/.config/GitKraken/scripts/git/glados_readme.sh"

# 🧠 Verificar si README.md existe
if [ ! -f "$readme_path" ]; then
  echo -e "\e[38;5;208m📄 README.md no encontrado. Creando con arte GLaDOS...\e[0m"

  # 🧠 Insertar contenido desde el archivo base
  if [ -f "$glados_template" ]; then
    cat "$glados_template" > "$readme_path"
    echo -e "\e[38;5;208m✅ README.md creado con éxito. GLaDOS aprueba tu estética.\e[0m"
  else
    echo -e "\e[31m❌ No se encontró el archivo de plantilla GLaDOS en: $glados_template\e[0m"
  fi
else
  echo -e "\e[33m🟡 README.md ya existe. GLaDOS está decepcionada, pero no sorprendida.\e[0m"
fi
