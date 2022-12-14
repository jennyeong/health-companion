class MedicinesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :scanning ]
  # def show
  #   @serial_num = Serialization.find(params[:id])
  #   @medicine = Medicine.find(@serial_num.medicine_id)
  #   # raise
  # end

  def scanning
    @barcode = barcode_params
    # binding.pry
    # puts @barcode
    if (@barcode[:symbology] == "data-matrix") || (@barcode[:data].length == 12)
      if Serialization.where(serial_num: "#{@barcode[:data]}").exists?
        @serial_num = Serialization.find_by(serial_num: "#{@barcode[:data]}")
        @medicine = Medicine.find(@serial_num.medicine_id)
        # binding.pry
        # raise
        redirect_to serialization_path(@serial_num)
      else
        redirect_to counterfeit_path
      end
      # binding.pry
    else
      redirect_to information_path
    end
  end

  private

  def barcode_params
    params.require(:medicine).permit(:symbology, :data)
  end
end
