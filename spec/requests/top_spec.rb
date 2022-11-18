require 'rails_helper'

RSpec.describe 'Top', type: :request do
  describe '[Action test]' do
    before do
      @user = FactoryBot.create(:user)
    end

    context 'GET /' do
      it 'access by guest' do
        get '/'
        expect(response).to be_successful
      end

      it 'access by user' do
        sign_in @user
        get '/'
        expect(response).to be_successful
      end
    end
  end
end
