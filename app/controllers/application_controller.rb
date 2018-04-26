class ApplicationController < ActionController::Base
  include Pundit
  before_action :authenticate_user!, except: :root_path
  protect_from_forgery with: :exception
end
