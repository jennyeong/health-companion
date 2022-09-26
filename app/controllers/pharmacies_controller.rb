class PharmaciesController < ApplicationController
  def index
    @pharmacies = Pharmacy.all
    @markers = @pharmacies.geocoded.map do |pharmacy|
      {
        lat: pharmacy.latitude,
        lng: pharmacy.longitude,
        info_window: render_to_string(partial: "info_window", locals: {pharmacy: pharmacy})
      }
    end
  end
end
