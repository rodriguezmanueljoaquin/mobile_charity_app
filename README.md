# SerManos - Aplicación de Flutter

## 73.21 - Desarrollo de Aplicaciones Móviles Multiplataforma - Trabajo práctico

### Instituto Tecnológico de Buenos Aires

<br/>

## Contenido
- [SerManos - Aplicación de Flutter](#sermanos---aplicación-de-flutter)
  - [73.21 - Desarrollo de Aplicaciones Móviles Multiplataforma - Trabajo práctico](#7321---desarrollo-de-aplicaciones-móviles-multiplataforma---trabajo-práctico)
    - [Instituto Tecnológico de Buenos Aires](#instituto-tecnológico-de-buenos-aires)
  - [Contenido](#contenido)
  - [Descripción](#descripción)
  - [Especificaciones técnicas](#especificaciones-técnicas)
    - [Frontend](#frontend)
    - [Backend](#backend)
    - [Design System](#design-system)
    - [State Management](#state-management)
    - [Deep Links](#deep-links)
      - [Rutas](#rutas)
    - [Testing](#testing)
  - [Requerimientos no funcionales](#requerimientos-no-funcionales)
    - [Monitoreo y eventos](#monitoreo-y-eventos)
    - [Seguridad](#seguridad)
    - [Privacidad](#privacidad)
    - [Usabilidad](#usabilidad)
  - [Autores](#autores)

<br/>

## Descripción
Este repositorio contiene el código fuente de la aplicación de flutter desarrollada para el trabajo práctico de la materia 73.21 - Desarrollo de Aplicaciones Móviles Multiplataforma del ITBA, que consiste en una aplicación desarrollada en Flutter para que personas puedan, principalmente, averiguar sobre voluntariados cercanos e inscribirse a ellos.

En nuestro caso se desarrolló la funcionalidad extra de pull to refresh de voluntariados, un voluntariado en particular y noticias.

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

Existen 4 tipos de tests:
+ Golden tests
  
    Son para asegurar que nada haya cambiado en la UI respecto del punto de origen que fue establecido, Se ejecutan sobre todas las pantallas de forma individual para en caso de falla detectar rapidamente en cual sucedio, asi como tambien en varios tamaños de pantalla (celular promedio y iphone11, y tablets vertical y horizontal). En caso de querer recrear el punto de origen debe ejecutarse `flutter test --update-goldens`.

+ Unit tests

    Son para asegurar que las funciones de los servicios a través de los cuales se obtienen datos para poblar la aplicación funcionan de forma correcta.

+ Validator tests
  
  Aseguran que los validadores de los formularios funcionan de la forma esperada, tanto en los casos de éxito como en los de error.
  
+ Widget tests
  
    Tests sobre distintos widgets, particularmente aquellos que tienen interacciones como la aparición de modals, para asegurar su correcto funcionamiento. 


<br/>

## Requerimientos no funcionales

### Monitoreo y eventos
Para monitoreo se utilizó Crashlytics, que viene integrado con Firebase, y permite monitorear excepciones y crashes de la aplicación. Además, se utilizó Firebase Analytics para monitorear eventos de la aplicación. Los eventos que se emiten desde la aplicación son:

- `login`: Se emite cuando el usuario inicia sesión. 
  - Parámetro: `method`: `email` o `cache`, dependiendo de si se logueó con email o con cache
  - Resulta útil para tener una idea de número de usuarios activos.
- `signup`: Se emite cuando el usuario se registra.
  - Parámetro: `method`: `email` (único método de registro disponible)
  - Necesario para llevar rastro de nuevos usuarios en la plataforma.
- `edit_profile`:
  - Considerando que sólo los usuarios con perfiles completos pueden aplicar a voluntariados, es crítico para tener una idea de cuántos usuarios están en condiciones de aplicar a voluntariados. 
- `search_volunteerings`: 
  - Parámetros: 
    - `query`: query de búsqueda
  - Sirve para tener una idea de qué tipo de voluntariados están buscando los usuarios.
- `apply_to_volunteering`:
  - Parámetros: 
    - `volunteering_id`: id del voluntariado
  - Puede ayudar a dar una idea de qué tipo de voluntariados son los más populares. 
  
- `abandon_volunteering`:
  - Parámetro: `volunteering_id`: id del voluntariado
  - Ayuda a rastrear falta de interés o mala reputación de un voluntariado.

- `select_content`:
  - Parámetros: 
    - `content_type`: `volunteering` o `news`,
    -  `id`: id del voluntariado o noticia
  - Ayuda a encontrar las noticias más destacadas y los voluntariados más populares.
  
- `unauthorized_access`:
  - Parámetros: 
    - `screen_name`: vista a la que se intentó acceder sin estar autenticado
  - Provee información sobre qué vistas son las más visitadas por usuarios no autenticados, lo cual puede ayudar a decidir cambiar reglas de negocio a futuro (como permitir el acceso a usuarios no autenticados a ciertas pantallas, etc.). También sirve para aproximar la cantidad de usuarios potenciales sin cuenta en la plataforma.
  
- `location_permission_denied`:
  - Métrica relevante para saber cuántos usuarios no pueden acceder a la funcionalidad de búsqueda de voluntariados cercanos. 

- `location_permission_granted`:
  - Lo opuesto a la métrica anterior, sirve para saber cuántos usuarios pueden acceder a la funcionalidad de búsqueda de voluntariados cercanos, y entonces rastrear comportamientos distintos entre usuarios que pueden y no pueden acceder a la funcionalidad.
  
- `favorite_volunteering`:
  - Parámetros: 
    - `volunteering_id`: id del voluntariado
    - `is_favorite`: `true` o `false`
  - Dato valioso para saber qué voluntariados son los más populares.
  
- `share`:
  - Parámetros: 
    - `content_type`: `news`,
    -  `item_id`: id de la novedad
    -  `method`: `share` (hardcodeado)
   -  Otorga información sobre la popularidad de las novedades.

Vale la pena mencionar que ningún evento de FirebaseAnalytics se emite en caso de que el usuario no dé consentimiento para compartir datos de uso de la aplicación. (Exclusivo en iOS con AppTrackingTransparency)

### Seguridad
La comunicación con el backend es vía HTTPS, por lo que la información viaja encriptada.

Adicionalmente, se utilizó [FlutterDotenv](https://pub.dev/packages/flutter_dotenv) para manejar las variables de entorno conteniendo las credenciales, de forma que las mismas no se encuentren hardcodeadas en el código fuente de la aplicación, e ignorando el archivo `.env` en el `.gitignore` para que no se suba al repositorio.

Finalmente, se ignoraron los siguientes archivos dado que contenían información sensible:
- `android/app/google-services.json`
- `ios/firebase_app_id_file.json`
- `ios/Runner/GoogleService-Info.plist`
- `macos/firebase_app_id_file.json`
- `macos/Runner/GoogleService-Info.plist`

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