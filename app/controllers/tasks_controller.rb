class TasksController < ApplicationController
  before_action :set_task, only: %i[edit update]
  before_action :check_owner, only: %i[edit update destroy]

  def edit; end

  def update
    if params[:status] == '0'
      @task.done_at = ''
    elsif params[:status] == '1'
      @task.done_at = DateTime.now
    end

    if params[:done_image1_id]
      @task.done_image1.purge
    end

    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to schedule_url(@task.schedule), notice: "作業を更新しました。" }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:done_memo, :done_at, :done_image1)
  end

  def check_owner
    redirect_to root_path, notice: '権限が有りません。' if !user_signed_in? || current_user.id != @task.user_id
  end
end
