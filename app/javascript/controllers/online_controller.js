import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="online"
export default class extends Controller {
  static targets = ["url", "loc"]

  connect() {
    // console.log(this.urlTarget)
    // console.log(this.locTarget)
  }

  update() {
    this._toggle(this.urlTarget)
    this._toggle(this.locTarget)
  }

  _toggle(target) {
    if (target.classList.value.includes('d-none')) {
      target.classList.remove('d-none');
    } else {
      target.classList.add('d-none');
    }
  }
}
