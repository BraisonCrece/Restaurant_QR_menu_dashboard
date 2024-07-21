import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sticky-shadow"
export default class extends Controller {
  static targets = ["sticky"]

  connect() {
    const stickyElement = this.stickyTarget

    const observer = new IntersectionObserver(
      ([entry]) => {
        if (entry.intersectionRatio < 1) {
          stickyElement.classList.add("shadow-md")
        } else {
          stickyElement.classList.remove("shadow-md")
        }
      },
      { threshold: [1] }
    )

    observer.observe(stickyElement)
  }
}
