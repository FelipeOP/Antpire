## Antpire
Una aplicacion que te ayuda con tus finanzas personales

## Depedencias
- [Flutter SDK 2.5.1](https://flutter.dev/docs/development/tools/sdk/releases "Flutter SDK 2.5.1")
- Dart 2.14.2
- [Android Command Line](http://https://developer.android.com/studio?gclid=EAIaIQobChMI3s6N5JCe8wIVTeG1Ch1-zwq0EAAYASAAEgJlpvD_BwE&gclsrc=aw.ds#downloads "Android Command Line")

##Instalación Andorid SDK en Windows 10
Una vez ya descargada la linea de comandos de android, se debe descomprimir y ajustar para que la ruta quede de la siguiente manea:
> C:\android-sdk\cmdline-tools\latest\ourzipfile

Es muy importante tenerla de esa manera para que el sdkmanager renozca bien la ruta. Una vez hecho esto, agregar la ruta a las variables nuestro sistema.
>SETX sdkmanager C:\android-sdk\cmdline-tools\latest\bin

Se debe definir la ruta donde se encuentra el Android SDK, en nuestro caso, está en la misma ruta donde se descargó el cmdline-tools y el JDK. Si Flutter da algún error con respecto a Java, debemos cambiar la versión de nuestro JDK o verificar la ruta.
>SETX ANDROID_HOME  C:\android-sdk\
SETX ANDROID_SDK_ROOT C:\android-sdk\
SETX JAVA_HOME C:\Program Files\Java\jdk-11.0.10

### Comandos

#### Actualizar paquetes
>sdkmanager \--update

#### Instalar Android SDK y build tools (para flutter)
> sdkmanager "platform-tools" "platforms;android-29"
> sdkmanager "build-tools;28.0.3"

#### Emulador para Android
>sdkmanager "system-images;android-29;google_apis_playstore;x86_64"
>sdkmanager "emulator"

Para ejectutar el emulador de sebe agregar el path:
>SETX emulator C:\android-sdk\emulator

Para crear un dispotivo se usa el siguiente comando:

>avdmanager create avd -n myDevice -k "system-images;android-29;google_apis_playstore;x86_64"

En caso de que se hayan creado muchos por error, se pueden borrar copiando la siguiente ruta en el explorador de archivos y elimando los dos archivos con el nombre del dispotivo.
>%USERPROFILE%/.android/avd

#### Licencias
Antes de usar el Android SDK se deben aceptar unas licencias, se deben ejecutar los siguientes comandos: 
>flutter doctor \--android-licenses
>sdkmanager \--licenses

#### Pasos finales
Para verificar que todo se haya instalado correctamente se ejecuta el siguiente comando:
>flutter doctor -v

Se abre VS Code y se descarga la [extensión ](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter "extensión ")para Flutter.  Se presiona **Ctrl + Shift + P ** y se escribe el siguiente comando:
> \>Flutter: Select Device
Start myDevice

Ya se puede ejecutar o debuggear la aplicación  para ver la vista previa en nuestro emulador.

## Recursos
- [Docmuentacion de Flutter](https://flutter.dev/docs). Tutoriales, ejemplos y la referencia a la API
- [Pub.dev](https://pub.dev "Pub.dev"). El repositorio oficial de paquetes para las aplicaciones Dart y Flutter.