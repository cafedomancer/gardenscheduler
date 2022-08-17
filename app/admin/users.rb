ActiveAdmin.register User do
  permit_params :email, :provider, :uid, :name
end
