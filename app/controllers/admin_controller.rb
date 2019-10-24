class AdminController < ActionController::Base
    before_action :authenticate_sub_admin!

    layout 'admin'
end
