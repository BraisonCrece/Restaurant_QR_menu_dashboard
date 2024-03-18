import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

// Connects to data-controller="reload-frames-when-locale-changes"
export default class extends Controller {
    reload() {
        Turbo.cache.clear()
    }
}
