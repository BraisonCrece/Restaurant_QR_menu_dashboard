import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="category-menu"
export default class extends Controller {
  static targets = ["menu", "menu-invisible"];
  initialOffsetTop = 0;

  connect() {
    this.initialOffsetTop = this.menuTarget.offsetTop;
    window.addEventListener("scroll", this.handleScroll.bind(this));
    const menuLinks = document.getElementById("menu-links");
    const wrapper = document.getElementById("category-menu-wrapper");

    wrapper.style.height = `${menuLinks.offsetHeight}px`;
  }

  disconnect() {
    window.removeEventListener("scroll", this.handleScroll.bind(this));
  }

  handleScroll() {
    const shouldAddShadow = window.pageYOffset >= this.initialOffsetTop;
    const isInOriginalPosition = this.menuTarget.getBoundingClientRect().top === 0;

    this.menuTarget.classList.toggle("fixed-menu", shouldAddShadow);
  }
}

