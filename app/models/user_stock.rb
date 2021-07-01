class UserStock < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :batches, inverse_of: :user_stock
  accepts_nested_attributes_for :batches
  has_one_attached :image
end
