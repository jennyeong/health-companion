class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :scanning, :successful, :counterfeit, :information ]

  def home
    @reports = Report.last(5)
  end

  def scanning
  end

  def successful
    @leftose = Medicine.where(name: "Leftose").first
    # raise
    puts @medicine
  end

  def counterfeit
  end

  def information
  end
end
