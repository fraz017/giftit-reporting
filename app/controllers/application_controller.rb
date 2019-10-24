class ApplicationController < ActionController::Base
  before_action :authenticate_sub_admin!
end
