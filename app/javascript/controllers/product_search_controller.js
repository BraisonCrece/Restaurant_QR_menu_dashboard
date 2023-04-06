import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="product-search"
export default class extends Controller {
  static targets = ["search", "item"];

  search() {
    const searchTerm = this.searchTarget.value.toLowerCase();

    this.itemTargets.forEach((item) => {
      const productTitle = item.dataset.productTitle;

      if (productTitle.includes(searchTerm)) {
        item.style.display = "flex";
      } else {
        item.style.display = "none";
      }
    });
  }
}
