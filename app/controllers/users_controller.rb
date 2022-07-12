class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:errors] = "User Updated Successfully"
      redirect_to users_path
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to edit_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit({ role_ids: [] })
  end
end
