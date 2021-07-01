require 'rails_helper'

RSpec.describe User, type: :model do
  # Association test
  describe "associations" do
    it { should have_many(:user_stocks) }
  end

  # # Validation test
  # describe "validations" do
  #   it { should validate_presence_of(:email) }
  #   it { should validate_uniqueness_of(:email) }
  #   it { should validate_length_of(:password).is_at_least(6) }
  #   it { should have_secure_password }
  # end
end
