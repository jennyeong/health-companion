class MedicinesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :scanning]
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
