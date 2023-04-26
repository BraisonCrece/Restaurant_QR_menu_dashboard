import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="orientation"
export default class extends Controller {
  static targets = ["content"];

  connect() {
    window.addEventListener("orientationchange", this.lockOrientation);
    this.lockOrientation();
  }

  disconnect() {
    window.removeEventListener("orientationchange", this.lockOrientation);
  }

  lockOrientation = () => {
    if (window.screen && window.screen.orientation) {
      window.screen.orientation.lock("portrait");
    }
  };
}
