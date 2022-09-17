class SerializationsController < ApplicationController
  def show
    @serial_num = Serialization.find(params[:id])
    @medicine = Medicine.find(@serial_num.medicine_id)
  end

end
