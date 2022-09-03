class ReportsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_report, only: %i[show]

  def index
    @reports = Report.all
  end

  def show

  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
    @report.user = current_user
    if @report.save
      redirect_to reports_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:shop_url, :shop_name, :shop_location, :med_name,
                                   :effects, :comments, :online, photos: [])
  end
end
