class HomeController < ApplicationController
  def index
  end 

  def search
  	# byebug
  	@postings = Posting.all
  	if params[:location].present?  
	  	@postings = @postings.search_by_location(params[:location])
	   end

  	if params[:category].present?
  		@postings = @postings.search_by_category(params[:category])
  	end

  	if params[:others].present?
  		@postings = @postings.search_by_others(params[:others])
  	end

    if params[:any].present?
      @postings = @postings.search_any_word(params[:any])
    end

      render 'postings/index'

  end

end
