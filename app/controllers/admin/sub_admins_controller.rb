class Admin::SubAdminsController < AdminController
  before_action :authenticate_sub_admin!

  def edit
    @user = current_sub_admin
  end

  def update_password
    @user = current_sub_admin
    if @user.update(user_params)
      # Sign in the user by passing validation in case their password changed
      bypass_sign_in(@user)
      redirect_to root_path
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:sub_admin).permit(:password, :password_confirmation, :phone, :first_name, :last_name)
  end
end