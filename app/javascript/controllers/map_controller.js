import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

export default class extends Controller {
  static values = { apiKey: String }
  connect() {
    mapboxgl.accessToken = this.apiKeyValue;
    this.map = new mapboxgl.Map({
      container: this.element,
      style: 'mapbox://styles/mapbox/streets-v11', // style URL
      center: [103.8198, 1.3521], // starting position [lng, lat]
      zoom: 10 // starting zoom
    });

    this.map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken, mapboxgl: mapboxgl }))

    // Initialize the GeolocateControl.
    const geolocate = new mapboxgl.GeolocateControl({
      positionOptions: {
      enableHighAccuracy: true
      },
      trackUserLocation: true
    });
    // Add the control to the map.
    this.map.addControl(geolocate);
    // Set an event listener that fires
    // when a geolocate event occurs.
    geolocate.on('geolocate', () => {
      console.log('A geolocate event has occurred.');
    });
  }
}
