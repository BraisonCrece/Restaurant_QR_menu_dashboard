import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="theme-switcher"
export default class extends Controller {
  static targets = ["darkButton", "lightButton", "root"]

  connect() {
    this.updateThemeFromLocalStorage()

    document.addEventListener("turbo:load", () => {
      this.updateThemeFromLocalStorage()
    })
  }

  toggle() {
    // Alterna la clase "dark" en el elemento root
    document.documentElement.classList.toggle("dark")

    // Guarda el estado del tema en localStorage
    if (document.documentElement.classList.contains("dark")) {
      localStorage.setItem("theme", "dark")
      this.showLightButton()
    } else {
      localStorage.setItem("theme", "light")
      this.showDarkButton()
    }
  }

  updateThemeFromLocalStorage() {
    const theme = localStorage.getItem("theme")

    if (theme === "dark") {
      document.documentElement.classList.add("dark")
      this.showLightButton()
    } else {
      document.documentElement.classList.remove("dark")
      this.showDarkButton()
    }
  }

  showLightButton() {
    this.darkButtonTarget.classList.add("hidden")
    this.lightButtonTarget.classList.remove("hidden")
  }

  showDarkButton() {
    this.darkButtonTarget.classList.remove("hidden")
    this.lightButtonTarget.classList.add("hidden")
  }
}
