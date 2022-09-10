import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="nav-more"
export default class extends Controller {
  static targets = ["ellipsis"]

  connect() {
    // console.log(this.ellipsisTarget)
  }

  showColor() {
    if (this.ellipsisTarget.classList.value.includes("fa-gray")) {
      this.ellipsisTarget.classList.remove("fa-gray");
    } else {
      this.ellipsisTarget.classList.add("fa-gray");
    }
  }

}
