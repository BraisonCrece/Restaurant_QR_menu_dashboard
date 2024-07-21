import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menu-toggler"
export default class extends Controller {
  static targets = ["menu", "carta", "toggler"]
  static values = {
    url: String
  }

  toggle(e) {
    e.preventDefault()
    this.urlValue == "menu" ? (this.urlValue = "/") : (this.urlValue = "menu")
    this.togglerTarget.href = this.urlValue
    this.urlValue = "/"
    this.menuTarget.classList.toggle("hidden")
    this.cartaTarget.classList.toggle("hidden")
    // now continue the execution of the event
    e.continuePropagation()
  }
}
