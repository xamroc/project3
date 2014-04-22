require 'spec_helper'

describe Transaction do

  let(:user){ User.create(email: 'cvetter34@gmail.com', password: '1234', password_confirmation: '1234')}
  let(:tool){ Tool.create(name: 'Trap', category: 'Tools & Garden', description: 'Catch mice.') }
  let(:transaction){ Transaction.create(user_id: '1', tool_id: '1')}

  describe "Each transaction belong to user and tool" do
    it "belongs to user when user is log in" do
      transaction.tool_id = 2
      transaction.user = user
      transaction.save
      expect(transaction.tool_id).to_not be_nil
      expect(transaction.user_id).to_not be_nil
    end

    it "does not process transaction if user is not log in" do
      transaction.tool_id = 2
      transaction.user_id = nil
      transaction.save
      expect(transaction.tool_id).to_not be_nil
      expect(transaction.user_id).to be_nil
    end

    it "belongs to tool when user click on any existing tool" do
      expect(transaction.user_id).to_not be_nil
      expect(transaction.tool_id).to_not be_nil
    end

    it "does not process transaction when user click on unexisting tool" do
      transaction.tool_id = nil
      transaction.save
      expect(transaction.user_id).to_not be_nil
      expect(transaction.tool_id).to be_nil
    end
  end

end