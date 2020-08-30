class UsersController < ApplicationController
  
  def my_portfolio
    @stocks = current_user.stocks
  end
  
  def my_friends
    @friends = current_user.friends
  end

  def search
    if params[:friend].present?
      @friends = User.matches(params[:friend])
      @friends = current_user.except_current_user(@friends)
      if @friends
        respond_to do |format|
          format.js { render partial: 'users/partials/friend_info'}
        end
      else
        respond_to do |format|
          flash.now[:alert] = "No friend was found for #{params[:friend]}"
          format.js { render partial: 'users/partials/friend_info'}
        end
      end

    else
      respond_to do |format|
        flash.now[:alert] = "You must enter a name or email address."
        format.js { render partial: 'users/partials/friend_info'}
      end
    end
  end

end
