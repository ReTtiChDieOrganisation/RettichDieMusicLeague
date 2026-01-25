import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel", "button"]

  connect() {
    this.updateState()
  }

  toggle() {
    this.panelTarget.classList.toggle("hidden")
    this.updateState()
  }

  updateState() {
    if (!this.hasButtonTarget) return

    const expanded = !this.panelTarget.classList.contains("hidden")
    this.buttonTarget.setAttribute("aria-expanded", expanded.toString())
  }
}
