require 'rails_helper'

RSpec.describe 'Schedules', type: :request do
  describe '[Action test]' do
    before do
      @user = FactoryBot.create(:user)
    end

    context 'new' do
      it 'access by user' do
        sign_in @user
        get '/schedules/new'
        expect(response).to be_successful
      end
    end
  end
end
