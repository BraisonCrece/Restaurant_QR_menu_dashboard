import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menu"
export default class extends Controller {
  static targets = ['items']
  toggle() {
    this.itemsTarget.classList.toggle('translate-x-full')
  }
}
