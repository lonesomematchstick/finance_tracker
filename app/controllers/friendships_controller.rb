class FriendshipsController < ApplicationController

  def create
    # stock = Stock.check_db(params[:stock])

    # if stock.blank?
    #   stock = Stock.new_lookup(params[:stock])
    #   if stock.name.blank?
    #     stock.name = "n/a"
    #   end
    #   stock.save
    # end

    # @user_stock = UserStock.create(user: current_user, stock: stock)
    # flash[:notice] = "#{stock.name} was successfully added to your portfolio."
    # redirect_to my_portfolio_path
  end

  def destroy
    friend = User.find(params[:id]).full_name
    friendship = Friendship.where(user_id: current_user.id, friend_id: params[:id]).first
    friendship.destroy
    flash[:notice] = "You are no longer following #{friend}."
    redirect_to my_friends_path
  end
end
