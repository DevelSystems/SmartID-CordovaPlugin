const fs = require('fs');
const path = require('path');

// Define el camino hacia el directorio de interés.
const iosPlatformPath = path.join('platforms', 'ios');
const swiftpmPath = 'xcshareddata/swiftpm';
const packageResolvedFilename = 'Package.resolved';

// Encuentra el .xcworkspace
fs.readdir(iosPlatformPath, (err, files) => {
    if (err) {
        return console.error('Error al listar los archivos del directorio iOS:', err);
    }

    const xcworkspaceDir = files.find(file => file.endsWith('.xcworkspace'));

    if (!xcworkspaceDir) {
        return console.error('No se encontró un directorio .xcworkspace.');
    }

    const swiftpmFullPath = path.join(iosPlatformPath, xcworkspaceDir, swiftpmPath);
    const packageResolvedFullPath = path.join(swiftpmFullPath, packageResolvedFilename);

    // Verifica si la carpeta swiftpm existe, si no, la crea
    fs.mkdir(swiftpmFullPath, { recursive: true }, (err) => {
        if (err) {
            return console.error('Error al crear la carpeta swiftpm:', err);
        }

        // Ahora, verifica si Package.resolved existe
        fs.readFile(packageResolvedFullPath, (err, data) => {
            let json = {
                object: {
                    pins: [
                        {
                            package: "keychainaccess",
                            repositoryURL: "https://github.com/kishikawakatsumi/KeychainAccess.git",
                            state: {
                                branch: null,
                                revision: "84e546727d66f1adc5439debad16270d0fdd04e7",
                                version: "4.2.2"
                            }
                        },
                        {
                            package: "smartid-ios",
                            repositoryURL: "https://github.com/DevelSystems/SmartID-iOS.git",
                            state: {
                                branch: null,
                                revision: "ef49e5fb79c09f9154ad5c9e4fe0374403484c1f",
                                version: "5.0.2"
                            }
                        }
                    ]
                },
                version: 1
            };

            if (err) {
                if (err.code === 'ENOENT') {
                    console.log('Package.resolved no existe, se creará uno nuevo.');
                } else {
                    return console.error('Error al leer Package.resolved:', err);
                }
            } else {
                try {
                    const existingJson = JSON.parse(data);
                    // Añade tu lógica aquí para combinar `existingJson.object.pins` con `json.object.pins` si es necesario
                } catch (parseError) {
                    console.error('Error al parsear Package.resolved existente:', parseError);
                }
            }

            // Escribe o actualiza el archivo Package.resolved
            fs.writeFile(packageResolvedFullPath, JSON.stringify(json, null, 2), (err) => {
                if (err) {
                    return console.error('Error al escribir en Package.resolved:', err);
                }
                console.log('Package.resolved actualizado/creado exitosamente.');
            });
        });
    });
});
