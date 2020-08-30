class User < ApplicationRecord

  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def can_track?(ticker_symbol)
    under_stock_limit? && not_yet_tracking?(ticker_symbol)
  end

  def under_stock_limit?
    stocks.count < 10
  end

  def not_yet_tracking?(ticker_symbol)
    stocks.where(ticker: ticker_symbol).empty?
  end

  def full_name
    return first_name + ' ' + last_name if first_name || last_name
    "Anonymous"
  end

  # match any users with text provided in search field
  def self.matches(param)
    results = []
    %w(email first_name last_name).each do |field|
      results << where("#{field} like ?", "%#{param}%")
    end
    results.flatten.uniq.present? ? results.flatten.uniq : nil
  end

  # remove self from list of matches
  def except_current_user(users)
    users.reject{ |user| user.id == self.id }
  end

  def friends_with?(friend)
    friends.include?(friend)
  end

end
