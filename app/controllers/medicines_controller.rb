class MedicinesController < ApplicationController
  def show
  end

  def scanning
    # binding.pry
    @barcode = barcode_params
    puts "Successful"
    # binding.pry
  end

  private

  def barcode_params
    params.require(:medicine).permit(:symbology, :data)
  end


end
