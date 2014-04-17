require 'spec_helper'

NAME = "Trap"
CATEGORY = "Tools & Garden"
DESCRIPTION = "Catch mice."

describe Tool do

  let(:tool){ Tool.create(name: NAME, category: CATEGORY, description: DESCRIPTION) }

  describe "create item" do

    it "is valid with a name, category, and description" do
      expect(tool).to be_valid
    end

    it "is invalid without a name" do
      tool.name = nil
      tool.save
      expect(tool).to be_invalid
    end

    it "is invalid without a category" do
      tool.category = nil
      tool.save
      expect(tool).to be_invalid
    end

    it "is invalid without a description" do
      tool.description = nil
      tool.save
      expect(tool).to be_invalid
    end

  end

  describe "edit item" do

    it "is valid with a name"

    it "is valid with a category"

    it "is valid with a description"

  end

  describe "#toggle_availability" do

    it "is able to toggle to true" do
      tool.toggle_availability
      expect(tool.availability).to be_true
    end

    it "is able to toggle to false" do
      tool.availability = true
      tool.toggle_availability
      expect(tool.availability).to be_false
    end

  end

  it "is able to remove items"

end
