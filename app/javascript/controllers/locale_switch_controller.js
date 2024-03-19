import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="locale-switch"
export default class extends Controller {
    connect() {
        const locales = document.querySelector(".other-locales")
        if (!locales.classList.contains("hidden")) {
            locales.classList.add("hidden")
        }
    }

    toggle(event) {
        event.preventDefault()
        const locales = document.querySelector(".other-locales")
        if (locales.classList.contains("hidden")) {
            locales.classList.remove("hidden")
            setTimeout(() => locales.classList.add("active"), 10)
        } else {
            locales.classList.remove("active");
            setTimeout(() => locales.classList.add("hidden"), 500);
        }
    }
}
