import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroll"
export default class extends Controller {
  scrollToCategory(event) {
    event.preventDefault();
    const targetId = event.currentTarget.getAttribute("href");
    const targetElement = document.querySelector(targetId);

    const scrollToTarget = () => {
      const headerOffset = 80; // Adjust this value according to the fixed header height
      const elementPosition = targetElement.offsetTop;
      const offsetPosition = elementPosition - headerOffset;

      window.scrollTo({
        top: offsetPosition,
        behavior: "smooth",
      });
    };

    scrollToTarget();
  }
}
