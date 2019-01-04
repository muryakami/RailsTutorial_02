class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @journal = current_user.journals.build
      # @task = @journal.tasks.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end

end
