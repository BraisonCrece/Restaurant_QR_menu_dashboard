import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="file-input"
export default class extends Controller {
  static targets = ["fileInput", "fileName", "imagePreview", "placeholderUrl"]

  //   resetImagePreview() {
  //     console.log("resetImagePreview")
  //     const placeholderUrl = this.placeholderUrlTarget.textContent.trim()
  //     console.log(this.imagePreviewTarget.src)
  //     this.imagePreviewTarget.src = placeholderUrl
  //   }

  updateFile() {
    const input = this.fileInputTarget
    const fileName =
      input.files.length > 0 ? input.files[0].name : "Seleccione un archivo"
    this.fileNameTarget.innerText = fileName
    this.fileNameTarget.classList.toggle(fileName === "Seleccione un archivo")

    if (input.files && input.files[0]) {
      const reader = new FileReader()
      reader.onload = e => {
        this.imagePreviewTarget.src = e.target.result
      }
      reader.readAsDataURL(input.files[0])
    }
  }

  changePicture() {
    this.fileInputTarget.click()
  }
}
