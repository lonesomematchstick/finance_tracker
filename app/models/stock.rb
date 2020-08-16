class Stock < ApplicationRecord

  def self.new_lookup(ticker_symbol)
    ticker = ticker_symbol.to_s.upcase
    client = authenticate
    begin
      new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol))
    rescue NameError => e
      return nil
    end
  end

  def self.authenticate
    IEX::Api::Client.new(publishable_token: Rails.application.credentials.iex[:publishable_token],
                         secret_token: Rails.application.credentials.iex[:secret_token],
                         endpoint: 'https://sandbox.iexapis.com/v1')
  end
end
