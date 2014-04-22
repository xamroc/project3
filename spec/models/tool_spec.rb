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

    it "is false by default" do
      tool.save
      expect(tool.availability).to be_false
    end

  end

  describe "edit item" do

    context "when item is found" do
      it "responds with 200"
      it "shows the resource"
      it "is valid with a name, category, and description"
      it "is invalid without a name"
      it "is invalid without a category"
      it "is invalid without a description"
    end

    context "when item is not found" do
      it "responds with 404"
    end

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

  describe "remove item" do

    context "when item is found" do
      it "responds with 200"
      it "shows the resource"
      it "is nil when removed"
    end

    context "when item is not found" do
      it "responds with 404"
    end

  end

  describe "the association of 1-to-many relationship between user and tools" do
    it "should owned by user" do
      user = User.create(email: 'cvetter34@gmail.com', password: '1234', password_confirmation: '1234')
      tool.user_id = user.id
      tool.save
      expect(tool.owner.email).to eq 'cvetter34@gmail.com'
    end
  end

  describe "Tools can be borrow by many users" do
    it "involve in two transactions" do
      user1 = User.create(email: 'cvetter34@gmail.com', password: '1234', password_confirmation: '1234')
      user2 = User.create(email: 'julie34@gmail.com', password: '1234', password_confirmation: '1234')
      user3 = User.create(email: 'marco34@gmail.com', password: '1234', password_confirmation: '1234')
      tool.user_id = user3.id
      tool.save
      Transaction.create(user_id: user1.id, tool_id: tool.id)
      Transaction.create(user_id: user2.id, tool_id: tool.id)
      expect(tool.transactions.count).to eq 2
    end
  end

end
