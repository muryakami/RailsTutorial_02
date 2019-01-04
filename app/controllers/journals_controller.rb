class JournalsController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy, :tasks]
  before_action :correct_user, only: [:edit, :update, :destroy, :tasks]

  def create
    @journal = current_user.journals.build(journal_params)
    @tasks = @journal.tasks.paginate(page: params[:page]) # この辺自信ない
    @journal.journal_tasks = new_journal_tasks(@tasks)
    if @journal.save
      flash[:success] = "Journal created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def edit
    @journal = current_user.journals.find_by(id: params[:id])
  end

  def update
    @journal = current_user.journals.find_by(id: params[:id])
    if @journal.update_attributes(journal_params)
      flash[:success] = "Journal updated"
      redirect_to root_url
    else
      render 'edit'
    end
  end

  def destroy
    @journal.destroy
    flash[:success] = "Journal deleted"
    redirect_back(fallback_location: root_url)
  end

  def tasks
    @title = "tasks"
    @journal = current_user.journals.find_by(id: params[:id])
    @tasks = @journal.tasks.paginate(page: params[:page])
    render 'show_tasks'
  end


  private

    def journal_params
      params.require(:journal).permit(:content)
    end

    def correct_user
      @journal = current_user.journals.find_by(id: params[:id])
      redirect_to root_url if @journal.nil?
    end


    # def check_tasks!
    #   @tasks = []
    #   raise JournalBlankTasksError unless params[:tasks].is_a?(Array) && params[:tasks].any?
    #   params[:tasks].each do |task_params|
    #     check_task! task_params
    #   end
    #   raise JournalBlankTasksError unless @tasks.any?
    #   raise JournalOverTimeError if @tasks.reduce(0){|sum, task_params| sum += task_params[:time].to_i} > Journal::TOTAL_TIME_MAX
    # end

    # def check_task!(task_params)
    #   return unless task_params.respond_to?(:[]) && task_params[:time].to_i > 0
    #   if task_params.key? :id
    #     raise JournalTaskNotFoundError unless current_user.enterprise.tasks.find_by(id: task_params[:id]).present?
    #   else
    #     raise TaskBlankNameError
    #   end
    #   if task_params[:detail].is_a?(String)
    #     raise JournalTooLongDetailError if task_params[:detail].size > JournalTask::DETAIL_MAX_SIZE
    #     raise JournalInvalidCharDetailError if task_params[:detail].with_4bytes?
    #   end
    #   @tasks << task_params
    # end

    def new_journal_tasks(tasks)
      tasks.map do |task|
        new_journal_task(task)
      end
    end

    def new_journal_task(task)
      JournalTask.build(time: task[:time], detail: task[:detail])
    end

end
