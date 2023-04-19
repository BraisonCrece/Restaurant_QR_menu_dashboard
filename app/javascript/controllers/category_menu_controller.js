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
    const shouldAddShadow = window.pageYOffset >= this.initialOffsetTop;
    const isInOriginalPosition = this.menuTarget.getBoundingClientRect().top === 0;

    // console.log(this.menuTarget.getBoundingClientRect().top);

    this.menuTarget.classList.toggle("shadow-lg", shouldAddShadow && isInOriginalPosition);
    this.menuTarget.classList.toggle("bg-white", shouldAddShadow && isInOriginalPosition);
  }
}

