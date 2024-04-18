require 'rails_helper'

RSpec.describe Api::FireDepartmentsController, type: :request do
  describe 'GET #index' do
    let(:valid_token) { ENV['API_TOKEN'] }
    let(:invalid_token) { 'invalid_token' }

    context 'with valid token' do
      it 'returns http success' do
        get '/api/fire_departments', headers: { Authorization: "Token #{valid_token}" }
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid token' do
      it 'returns http unauthorized' do
        get '/api/fire_departments', headers: { Authorization: "Token #{invalid_token}" }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
