require 'rails_helper'

RSpec.describe Batch, type: :model do
  # Association test
  describe "associations" do
    it { should belong_to(:user_stock) }
  end

  # Validation test
  describe "validations" do
    it { should validate_presence_of(:quantity) }
    it { should validate_numericality_of(:quantity) }
  end
end
