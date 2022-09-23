import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="report-map"
export default class extends Controller {
  static values = { apiKey: String, marker: Object }
  connect() {
    mapboxgl.accessToken = this.apiKeyValue;
    this.map = new mapboxgl.Map({
      container: this.element,
      style: 'mapbox://styles/mapbox/streets-v11', // style URL
      center: [103.7916994, 1.3103027], // starting position [lng, lat]
      zoom: 1 // starting zoom
    });

    this.#addMarkerToMap()
    this.#fitMapToMarkers()
  }

  #addMarkerToMap() {
    new mapboxgl.Marker(
      {color: "#AE4040",
      draggable: true}
    )
      .setLngLat([ this.markerValue.lng, this.markerValue.lat ])
      .addTo(this.map)
  }
  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    bounds.extend([ this.markerValue.lng, this.markerValue.lat ])
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }
}
