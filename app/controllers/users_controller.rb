class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = current_user
  end

  def update
    @user = User.find(params[:user][:id])

    if @user.update_attributes(user_params)
      changed_fields = build_change_attr_array
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

  def build_change_attr_array
    changed_fields = @user.previous_changes.keys
    changed_fields.delete("updated_at")
    changed_fields.map! { |field| field.split('_').join(' ') }
  end

  def user_params
    params.require(:user).permit(:id, :email, :zipcode, :political_party)
  end
end
