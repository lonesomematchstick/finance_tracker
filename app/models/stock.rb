class Stock < ApplicationRecord

  has_many :user_stocks
  has_many :users, through: :user_stocks


  validates :name, :ticker, presence: true
  def self.new_lookup(ticker_symbol)
    ticker = ticker_symbol.to_s.upcase

    client = authenticate
    begin
      new(ticker: ticker, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol))
    rescue NameError => e
      return nil
    end
  end

  def self.authenticate
    IEX::Api::Client.new(publishable_token: Rails.application.credentials.iex[:publishable_token],
                         secret_token: Rails.application.credentials.iex[:secret_token],
                         endpoint: 'https://sandbox.iexapis.com/v1')
  end

  def self.check_db(ticker_symbol)
    where(ticker: ticker_symbol).first
  end
end
