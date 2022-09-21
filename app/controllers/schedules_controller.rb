class SchedulesController < ApplicationController
  before_action :set_schedule, only: %i[ show edit update destroy ]
  before_action :check_owner, only: %i[ edit update destroy ]

  # GET /schedules or /schedules.json
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

  # GET /schedules/1 or /schedules/1.json
  def show
  end

  # GET /schedules/new
  def new
    if !user_signed_in?
      redirect_to new_user_session_path, notice: "ログインしてください。"
    end
    @schedule = Schedule.new
    @schedule.prefecture_id = current_user&.prefecture_id
  end

  def copy
    if !user_signed_in?
      redirect_to new_user_session_path, notice: "ログインしてください。"
    end
    @original_schedule = Schedule.find(params[:id])
    @schedule = @original_schedule.deep_clone(include: [:tasks])
    @schedule.name = ''
    @schedule.schedule_id = @original_schedule.id

    render :new
  end

  # GET /schedules/1/edit
  def edit
  end

  # POST /schedules or /schedules.json
  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.user = current_user

    respond_to do |format|
      if @schedule.save
        format.html { redirect_to schedule_url(@schedule), notice: "Schedule was successfully created." }
        format.json { render :show, status: :created, location: @schedule }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schedules/1 or /schedules/1.json
  def update
    respond_to do |format|
      if @schedule.update(schedule_params)
        format.html { redirect_to schedule_url(@schedule), notice: "Schedule was successfully updated." }
        format.json { render :show, status: :ok, location: @schedule }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schedules/1 or /schedules/1.json
  def destroy
    @schedule.destroy

    respond_to do |format|
      format.html { redirect_to root_url, notice: "Schedule was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def check_owner
      if !user_signed_in? || current_user.id != @schedule.user_id
        redirect_to root_path, notice: "Permission denied."
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_schedule
      @schedule = Schedule.find(params[:id])
      @tasks = @schedule.tasks.order(date: :asc)
    end

    # Only allow a list of trusted parameters through.
    def schedule_params
      params.require(:schedule).permit(:name, :prefecture_id, :user_id, :variety_id, :schedule_id, tasks_attributes: %I(id date name plan_memo user_id _destroy)).merge(user_id: current_user.id)
    end
end
