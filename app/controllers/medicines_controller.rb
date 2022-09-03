class MedicinesController < ApplicationController

  def show
  end

  def scanning
    # binding.pry
    @barcode = barcode_params
    redirect_to successful_path
    # puts "Successful"
    # binding.pry
  end

  private

  def barcode_params
    params.require(:medicine).permit(:symbology, :data)
  end


end
