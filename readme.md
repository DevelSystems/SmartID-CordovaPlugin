# Actualización de versión de plugin

## 1. Eliminación de plugin anterior

Se debe eliminar el plugin anterior con el siguiente comando:

```bash
cordova plugin remove com.develsystems.smartidplugin
```

## 2. Agregar nueva versión del plugin

Utilizar el siguiente comando para instalar la nueva versión del plugin que soporta la versión 5 de SmartID:

```bash
cordova plugin add https://github.com/DevelSystems/SmartID-CordovaPlugin#v5-11.1.0
```

## 3. Actualizar la versión del SDK nativo de SmartID

### 1. iOS

Se debe eliminar la versión anterior de SmartID desde el Swift package manager:

![](https://firebasestorage.googleapis.com/v0/b/wilver-martinez.appspot.com/o/Screenshot%202024-01-25%20at%2012.48.11.png?alt=media&token=6b4d451a-08ae-4fa8-b875-fcfd9a1d8a78)

Agregar la versión 5 del sdk nativo de SmartID:

![](https://firebasestorage.googleapis.com/v0/b/wilver-martinez.appspot.com/o/Screenshot%202024-01-25%20at%2012.50.54.png?alt=media&token=4e2d46f6-7f50-42e2-b682-50a5376b7554)

Repositorio de SmartID: https://github.com/DevelSystems/SmartID-iOS

Version: 5.0.0

Es necesario agregar la dependencia KeyChainAccess: https://github.com/kishikawakatsumi/KeychainAccess en su versión 4.2.2

### Android

Se debe agregar el repositorio maven y en el archivo build.gradle agregar la dependencia (Consutar al equipo de SmartID por esta información)

## 4. Implementación del plugin

### 1. Eliminar las llamadas a los metodos de la version anterior

Se deben eliminar las llamadas a los siguientes metodos:

`initSmartId`

`linkSmartId`

`unLinkSmartId`

`smartCoreOperation`

### 2. Implementar nuevo método para obtener información del dispositivo

Para poder obtener la información del dispositivo a través del sdk de SmartID se debe utilizar el siguiente método:



```jsx
cordova.plugins
            .SmartIdPlugin
            .getRawData([""], response => {
                console.log(response);
            }, error => {
                console.log(error);
            });
```

El método `getRawData` recibe los parámetros:

`arguments`: Parametros adicionales que se envían al sdk nativo

`response`: Callback que envía el resultado de la parte nativa a javascript, este valor es un json con la siguiente estructura:

```json
{
  "data": "<datos del dispositivo cifrado>"
}
```

`error`: Callback que envía un mensaje de error en caso de que el proceso interno falle.
