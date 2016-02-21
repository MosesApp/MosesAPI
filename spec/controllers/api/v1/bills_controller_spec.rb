require 'spec_helper'

describe Api::V1::BillsController do
  let(:user) { FactoryGirl.create(:user_with_groups, :controller) }
  let(:token) { double acceptable?: true }

  describe "GET #index" do

    context "when successfully gets user's bills" do
      before(:each) do
        stub_access_token(token)
        stub_current_user(user)
        @bill = FactoryGirl.create(:bill, creator: user, group: user.groups[0])
        get :index
      end

      it "returns the list of user's bills" do
        bill_response = json_response
        expect(bill_response[:bills].size).to eql 1
      end

      it "returns the bill's infomation" do
        bill_response = json_response[:bills][0]
        expect(bill_response[:id]).to eql @bill.id
        expect(bill_response[:name]).to eql @bill.name
        expect(bill_response[:currency][:prefix]).to eql @bill.currency.prefix
        expect(bill_response[:amount]).to eql @bill.amount
      end

      it { should respond_with 200 }
    end

    context "when user not authenticated" do
      before(:each) do
        get :index
      end

      it { should respond_with 401 }
    end

  end

  describe "GET #show" do
    before(:each) do
      @bill = FactoryGirl.create(:bill, creator: user, group: user.groups[0])
      get :show, id: @bill.id
    end

    context "when successfully gets user's bills" do
      before(:each) do
        stub_access_token(token)
        stub_current_user(user)
        get :show, id: @bill.id
      end

      it "returns the bill's infomation" do
        bill_response = json_response
        expect(bill_response[:id]).to eql @bill.id
        expect(bill_response[:name]).to eql @bill.name
        expect(bill_response[:currency][:prefix]).to eql @bill.currency.prefix
        expect(bill_response[:amount]).to eql @bill.amount
        expect(bill_response[:currency][:prefix]).to eql @bill.currency.prefix
        expect(bill_response[:group][:id]).to eql @bill.group.id
      end

      it { should respond_with 200 }
    end

    context "when bill does not exist" do
      before(:each) do
        stub_access_token(token)
        stub_current_user(user)
        get :show, id: 12345
      end

      it "renders an errors json" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it "renders the json errors on why the bill could not be shown" do
        user_response = json_response
        expect(user_response[:errors]).to include "bill not found"
      end

      it { should respond_with 422 }
    end

    context "when user not authenticated" do
      before(:each) do
        get :show, id: @bill.id
      end

      it { should respond_with 401 }
    end

  end
end
