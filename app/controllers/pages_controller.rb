class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :scanning, :successful ]

  def home
  end

  def scanning
  end

  def successful

  end
end
