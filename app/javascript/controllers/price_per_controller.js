import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="price-per"
export default class extends Controller {
  static targets = ["pricePerKg", "pricePerGr"]
  connect() {
    console.log(
      "Connected to price-per controller",
      this.pricePerKgTarget,
      this.pricePerGrTarget
    )
  }

  toggle(event) {
    if (event.target === this.pricePerKgTarget) {
      this.pricePerGrTarget.checked = false
    } else {
      this.pricePerKgTarget.checked = false
    }
  }
}
