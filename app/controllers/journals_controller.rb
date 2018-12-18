class JournalsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @journal = current_user.journals.build(journal_params)
    if @journal.save
      flash[:success] = "Journal created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @journal.destroy
    flash[:success] = "Journal deleted"
    redirect_back(fallback_location: root_url)
  end

  private

    def journal_params
      params.require(:journal).permit(:content)
    end

    def correct_user
      @journal = current_user.journals.find_by(id: params[:id])
      redirect_to root_url if @journal.nil?
    end

end
