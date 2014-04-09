require 'spec_helper'

describe UsersController do

  render_views

  before :all do
    User.create(email: 'cvetter34@gmail.com', password: '1234', password_confirmation: '1234')
    User.create(email: 'marcolau@gmail.com', password: '1234', password_confirmation: '1234')
    User.create(email: 'julie@gmail.com', password: '1234', password_confirmation: '1234')
  end

  describe 'GET index' do
    it "return index of users" do
      get :index, :format => :json
      expect(response.status).to eq 200
      expect(response.body).to include 'cvetter34@gmail.com'
      expect(JSON.load(response.body)["users"][0]["email"]).to eq 'cvetter34@gmail.com'
    end
  end

  describe 'GET show' do
    it "returns index of users" do
      # get :show, :id =>, :format => :json
      expect(response.status).to eq 200
      expect(response.body).to_not be_nil
      expect(JSON.load(response.body)["email"]).to eq 'cvetter34@gmail.com'
    end
  end

end