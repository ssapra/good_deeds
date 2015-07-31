class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = current_user
  end

  def update
    @user = User.find(params[:user][:id])

    if @user.update_attributes(user_params)
      changed_fields = build_change_attr_array
      changed_fields << 'tags' if user_params.include?('user_tags_attributes')
      if changed_fields.any?
        redirect_to @user, notice: "Updated #{changed_fields.join(', ')}"
      else
        redirect_to @user
      end
    else
      flash[:alert] = @user.errors.full_messages.join(", ")
      render 'show'
    end
  end

  def destroy
    UserTag.find_by_tag_id_and_user_id(params[:tag_id], current_user.id).destroy
    @tag_id = params[:tag_id]
  end

  private

  def build_change_attr_array
    changed_fields = @user.previous_changes.keys
    changed_fields.delete("updated_at")
    changed_fields.map! { |field| field.split('_').join(' ') }
  end

  def user_params
    params.require(:user).permit(:id, :email, :zipcode, :political_party,
                                 user_tags_attributes: [:tag_id, :user_id])
  end
end
