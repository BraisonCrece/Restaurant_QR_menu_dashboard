import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="translate"
export default class extends Controller {
  static targets = ['input', 'output']

  async translateInput(e) {
    e.preventDefault()

    const text = this.inputTarget.value;
    const targetLang = 'EN';

    let translated = await this.translateText(text, targetLang);
    this.outputTarget.value = translated
  }

  async translateText(text, targetLang) {
    const url = '/translate';
    const requestOptions = this.buildRequestOptions(text, targetLang);

    try {
      const response = await fetch(url, requestOptions);
      if (!response.ok) {
        throw new Error(`HTTP error! Status: ${response.status}`);
      }
      const result = await response.json();
      // console.log(JSON.stringify(result));
      const translatedText = result.translation;
      return translatedText;
    } catch (error) {
      console.error('Error fetching translation:', error);
    }
  }

  buildRequestOptions(text, targetLang) {
    const headers = new Headers({
      'Content-Type': 'application/x-www-form-urlencoded'
    });

    const csrfToken = this.getCSRFToken();
    const data = new URLSearchParams();
    data.append('text', text);
    data.append('target_lang', targetLang);
    data.append('authenticity_token', csrfToken);

    return {
      method: 'POST',
      headers: headers,
      body: data
    };
  }

  getCSRFToken() {
    return document.querySelector('meta[name="csrf-token"]').content;
  }
}

