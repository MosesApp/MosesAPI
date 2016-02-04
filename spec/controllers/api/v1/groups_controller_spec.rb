require 'spec_helper'

describe Api::V1::GroupsController do
  describe "GET #show" do
    context "when successfully gets a group" do
      before(:each) do
        @group = FactoryGirl.create :group
        get :show, id: @group.id
      end

      it "returns the group information" do
        group_response = json_response
        expect(group_response[:name]).to eql @group.name
        expect(group_response[:creator_id]).to eql @group.creator[:id]
        expect(group_response[:status]).to eql @group.status

      end

      it { should respond_with 200 }
    end

    context "when group does no exist" do
      before(:each) do
        get :show, id: 111
      end

      it "renders an errors json" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it "renders the json errors on why the group could not be shown" do
        user_response = json_response
        expect(user_response[:errors]).to include "group not found"
      end

      it { should respond_with 422 }
    end
  end

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        @group_attributes = FactoryGirl.attributes_for :group, :controller
        post :create, { group: @group_attributes }
      end

      it "renders the json representation for the group record just created" do
        group_response = json_response
        expect(group_response[:name]).to eql @group_attributes[:name]
        expect(group_response[:status]).to eql @group_attributes[:status]
        expect(group_response[:creator_id]).to eql @group_attributes[:creator_id]
      end

      it { should respond_with 201 }
    end

    context "when is missing attribute" do
      before(:each) do
        @invalid_group_attributes = {name: '', status: '', creator_id: ''}
        post :create, { group: @invalid_group_attributes }
      end

      it "renders an errors json" do
        group_response = json_response
        expect(group_response).to have_key(:errors)
      end

      it "renders the json errors on why the group could not be created" do
        group_response = json_response
        expect(group_response[:errors][:name]).to include "can't be blank"
        expect(group_response[:errors][:creator_id]).to include "can't be blank"
        expect(group_response[:errors][:status]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end

  end

end
