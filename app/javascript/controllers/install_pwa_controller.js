import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="install-pwa"
export default class extends Controller {
  connect() {
    this.deferredPrompt = null;
    this.handleBeforeInstallPrompt = this.handleBeforeInstallPrompt.bind(this);
    window.addEventListener("beforeinstallprompt", this.handleBeforeInstallPrompt);
  }

  disconnect() {
    window.removeEventListener("beforeinstallprompt", this.handleBeforeInstallPrompt);
  }

  handleBeforeInstallPrompt(event) {
    event.preventDefault();
    this.deferredPrompt = event;
    this.element.style.display = "block";
  }

  install(event) {
    if (this.deferredPrompt) {
      this.deferredPrompt.prompt();
      this.deferredPrompt.userChoice.then((choiceResult) => {
        if (choiceResult.outcome === "accepted") {
          console.log("El usuario aceptó instalar la app");
        } else {
          console.log("El usuario no aceptó instalar la app");
        }
        this.deferredPrompt = null;
      });
    }
  }
}
