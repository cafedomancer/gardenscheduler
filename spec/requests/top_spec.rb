# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Top', type: :request do
  describe 'システムスペック' do
    before do
      @user = FactoryBot.create(:user)
    end

    context 'ゲストがアクセスする' do
      it 'GETでアクセスできる' do
        get '/'
        expect(response).to be_successful
      end
      it 'ゲスト用の内容が表示される' do
        get '/'
        expect(response.body).to include 'Garden Scheduler ってなに？'
      end
      it 'プライバシーポリシーが表示される' do
        get '/pp'
        expect(response.body).to include '本ポリシー'
      end
      it '利用規約が表示される' do
        get '/tos'
        expect(response.body).to include '本規約'
      end
    end

    context 'ユーザーがアクセスする' do
      it 'GETでアクセスできる' do
        sign_in @user
        get '/'
        expect(response).to be_successful
      end
      it 'ユーザー用の内容が表示される' do
        sign_in @user
        get '/'
        expect(response.body).to include '今後の予定作業'
      end
    end
  end
end
