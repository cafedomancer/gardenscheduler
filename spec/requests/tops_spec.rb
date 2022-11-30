# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Top', type: :request do
  describe 'GET /' do
    it 'リクエストが成功すること' do
      get root_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /tos' do
    it 'リクエストが成功すること' do
      get tos_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /pp' do
    it 'リクエストが成功すること' do
      get pp_path
      expect(response).to have_http_status(200)
    end
  end
end
