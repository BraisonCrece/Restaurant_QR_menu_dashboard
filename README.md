# QR Menu Card for Restaurants 
(Under development 🔨)
(designed to be better used on mobiles 📱)


https://github.com/user-attachments/assets/4b511c73-fc80-4223-9a30-f3cf4abb7efb



https://cartanavegacion.fly.dev/

This application allows restaurants to create and manage their menu of food and drinks in QR format. Customers can scan the QR code with their mobile phones to quickly and easily access the restaurant's menu.

The main objectives are:
- To provide maximum **ease** in menu management
- **Mobile & desktop** design
- **Immediate** menu updates

## Technologies used

- Ruby on Rails 7
- Tailwind CSS
- ImportMaps
- MySQL
- StimulusJS

## Main features

- Mobile first 📲
- Auto translation in the background each time a new product / wine is created / updated. (`OpenAI` 🔮 + `i18n`) `[ES, IT, FR, EN, RU, IT]`
- Auto generative descriptions based on the name of the product (AI 🔮)
- Activate / Deactivate / Modify / Delete products on the fly, the user wont have to refresh the page to see the updates (`WebSocket`)
- User authentication: Allowing restaurant owners to access their account and manage the data on the fly using a smartphone / tablet / desktop.
- Automatic image processing and compression to improve the performance while reducing the storage cost. (`libvips`)
- Theme switcher (`Dark` 🌙 / `Light` 🌞)
- Menu creation and editing: restaurants can create and edit their menu of food and drinks in the application.
    - Allergens
    - Wines
    - Starters
    - Main courses
    - Desserts
    - Special menus


## Installation and configuration

1. Clone the GitHub repository: `git clone https://github.com/BraisonCrece/Restaurant_QR_menu_dashboard`
2. Install dependencies: `bundle install`
3. Configure the database: `rails db:create && rails db:migrate`
4. Start the web server: `bin/dev`

## Contributions

If you want to contribute to the application, please follow these steps:

1. Fork the repository.
2. Create a new branch: `git checkout -b my-new-feature`
3. Make your changes and commit: `git commit -am 'Add some feature'`
4. Push your changes to the branch: `git push origin my-new-feature`
5. Create a pull request.

## License

This application is under the MIT license. See the LICENSE file for more details.
