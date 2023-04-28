import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {

  close() {
    const modal = document.querySelector('#product-modal')

    modal.remove()
  }
}
