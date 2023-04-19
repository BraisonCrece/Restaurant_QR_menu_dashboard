import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="image-loader"
export default class extends Controller {
  static targets = ["image", "loader"];

  connect() {
    this.imageTarget.style.display = "none";
    this.loaderTarget.style.display = "block";
    this.loadImage();
  }

  loadImage() {
    const image = new Image();
    image.src = this.imageTarget.dataset.src;
    image.onload = () => {
      this.loaderTarget.style.display = "none";
      this.imageTarget.src = image.src;
      this.imageTarget.style.display = "block";
    };
  }
}
