class WelcomeController < ApplicationController
  include WelcomeHelper

  def index
  end

  def search
    zip = params[:search]
    get_school_data(zip)
  end
end