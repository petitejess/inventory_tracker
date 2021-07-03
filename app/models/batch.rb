class Batch < ApplicationRecord
  belongs_to :user_stock

  validates :quantity, presence: true, numericality: { greater_than: 0 }
end
