import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tooltip"
export default class extends Controller {
  static targets = ["text"];

  static currentTooltip = null;

  toggle(event) {
    if (this.constructor.currentTooltip === this.textTarget) {
      this.constructor.currentTooltip.classList.remove("visible");
      this.constructor.currentTooltip = null;
    } else {
      this.hideCurrentTooltip();
      this.toggleTooltip(event);
    }
  }

  hideCurrentTooltip() {
    if (this.constructor.currentTooltip && this.constructor.currentTooltip !== this.textTarget) {
      this.constructor.currentTooltip.classList.remove("visible");
      this.constructor.currentTooltip = null;
    }
  }

  toggleTooltip(event) {
    if (this.constructor.currentTooltip !== this.textTarget) {
      this.adjustHorizontalPosition(event);
      this.adjustVerticalPosition(event);

      this.textTarget.classList.toggle("visible");
      this.constructor.currentTooltip = this.textTarget;
    }
  }

  adjustHorizontalPosition(event) {
    const rect = event.currentTarget.getBoundingClientRect();
    const tooltipWidth = this.textTarget.offsetWidth;
    const screenWidth = window.innerWidth;

    if (rect.left + tooltipWidth / 2 > screenWidth / 2) {
      this.textTarget.style.left = 'auto';
      this.textTarget.style.right = '0';
    } else {
      this.textTarget.style.left = '50%';
      this.textTarget.style.right = 'auto';
    }
  }

  adjustVerticalPosition(event) {
    const rect = event.currentTarget.getBoundingClientRect();
    const tooltipHeight = this.textTarget.offsetHeight;

    if (rect.top < tooltipHeight + rect.height) {
      this.textTarget.style.top = '100%';
      this.textTarget.style.bottom = 'auto';
    } else {
      this.textTarget.style.top = 'auto';
      this.textTarget.style.bottom = '100%';
    }
  }
}
