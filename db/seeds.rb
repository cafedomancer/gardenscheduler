# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
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
