class WelcomeController < ApplicationController
  def index
    @mcards = current_sub_admin.mcards
  end
end
