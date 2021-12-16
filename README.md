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

## ScreenShots
 <img width="374" alt="Screen Shot 2021-12-15 at 10 37 36 PM" src="https://user-images.githubusercontent.com/67339434/146303867-ab0e65b4-f546-42a6-b62c-c8f5e2478544.png">
 <img width="371" alt="Screen Shot 2021-12-15 at 10 37 59 PM" src="https://user-images.githubusercontent.com/67339434/146303932-0fba751e-d090-4612-85fe-2ecccbbf725e.png">
 <img width="369" alt="Screen Shot 2021-12-15 at 10 38 17 PM" src="https://user-images.githubusercontent.com/67339434/146303966-812764ed-d405-404a-b976-c43e27ca7782.png">
 <img width="368" alt="Screen Shot 2021-12-15 at 10 39 50 PM" src="https://user-images.githubusercontent.com/67339434/146304130-8669ddf2-0adb-443c-92d4-d66e77a947a5.png">
 <img width="359" alt="Screen Shot 2021-12-15 at 10 40 20 PM" src="https://user-images.githubusercontent.com/67339434/146304184-d1bf4906-4a4b-44a6-91f0-dd6ca67785cf.png">
<img width="370" alt="Screen Shot 2021-12-15 at 10 42 04 PM" src="https://user-images.githubusercontent.com/67339434/146304342-47252af8-435a-4951-992e-ab71be11729c.png">

<img width="348" alt="Screen Shot 2021-12-15 at 10 43 56 PM" src="https://user-images.githubusercontent.com/67339434/146304507-260a404a-36af-409b-815c-478455379d05.png">
