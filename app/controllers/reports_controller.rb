class ReportsController < ApplicationController

  private

  def report_params
    params.require(:report).permit(:shop_url, :shop_name, :shop_location, :med_name,
                                   :effects, :comments, :online, photos: [])
  end
end
