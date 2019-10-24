class WelcomeController < ApplicationController
  def index
    sign_out current_sub_admin
  end
end
