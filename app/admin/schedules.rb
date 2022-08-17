ActiveAdmin.register Schedule do
  permit_params :name, :prefecture_id, :user_id, :variety_id
end
