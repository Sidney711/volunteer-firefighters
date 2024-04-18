# spec/requests/accounts_controller_spec.rb
require 'rails_helper'

RSpec.describe "AccountsController", type: :request do
  let(:valid_token) { ENV['API_TOKEN'] }
  let(:invalid_token) { "invalid" }
  let(:valid_attributes) { { account: { email: "userxx@example.com", full_name: "John Doe", birth_date: "1990-01-01", permament_address: "123 Example St", phone: "1234567890", member_code: "ABC123xx" } } }
  let(:invalid_attributes) { { account: { email: "" } } }

  describe "POST /api/accounts" do
    context "with valid token and parameters" do
      it "creates a new Account" do
        post "/api/accounts", params: valid_attributes, headers: auth_headers(valid_token)
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("Account created")
      end
    end

    context "with invalid token" do
      it "does not authorize the request" do
        post "/api/accounts", params: valid_attributes, headers: auth_headers(invalid_token)
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "with invalid parameters" do
      it "does not create an account" do
        post "/api/accounts", params: invalid_attributes, headers: auth_headers(valid_token)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT /api/accounts/:id" do
    let(:account) { Account.create(valid_attributes[:account]) }

    context "with valid token and parameters" do
      it "updates the account" do
        put "/api/accounts/#{account.id}", params: valid_attributes, headers: auth_headers(valid_token)
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("Account updated")
      end
    end

    context "with invalid token" do
      it "does not authorize the request" do
        put "/api/accounts/#{account.id}", params: valid_attributes, headers: auth_headers(invalid_token)
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "DELETE /api/accounts/:id" do
    let(:account) { Account.create(valid_attributes[:account]) }

    context "with valid token" do
      it "deletes the account" do
        delete "/api/accounts/#{account.id}", headers: auth_headers(valid_token)
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("Account deleted")
      end
    end

    context "with invalid token" do
      it "does not authorize the request" do
        delete "/api/accounts/#{account.id}", headers: auth_headers(invalid_token)
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "GET /api/accounts/:id/awards" do
    let(:account) { Account.create(valid_attributes[:account]) }

    context "with valid token" do
      it "returns the account's awards" do
        get "/api/accounts/#{account.id}/awards", headers: auth_headers(valid_token)

        expect(response).to have_http_status(:ok)
        expect(response.body).to include("success")
      end
    end

    context "with invalid token" do
      it "does not authorize the request" do
        get "/api/accounts/#{account.id}/awards", headers: auth_headers(invalid_token)

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "when account does not exist" do
      it "returns 'Account not found' message" do
        get "/api/accounts/9999/awards", headers: auth_headers(valid_token)

        expect(response).to have_http_status(:not_found)
        expect(response.body).to include("Account not found")
      end
    end
  end
end
