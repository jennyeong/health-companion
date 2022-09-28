class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :scanning, :counterfeit, :information]

  def home
    @reports = Report.order(created_at: :desc).limit(5)
  end

  def scanning
  end

  # def successful
  # @leftose = Medicine.where(name: "Leftose").first
  # puts @medicine
  # end

  def counterfeit
  end

  def information
  end
end
