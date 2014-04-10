require 'spec_helper'

describe Tool do

  describe "create item" do

    it "is valid with a name" do
      tool = Tool.new(name: 'Chainsaw', category: 'Tools & Garden', description: 'Put on a hockey mask.')
      tool.save
      expect(tool).to be_valid
    end

    it "is valid with a category"

    it "is valid with a description"

  end

  describe "edit item" do

    it "is valid with a name"

    it "is valid with a category"

    it "is valid with a description"

  end

  it "toggles availability"

  it "is able to remove items"

end
