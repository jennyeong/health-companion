class MedicinesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :scanning, :show ]
  def show
    @medicine = Medicine.find(params[:id])
    # raise
  end

  def scanning
    @barcode = barcode_params
    # binding.pry
    # puts @barcode
    # if @barcode[:symbology] == "data-matrix"
      if Medicine.where(serial_num: @barcode[:data]).exists?
        @medicine = Medicine.where(serial_num: @barcode[:data])
        redirect_to medicine_path(@medicine)
      else
        redirect_to counterfeit_path
      end
      # binding.pry
    # else
    #   redirect_to information_path
    # end
  end

  private

  def barcode_params
    params.require(:medicine).permit(:symbology, :data)
  end
end
