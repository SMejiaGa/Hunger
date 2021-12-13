# Hunger


- [Hunger](#hunger)
- [Arquitectura](#arquitectura)
- [Desarrollo](#desarrollo)

## Hunger?
-Hungry es una aplicacion para iOS que estoy desarrollando para aplicar mis conocimientos en el sector, Hungry es una app que permite a un usuario localizar restaurantes cerca a -su ubicacion, consultarlos y ver en que lugar se encuentran.

-Se usan autenticaciones, al crear usuarios que pueden ingresar y registrarse a la aplicacion, asi como enviar un correo de recuperación para sus contraseñas.

-Se usan llamados a endpoints para obtener las listas de los restaurantes y obtener la informacion de cada uno de estos.

-Se usa AppleMaps con un llamado a endpoint para conseguir las ubicaciones y ubicar pines en este.

## Arquitectura

Hunger esta usando el patrón MVP
- reducir acomplamiento entre las clases
- Mantener el espacio de trabajo ordenado en cuanto a responsabilidades respecta

## Desarrollo

**No utilizo StoryBoards**
- Se libera la responsabilidad de soportar segues
- Se resuelven los entry points faltantes
- Se reduce la posibilidad de encontrar conflictos durante un merge
- Al separar las vistas en XIBs individuales, los tiempos de carga se vuelven mas optimos.

**Estructura del proyecto**
Todos los modulos se dividen de la siguiente manera:

- Hunger
- - **Modules**
- - - **Register**
- - - - **RegisterPresenter**
- - - - **RegisterViewController**
- - - - **RegisterViewController.XIB**
- - **NetWorking**
- - - **WebRouter**
- - - - **Register Service**
- - - **Models**
- - - - **UserResponse**
