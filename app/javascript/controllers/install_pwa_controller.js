import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="install-pwa"
export default class extends Controller {
  static targets = ["installButton"];

  connect() {
    // this.deferredPrompt = null
    // window.addEventListener("beforeinstallprompt", this.handleBeforeInstallPrompt);

    // this.installButtonTarget.addEventListener("click", () => this.install());

    // this.setupMediaQueryListener();
  }

  disconnect() {
    // window.removeEventListener("beforeinstallprompt", this.handleBeforeInstallPrompt);

    // this.installButtonTarget.removeEventListener("click", () => this.install());
  }

  handleBeforeInstallPrompt(event) {
    // event.preventDefault();
    // this.deferredPrompt = event;
    // this.installButtonTarget.style.display = "block";
  }

  install(event) {
    // if (this.deferredPrompt) {
    //   this.deferredPrompt.prompt();
    //   this.deferredPrompt.userChoice.then((choiceResult) => {
    //     if (choiceResult.outcome === "accepted") {
    //       console.log("El usuario aceptó instalar la app");
    //     } else {
    //       console.log("El usuario no aceptó instalar la app");
    //     }
    //     this.deferredPrompt = null;
    //     this.installButtonTarget.style.display = "none";
    //   });
    // }
  }

  setupMediaQueryListener() {
    // const mediaQuery = window.matchMedia("(display-mode: standalone)");
    // this.handleMediaQueryChange(mediaQuery);

    // mediaQuery.addEventListener('change', this.handleMediaQueryChange.bind(this));
  }

  handleMediaQueryChange(mediaQuery) {
    // if (mediaQuery.matches) {
    //   this.installButtonTarget.style.display = "none";
    // } else {
    //   this.installButtonTarget.style.display = this.deferredPrompt ? "block" : "none";
    // }
  }
}
