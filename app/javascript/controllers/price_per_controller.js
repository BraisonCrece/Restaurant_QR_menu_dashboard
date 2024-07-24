import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="price-per"
export default class extends Controller {
  static targets = ["pricePerKg", "pricePerGr", "pricePerUnit"]

  toggle(event) {
    switch (event.target) {
      case this.pricePerKgTarget:
        this.pricePerGrTarget.checked = false
        this.pricePerUnitTarget.checked = false
        break
      case this.pricePerGrTarget:
        this.pricePerKgTarget.checked = false
        this.pricePerUnitTarget.checked = false
        break
      case this.pricePerUnitTarget:
        this.pricePerKgTarget.checked = false
        this.pricePerGrTarget.checked = false
        break
    }
  }
}
