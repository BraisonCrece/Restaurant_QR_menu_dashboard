import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="description"
export default class extends Controller {
  static targets = ['input', 'output', 'spinner', 'buttonText']

  async describeDish(e) {
    e.preventDefault()
    const plato = this.inputTarget.value;
    const requestOptions = this.buildRequestOptions(plato);

    console.log(plato);
    console.log(requestOptions);

    this.showSpinner()
    try {
      const response = await fetch('/describe_dish', requestOptions);
      if (!response.ok) {
        throw new Error(`HTTP error! Status: ${response.status}`);
      }
      const result = await response.json();
      console.log(result);
      const description = result.description;
      this.outputTarget.value = description;
    } catch (error) {
      console.error('Error fetching description:', error);
    } finally {
      this.hideSpinner()
    }
  }

  buildRequestOptions(plato) {
    const headers = new Headers({
      'Content-Type': 'application/json',
      'X-CSRF-Token': this.getCSRFToken()
    });

    return {
      method: 'POST',
      headers: headers,
      body: JSON.stringify({ plato: plato })
    };
  }

  getCSRFToken() {
    return document.querySelector('meta[name="csrf-token"]').content;
  }

  showSpinner() {
    this.spinnerTarget.classList.remove('hidden');
    this.buttonTextTarget.classList.add('hidden');
  }

  hideSpinner() {
    this.spinnerTarget.classList.add('hidden');
    this.buttonTextTarget.classList.remove('hidden');
  }

}

     // <button data-action='click->description#describeDish' class="w-full bg-pink-500 hover:bg-pink-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline-blue focus:ring ring-blue-300 focus:border-blue-300 active:bg-blue-800">
        {/* <span>Xerar descripción</span> */}
      {/* </button> */}
