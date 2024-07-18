const defaultTheme = require("tailwindcss/defaultTheme")

module.exports = {
  darkMode: "class",
  content: [
    "./public/*.html",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/views/**/*.{erb,haml,html,slim}"
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ["Inter var", ...defaultTheme.fontFamily.sans],
        play: ["PlayFair", ...defaultTheme.fontFamily.sans],
        roboto: ["Roboto", ...defaultTheme.fontFamily.sans]
      },
      fontSize: {
        xxs: "0.4rem"
      },
      animation: {
        "pulse-subtle": "pulse-subtle 6.5s infinite"
      }
    }
  },
  plugins: [
    require("@tailwindcss/forms"),
    require("@tailwindcss/aspect-ratio"),
    require("@tailwindcss/typography"),
    require("@tailwindcss/container-queries")
  ]
}
