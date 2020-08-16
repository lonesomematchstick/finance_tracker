class StocksController < ApplicationController

  def search
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])

      if @stock
        respond_to do |format|
          format.js { render partial: 'users/partials/stock_info'}
        end
      else
        respond_to do |format|
          flash.now[:alert] = "No stock was found for #{params[:stock]}"
          format.js { render partial: 'users/partials/stock_info'}
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "You must enter a ticker symbol"
        format.js { render partial: 'users/partials/stock_info'}
      end
    end
  end # search

end