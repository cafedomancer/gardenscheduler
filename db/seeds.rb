# frozen_string_literal: true

User.create!(email: 'admin@gardenscheduler.com', password: 'password', password_confirmation: 'password')
Variety.create!(
  [
    {
      name: 'ハイビスカス',
      user_id: 1
    },
    {
      name: 'バナナ',
      user_id: 1
    },
    {
      name: 'コーヒー',
      user_id: 1
    },
    {
      name: 'マニラヤシ',
      user_id: 1
    },
    {
      name: 'パッションフルーツ',
      user_id: 1
    },
    {
      name: 'ゴーヤー',
      user_id: 1
    },
    {
      name: '姫高麗芝',
      user_id: 1
    }
  ]
)
