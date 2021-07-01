class Category < ApplicationRecord
  has_many :user_stocks

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
