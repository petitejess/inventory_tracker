require 'rails_helper'

RSpec.describe Category, type: :model do
  # Association test
  describe "associations" do
    it { should have_many(:user_stocks) }
  end

  # Validation test
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  # # CRUD test
  # it "should create a category" do
  #   expect(@category).to be_valid
  # end

  # it "should be able to read a category" do
  #   expect(Category.find_by_name(@name)).to eq(@category)
  # end

  # it "should update a category" do
  #   @category.update(name: @update_name)
  #   expect(Category.find_by_name(@update_name)).to eq(@category)
  # end

  # it "should delete a category" do
  #   @category.destroy
  #   expect(Category.find_by_name(@update_name)).to be_nil
  # end

end
