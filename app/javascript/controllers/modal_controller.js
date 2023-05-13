import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {

    connect() {
        const body = document.querySelector('body')

        body.classList.add("overflow-hidden")
    }
    close(event) {
        const modal = document.querySelector('#product-modal')

        if (event.target === this.element) {
          modal.remove()
          this.element.remove()
        }
    }

    disconnect() {
        const body = document.querySelector('body')

        body.classList.remove("overflow-hidden")
    }
}
