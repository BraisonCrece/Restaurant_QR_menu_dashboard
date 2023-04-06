import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  connect() {
    console.log("hola");
  }

  close() {
    const modal = document.querySelector('#product-modal')

    modal.remove()
  }
}
