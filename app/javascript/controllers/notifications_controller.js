import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notifications"
export default class extends Controller {
  static targets = ["x"]
  close(e) {
    this.hideNotification()
  }

  connect() {
    this.timeout = setTimeout(() => {
      this.hideNotification();
    }, 3000);
  }

  disconnect() {
    clearTimeout(this.timeout);
  }

  hideNotification() {
    this.element.classList.remove("animate__fadeInRight");
    this.element.classList.add("animate__fadeOutRight");

    setTimeout(() => {
      this.element.remove();
    }, 500);
  }

}
