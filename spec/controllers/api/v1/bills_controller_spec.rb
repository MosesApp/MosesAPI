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
        bill_response = json_response
        expect(bill_response).to have_key(:errors)
      end

      it "renders the json errors on why the bill could not be shown" do
        bill_response = json_response
        expect(bill_response[:errors]).to include "bill not found"
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

  describe "GET #group_bills" do
    context "when successfully authenticated" do
      before(:each) do
        stub_access_token(token)
        stub_current_user(user)
        @group_with_bills = FactoryGirl.create(:group_with_bills, :controller)
        @group_with_bills.members << user
        @group_with_bills.save
        get :group_index, { group_id: @group_with_bills.id }
      end

      it "returns the groups bills" do
        bills_response = json_response
        expect(bills_response[:bills].size).to eql @group_with_bills.bills.size
        expect(bills_response[:bills][0][:id]).to eql @group_with_bills.bills[0].id
        expect(bills_response[:bills][0][:name]).to eql @group_with_bills.bills[0].name
        expect(bills_response[:bills][0][:amount]).to eql @group_with_bills.bills[0].amount
      end
    end

    context "when user isn't part of group" do
      before(:each) do
        stub_access_token(token)
        stub_current_user(user)
        @group_with_bills = FactoryGirl.create(:group_with_bills, :controller)
        @group_with_bills.save
        get :group_index, { group_id: @group_with_bills.id }
      end

      it "renders an errors json" do
        bill_response = json_response
        expect(bill_response).to have_key(:errors)
      end

      it "renders the json errors on why the bill could not be shown" do
        bill_response = json_response
        expect(bill_response[:errors]).to include "group not found"
      end

      it { should respond_with 422 }
    end

    context "when group doesn't exist" do
      before(:each) do
        stub_access_token(token)
        stub_current_user(user)
        get :group_index, { group_id: 12345 }
      end

      it "renders an errors json" do
        bill_response = json_response
        expect(bill_response).to have_key(:errors)
      end

      it "renders the json errors on why the bill could not be shown" do
        bill_response = json_response
        expect(bill_response[:errors]).to include "group not found"
      end

      it { should respond_with 422 }
    end

    context "when user not authenticated" do
      before(:each) do
        get :group_index, { group_id: 1 }
      end

      it { should respond_with 401 }
    end
  end

end
