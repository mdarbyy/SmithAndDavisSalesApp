class ApplicationController < ActionController::Base
  add_flash_types :success, :danger
  before_action :authenticate_user!
end