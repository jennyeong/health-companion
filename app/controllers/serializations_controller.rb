class SerializationsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show ]

  def show
    @serial_num = Serialization.find(params[:id])
    @medicine = Medicine.find(@serial_num.medicine_id)
  end

end
