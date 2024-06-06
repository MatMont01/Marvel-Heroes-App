# Marvel Heroes App
 La Marvel Heroes App es una aplicación móvil en Flutter que permite a los usuarios explorar, crear y gestionar personajes y películas del universo Marvel. Utiliza una base de datos SQLite para almacenar la información de los héroes y las películas.
Descripción

    Exploración de Héroes: Busca y explora héroes por categorías.
    Detalle de Héroes: Ve la información completa de cada héroe, incluidas sus habilidades, descripción, y películas en las que aparece.
    Creación y Edición de Héroes: Crea y edita información de héroes, incluyendo nombre, alias, edad, peso, altura, tierra, categoría, habilidades, descripción, películas y URL de la imagen.
    Creación y Edición de Películas: Crea y edita películas, incluyendo título, URL de la imagen y personajes que aparecen en la película.
    Interfaz de Usuario Intuitiva: Diseño moderno y responsivo, compatible con diferentes tamaños de pantalla.
    Persistencia de Datos: Utiliza SQLite para almacenar y gestionar los datos de héroes y películas.

Tecnologías Utilizadas

    Flutter: Framework para el desarrollo de la interfaz de usuario.
    Dart: Lenguaje de programación utilizado en Flutter.
    SQLite: Base de datos local para almacenamiento persistente.
    sqflite: Paquete de Flutter para interactuar con SQLite.
    Provider: Paquete de Flutter para la gestión del estado.

Instalación

    Clonar el repositorio

    bash

git clone https://github.com/MatMont01/Marvel-Heroes-App.git

Instalar dependencias

bash

flutter pub get

Ejecutar la aplicación

bash

    flutter run

Estructura del Proyecto

    lib/
        components/: Contiene los widgets reutilizables como HeroCard y SearchBar.
        models/: Modelos de datos para héroes (HeroModel) y películas (MovieModel).
        pages/: Pantallas principales de la aplicación (HomePage, DetailPage, CreateHeroPage, EditHeroPage, CreateMoviePage, EditMoviePage).
        providers/: Proveedor de base de datos (DatabaseProvider) para interactuar con SQLite.
        theme.dart: Definiciones de estilos y temas para la aplicación.
        main.dart: Punto de entrada principal de la aplicación.
