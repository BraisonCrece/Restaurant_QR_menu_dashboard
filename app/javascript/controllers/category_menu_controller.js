import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="category-menu"
export default class extends Controller {
  static targets = ["menu"];
  initialOffsetTop = 0;

  connect() {
    this.initialOffsetTop = this.menuTarget.offsetTop;
    window.addEventListener("scroll", this.handleScroll.bind(this));
  }

  disconnect() {
    window.removeEventListener("scroll", this.handleScroll.bind(this));
  }

  handleScroll() {
    const shouldAddShadow = window.pageYOffset > this.initialOffsetTop;
    if (shouldAddShadow) {
      this.menuTarget.classList.add("shadow-lg");
    } else {
      this.menuTarget.classList.remove("shadow-lg");
    }
  }
}
