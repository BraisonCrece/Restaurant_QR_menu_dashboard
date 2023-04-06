import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="description"
export default class extends Controller {
  static targets = ['input', 'output', 'spinner', 'buttonText']

  async describeDish(e) {
    e.preventDefault()
    const plato = this.inputTarget.value;
    const requestOptions = this.buildRequestOptions(plato);

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

  async describeWine(e) {
    e.preventDefault()
    const wine = this.inputTarget.value;
    const requestOptions = this.buildWineRequestOptions(wine);

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

  buildWineRequestOptions(plato) {
    const headers = new Headers({
      'Content-Type': 'application/json',
      'X-CSRF-Token': this.getCSRFToken()
    });

    return {
      method: 'POST',
      headers: headers,
      body: JSON.stringify({ plato: plato, description_type: "vino" })
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
