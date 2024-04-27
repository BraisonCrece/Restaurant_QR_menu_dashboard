import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="product-form"
export default class extends Controller {
    static targets = ["specialMenuField", "categorySelect"]
    toggle() {
        if (this.specialMenuFieldTarget.classList.contains('hidden')) {
            this.specialMenuFieldTarget.classList.remove('hidden')
            this.categorySelectTarget.disabled = true
        } else {
            this.specialMenuFieldTarget.classList.add('hidden')
            this.categorySelectTarget.disabled = false
        }
    }
}
