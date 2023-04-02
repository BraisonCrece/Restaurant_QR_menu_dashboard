import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroll-position"
export default class extends Controller {
  static targets = ["scrollArea"]

  connect() {
    this.restoreScrollPosition()
  }

  disconnect() {
    this.saveScrollPosition()
  }

  saveScrollPosition() {
    sessionStorage.setItem("scrollPosition", this.scrollAreaTarget.scrollTop)
  }

  restoreScrollPosition() {
    const savedScrollPosition = sessionStorage.getItem("scrollPosition")
    if (savedScrollPosition) {
      this.scrollAreaTarget.scrollTop = parseInt(savedScrollPosition)
    }
  }
}
