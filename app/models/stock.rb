class Stock < ApplicationRecord

  def self.new_lookup(ticker_symbol)
    ticker = ticker_symbol.to_s.upcase
    client = authenticate
    begin
      client.price(ticker_symbol)
    rescue NameError => e
      puts "Could not find an associated stock with the ticker: #{ticker_symbol}."
    end
  end

  def self.authenticate
    IEX::Api::Client.new(publishable_token: Rails.application.credentials.iex[:publishable_token],
                         secret_token: Rails.application.credentials.iex[:secret_token],
                         endpoint: 'https://sandbox.iexapis.com/v1')
  end
end
