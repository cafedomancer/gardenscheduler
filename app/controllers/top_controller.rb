class TopController < ApplicationController
  def index
    @variety_selected = ''
    @prefecture_selected = ''
    @only_mine = false

    @schedules = Schedule.all.page(params[:page]).order('created_at DESC')
    if user_signed_in?
      @tasks = Task.where(user_id: current_user.id, done_at: [nil, '']).limit(10)
    end

    if params[:variety_id].present?
      @schedules = @schedules.where(variety_id: params[:variety_id])
      @variety_selected = params[:variety_id]
    end
    if params[:prefecture_id].present?
      @schedules = @schedules.where(prefecture_id: params[:prefecture_id])
      @prefecture_selected = params[:prefecture_id]
    end
    if params[:only_mine]
      @schedules = @schedules.where(user_id: current_user.id)
      @only_mine = 'true'
    end
  end
end
