require 'spec_helper'

describe ToolsController do

  render_views

  before :all do
    Tool.create(name: 'Rubber chicken', category: 'Tools & Garden', description: 'Pok pok.')
  end

  describe '#index' do
    it "returns list of tools" do
      get :index, :format => :json
      expect(response.status).to eq 200
      expect(response.body).to include 'Rubber chicken'
      expect(JSON.load(response.body)["tools"][0]["name"]).to eq 'Rubber chicken'
    end
  end

  describe '#show' do
    it "returns a tool" do
      get :show, :id => 1, :format => :json
      expect(response.status).to eq 200
      expect(response.body).to_not be_nil
      expect(JSON.load(response.body)["name"]).to eq "Rubber chicken"
    end
  end

  # describe '#create' do
  #   it "returns a tools form"
  # end


  # describe '#edit' do
  #   it "returns an edit form"
  # end

  # describe '#update' do
  #   it "returns an edit form after update"
  # end

end