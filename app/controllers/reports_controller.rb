class ReportsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_report, only: %i[show]

  def index
    @reports = Report.order(created_at: :desc)
    @reports = Report.search_by_shop_name_and_shop_location(params[:query]) if params[:query].present?
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "reports/list", locals: {reports: @reports}, formats: [:html] }
    end
  end

  def show
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
    @report.user = current_user
    @report.shop_url = @report.shop_url.gsub(%r{https://}, '') if @report.shop_url.include?("https")
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
    params.require(:report).permit(:shop_url, :shop_name, :shop_location, :country, :medicine_id,
                                   :effects, :comments, :online, photos: [])
  end
end
