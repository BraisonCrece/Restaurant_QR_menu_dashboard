import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="file-input"
export default class extends Controller {
  static targets = ["fileInput", "fileName"];

  updateFileName() {
    const input = this.fileInputTarget;
    const fileName = input.files.length > 0 ? input.files[0].name : "Seleccione un archivo";
    this.fileNameTarget.innerText = fileName;
    this.fileNameTarget.classList.toggle("text-gray-400", fileName === "Seleccione un archivo");
  }
}
