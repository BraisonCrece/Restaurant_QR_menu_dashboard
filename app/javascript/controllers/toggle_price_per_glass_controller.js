import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-price-per-glass"
export default class extends Controller {
    static targets = ["pricePerGlassField", "input"];

    toggle() {
        console.log("changing");
        this.pricePerGlassFieldTarget.classList.toggle('hidden')
    }

}
