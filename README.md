# Hunger

- [Arquitectura](#arquitectura)
- [Desarrollo](#Desarrollo)

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
- - - **Responsabilidad**
- - - - **Presenter**
- - - - **ViewController**
- - - - **.XIB**
- - **NetWorking**
- - - **WebRouter**
- - - - **/Responsability/ Service**
- - - **Models**
- - - - **Webservice model**
