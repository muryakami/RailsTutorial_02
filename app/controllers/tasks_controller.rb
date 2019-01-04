class TasksController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @journal = Journal.find(params[:journal_id])
    @task = @journal.tasks.build(task_params)
    # @task = current_user.journals.tasks.build(task_params)
    @task.save
    redirect_to root_url
  end

  def destroy
    @task.destroy
    flash[:success] = "Task deleted"
    redirect_back(fallback_location: root_url)
  end

  private

    def task_params
      # params.require(:task).permit(:time, :detail)
      params.require(:task).permit(:time, :detail).merge(journal_id: params[:journal_id])
    end

end
