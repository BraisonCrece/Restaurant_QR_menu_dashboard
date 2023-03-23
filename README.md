# Carta QR para Restaurantes 
(En desarrollo 🔨)

Esta aplicación permite a los restaurantes crear y gestionar su carta de comidas y bebidas en formato QR. Los clientes pueden escanear el código QR con sus teléfonos móviles para acceder a la carta del restaurante de forma rápida y sencilla.

Los principales objetivos son:
- Brindar la máxima **facilidad** en la gestión de la carta
- **Mobile & desktop** design
- **Inmediated** en la actualización de la carta

## Tecnologías utilizadas

- Ruby on Rails 7
- Tailwind CSS
- ImportMaps
- MySQL
- StimulusJS

## Funcionalidades principales

- Creación y edición de la carta: los restaurantes pueden crear y editar su carta de comidas y bebidas en la aplicación.
    - Alérgenos (Asociables a los productos)
    - Vinos
    - Entrantes
    - Platos
    - Postres
- Escaneo de código QR: los clientes pueden escanear el código QR con sus teléfonos móviles para acceder a la carta del restaurante.
- Autenticación de usuarios: la aplicación utiliza Devise para gestionar la autenticación y autorización de usuarios, permitiendo a los restaurantes acceder a su cuenta y a los clientes acceder a la carta del restaurante.


## Instalación y configuración

1. Clona el repositorio de GitHub: `git clone https://github.com/BraisonCrece/Restaurant_QR_menu_dashboard`
2. Instala las dependencias: `bundle install`
3. Configura la base de datos: `rails db:create && rails db:migrate`
4. Inicia el servidor web: `bin/dev`

## Contribuciones

Si deseas contribuir a la aplicación, por favor sigue estos pasos:

1. Haz un fork del repositorio.
2. Crea una nueva rama: `git checkout -b my-new-feature`
3. Realiza tus cambios y haz commit: `git commit -am 'Add some feature'`
4. Sube tus cambios a la rama: `git push origin my-new-feature`
5. Crea un pull request.

## Licencia

Esta aplicación está bajo la licencia MIT. Consulta el archivo LICENSE para más detalles.
