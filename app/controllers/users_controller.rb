class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = current_user
  end

  def update
    @user = User.find(params[:user][:id])
    
    if @user.update_attributes(user_params)
      changed_fields = @user.previous_changes.keys
      changed_fields.delete("updated_at")
      if changed_fields.any?
        redirect_to @user, notice: "Updated #{changed_fields.join(', ')}"
      else
        redirect_to @user
      end
    else
      render 'show'
    end
  end

  private

  def user_params
    params.require(:user).permit(:id, :email, :zipcode)
  end
end
