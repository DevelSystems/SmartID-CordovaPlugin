#!/bin/bash

# Directorio del proyecto Cordova
CORDOVA_PROJECT_DIR=$(pwd)

# Directorio del proyecto Xcode dentro del proyecto Cordova
XCODE_PROJECT_DIR="$CORDOVA_PROJECT_DIR/platforms/ios"

# Verifica si el directorio del proyecto Xcode existe
if [ ! -d "$XCODE_PROJECT_DIR" ]; then
    echo "El directorio del proyecto Xcode no existe: $XCODE_PROJECT_DIR"
    exit 1
fi

# Navega al directorio del proyecto Xcode
cd "$XCODE_PROJECT_DIR"

# Verifica si existe un archivo Package.swift
if [ ! -f "Package.swift" ]; then
    echo "Package.swift no encontrado. Inicializando un nuevo paquete Swift..."

    # Inicializa un paquete Swift básico
    # Esto creará un Package.swift básico en el directorio actual
    swift package init --type executable

    # Verifica si el comando fue exitoso
    if [ $? -ne 0 ]; then
        echo "No se pudo inicializar un nuevo paquete Swift."
        exit 1
    else
        echo "Nuevo paquete Swift inicializado exitosamente."
    fi
fi

# Intenta agregar la dependencia utilizando Swift Package Manager
swift package add https://github.com/kishikawakatsumi/KeychainAccess.git --tag v4.2.2
swift package add https://github.com/DevelSystems/SmartID-iOS.git --tag 5.0.2

# Verifica si el comando fue exitoso
if [ $? -ne 0 ]; then
    echo "No se pudo agregar la dependencia SmartID-iOS al proyecto."
    exit 1
else
    echo "La dependencia SmartID-iOS fue agregada exitosamente al proyecto."
fi
