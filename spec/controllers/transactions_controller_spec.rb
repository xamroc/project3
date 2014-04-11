require 'spec_helper'
require 'pry'

describe TransactionsController do

  render_views

  before :all do
    user = User.new(email: 'julie123@gmail.com', password: '1234', password_confirmation: '1234')
    user.save
    tool = Tool.new(name: 'Chainsaw', category: 'Tools & Garden', description: 'Put on a hockey mask.')
    tool.save
    Transaction.create(user_id: '1', tool_id: '1')
  end

  describe "GET index" do
    it "returns list of transactions" do
      get :index, :format => :json
      expect(response.status).to eq 200
      expect(response.body).to include '1'
      expect(JSON.load(response.body)["transactions"][0]["user_id"]).to eq 1
    end
  end

  describe "GET show" do

    it "returns one transaction" do
      get :show, :id => 1, :format => :json
      expect(response.status).to eq 200
      expect(response.body).to_not be_nil
      expect(JSON.load(response.body)["user_id"]).to eq 1
    end
  end

end