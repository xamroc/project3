require 'spec_helper'
require 'pry'

describe TransactionsController do

  render_views

  before :all do
    Transaction.create(user_id: '2', tool_id:'2')
  end

  describe "GET index" do
    it "returns list of transactions" do
      get :index, :format => :json
      expect(response.status).to eq 200
      expect(response.body).to include '2'
      expect(JSON.load(response.body)["transactions"][0]["user_id"]).to eq 2
    end
  end

  describe "GET show" do

    it "returns one transaction" do
      get :show, :id => 1, :format => :json
      expect(response.status).to eq 200
      expect(response.body).to_not be_nil
      expect(JSON.load(response.body)["user_id"]).to eq 2
    end
  end
end