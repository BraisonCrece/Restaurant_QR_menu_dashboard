import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notifications"
export default class extends Controller {
  static targets = ["x"]
  close(e) {
    this.hideNotification()
  }

  connect() {
    this.element.classList.add("animate__animated", "animate__fadeInRight");
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
    }, 1000); // Duración de la animación
  }

}
