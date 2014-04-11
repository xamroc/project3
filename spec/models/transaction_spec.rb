require 'spec_helper'

describe Transaction do

  describe "Each transaction belong to user and tool" do
    it "belongs to user when user is log in" do
      user = User.new(email: 'julie123@gmail.com', password: '1234', password_confirmation: '1234')
      user.save
      transaction = Transaction.new(tool_id: '2')
      transaction.user = user
      transaction.save
      expect(transaction.tool_id).to_not be_nil
      expect(transaction.user_id).to_not be_nil
    end

    it "does not process transaction if user is not log in" do
      transaction = Transaction.new(tool_id: '2')
      transaction.save
      expect(transaction.tool_id).to_not be_nil
      expect(transaction.user_id).to be_nil
    end

    it "belongs to tool when user click on any existing tool" do
      tool = Tool.new(name: 'Chainsaw', category: 'Tools & Garden', description: 'Put on a hockey mask.')
      tool.save
      transaction = Transaction.new(user_id: '1')
      transaction.tool = tool
      transaction.save
      expect(transaction.user_id).to_not be_nil
      expect(transaction.tool_id).to_not be_nil
    end

    it "does not process transaction when user click on unexisting tool" do
      transaction = Transaction.new(user_id: '1')
      transaction.save
      expect(transaction.user_id).to_not be_nil
      expect(transaction.tool_id).to be_nil
    end
  end

end