class MedicinesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :scanning]
  def show
  end

  def scanning
    @barcode = barcode_params
    # binding.pry
    # puts @barcode
    if @barcode[:symbology] == "data-matrix"
      if @barcode[:data] == Medicine.where(serial_num: @barcode[:data])
        redirect_to successful_path
      # binding.pry
      else
        redirect_to counterfeit_path
      end
    else
      redirect_to information_path
    end
  end

  private

  def barcode_params
    params.require(:medicine).permit(:symbology, :data)
  end


end
