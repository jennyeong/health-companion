import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="online"
export default class extends Controller {
  static targets = ["url", "loc", "boolean", "country"]

  connect() {
    // console.log(this.urlTarget)
    // console.log(this.locTarget)
    // console.log(this.booleanTarget.checked)
  }

  update() {
    if (this.booleanTarget.checked) {
      this.urlTarget.classList.remove('d-none');
      this.locTarget.classList.add('d-none');
      this.countryTarget.classList.add('d-none');
    } else {
      this.urlTarget.classList.add('d-none');
      this.locTarget.classList.remove('d-none');
      this.countryTarget.classList.remove('d-none');
    }
  }
}
