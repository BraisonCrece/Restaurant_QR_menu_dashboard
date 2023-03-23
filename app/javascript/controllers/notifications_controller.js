import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notifications"
export default class extends Controller {
  static targets = ["x"]
  close(e) {
    this.xTarget.hidden = true
  }
}
