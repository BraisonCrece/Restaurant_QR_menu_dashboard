import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
    close(event) {
        const modal = document.querySelector('#product-modal')

        if (event.target === this.element) {
          modal.remove()
          this.element.remove()
        }
    }
}
