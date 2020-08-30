class UserStocksController < ApplicationController

  def create
    stock = Stock.check_db(params[:stock])

    if stock.blank?
      stock = Stock.new_lookup(params[:stock])
      if stock.name.blank?
        stock.name = "n/a"
      end
      stock.save
    end

    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "#{stock.name} was successfully added to your portfolio."
    redirect_to my_portfolio_path
  end

  def destroy
    stock = Stock.find(params[:id])
    user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
    user_stock.destroy
    flash[:notice] = "#{stock.ticker} was successfully removed from your portfolio."
    redirect_to my_portfolio_path
  end
end
