require 'rails_helper'

RSpec.describe UserStock, type: :model do
  # Association test
  describe "associations" do
    it { should belong_to(:category) }
    it { should belong_to(:user) }
    it { should have_many(:batches) }
    it { should accept_nested_attributes_for(:batches) }
  end

  # Validation test
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:category) }
    it { should validate_attachment_size(:image).less_than(2.megabytes) }
  end
end
