# SerManos - Aplicación de Flutter

## 73.21 - Desarrollo de Aplicaciones Móviles Multiplataforma - Trabajo práctico

### Instituto Tecnológico de Buenos Aires

<br/>

## Contenido
1. [Descripción](#descripción)
2. [Especificaciones técnicas](#especificaciones-técnicas)
    1. [Frontend](#frontend)
    2. [Backend](#backend)
    3. [Design System](#design-system)
    4. [State Management](#state-management)
    5. [Deep Links](#deep-links)
    6. [Testing](#testing)
3. [Requerimientos no funcionales](#requerimientos-no-funcionales)
    1. [Monitoreo y eventos](#monitoreo-y-eventos)
    2. [Seguridad](#seguridad)
    3. [Privacidad](#privacidad)
    4. [Usabilidad](#usabilidad)
4. [Autores](#autores)

<br/>

## Descripción
Este repositorio contiene el código fuente de la aplicación de flutter desarrollada para el trabajo práctico de la materia 73.21 - Desarrollo de Aplicaciones Móviles Multiplataforma del ITBA, que consiste en una aplicación desarrollada en Flutter para que personas puedan, principalmente, averiguar sobre voluntariados cercanos e inscribirse a ellos.

En nuestro caso se desarrolló la funcionalidad extra de refresh de voluntariados, un voluntariado en particular y noticias.

<br/>

## Especificaciones técnicas

### Frontend
Se utilizó Flutter 3 para el desarrollo de la aplicación.

### Backend
Se utilizó Firebase para el desarrollo del backend, ya que resultó cómodo al ya existir una integración muy completa con Flutter, poseer una curva de aprendizaje muy baja y ofrecer un plan gratuito que cubría todos los servicios que se necesitaban para la aplicación.

### Design System
Se utilizó el design system expuesto en el Figma provisto por la cátedra. Para su implementación se siguieron las recomendaciones sugeridas en [este post de Medium](https://medium.com/bancolombia-tech/building-a-design-system-using-atomic-design-methodology-in-flutter-327142bf30c2), obteniendo un resultado muy satisfactorio y desacoplado de la lógica de la aplicación.

### State Management
Se utilizó [Provider](https://pub.dev/packages/provider) para el manejo de estado de la aplicación, dado que cubría todas las necesidades de la aplicación y resultó muy cómodo y fácil de utilizar con prácticamente cero fricción.

Desde el punto de vista de la arquitectura, se utilizó un patrón de arquitectura de tres capas, donde la capa de presentación se comunica con la capa de negocio mediante los providers, y esta última se comunica con la capa de datos a través de la API. De esta forma, se logra un desacoplamiento entre las capas de la aplicación, lo cual permite que cada una pueda ser modificada sin afectar a las otras, y permitió un manejo de errores muy sencillo.

### Deep Links
Se utilizó [GoRouter](https://pub.dev/packages/go_router) para el manejo de rutas y deep links de la aplicación, debido a que era muy sencillo de usar y cubría todas las necesidades de la aplicación.

#### Rutas
Sin autenticación:
- `/`: Ruta principal de la aplicación, redirecciona a `/onboarding` por default.
- `/onboarding`: Muestra una pantalla para iniciar sesión o registrarse en la aplicación.
- `/onboarding/signup`: Pantalla de registro de usuario.
- `/onboarding/signin`: Pantalla de inicio de sesión.

Con autenticación:
- `/welcome`: Pantalla de bienvenida, que se muestra luego de iniciar sesión o registrarse.
- `/volunteering`: Pantalla principal de la aplicación, que muestra los voluntariados cercanos, ordenados por cercanía o sino cronológicamente.
- `/volunteering/:id`: Muestra la información de un voluntariado en particular.
- `/profile`: Muestra la información del usuario.
- `/profile/edit`: Permite editar la información del usuario.
- `/news`: Muestra las noticias de la aplicación, ordenadas cronológicamente.
- `/news/:id`: Muestra la información de una noticia en particular.

Además, se cuenta con una página de error para cuando se ingresa una ruta inválida, y la misma ofrece la posibilidad de volver al inicio (si el usuario está autenticado) o de iniciar sesión (si el usuario no está autenticado).

Por último, se cuenta con un middleware que se encarga de cargar al usuario (si es que posee un token válido) antes de mostrar la pantalla correspondiente y redirigir a donde corresponda de acuerdo a los casos de uso.

### Testing
Para la ejecución de los tests es suficiente con, desde el directorio origen del repositorio, ejecutar `flutter test`.

Se ejecutaran golden tests para asegurar que nada haya cambiado en la UI respecto del punto de origen que fue establecido, en caso de querer recrear el punto de origen debe ejecutarse `flutter test --update-goldens`. Y también se ejecutaran tests sobre distintos widgets, particularmente aquellos que tienen interacciones como la aparición de modals. 


<br/>

## Requerimientos no funcionales

### Monitoreo y eventos
Lorem ipsum

### Seguridad
Lorem ipsum

### Privacidad
Lorem ipsum

### Usabilidad
Adicionalmente a lo expuesto en Figma, añadimos:
- Pantalla de error para cuando se ingresa una ruta inválida o no se encuentra un voluntariado o noticia en particular.
- Snackbar para mostrar mensajes de error. Para el caso de errores en formularios los mismos se muestran por pantalla y aquellos ajenos a los formularios se muestran en una snackbar.

<br/>

## Autores

- [Serpe, Octavio Javier](https://github.com/OctavioSerpe) - Legajo 60076
- [Rodríguez, Manuel Joaquín](https://github.com/rodriguezmanueljoaquin) - Legajo 60258
- [Arca, Gonzalo](https://github.com/gonzaloarca) - Legajo 60303