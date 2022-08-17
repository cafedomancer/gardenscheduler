ActiveAdmin.register Task do
  permit_params :schedule_id, :user_id, :date, :name, :plan_memo, :done_memo, :done_at
end
