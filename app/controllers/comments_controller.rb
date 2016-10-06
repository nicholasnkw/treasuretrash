class CommentsController < ApplicationController
	before_action :find_posting, only: [:create, :edit, :destroy]

	def create
		@posting = Posting.find(params[:posting_id])
		@comment = @posting.comments.create(comment_params)
		@comment.user_id = current_user.id
		@comment.save
		# @comment = current_user.comments.create(comment_params)
		redirect_to posting_path(@posting)
	end

	def edit
		@posting = Posting.find(params[:posting_id])
		@comment = @posting.comments.find(params[:id])
	end

	def update
		if @comment.update(comment_params)
			redirect_to posting_path(@posting.id)
		else 
			render 'edit'
		end
	end

	def destroy
		@posting = Posting.find(params[:posting_id])
		@comment = @posting.comments.find(params[:id])
		@comment.destroy
		redirect_to posting_path(@posting)
	end

	private
	def find_posting
		@posting = Posting.find(params[:posting_id])
	end

	def comment_params
		params.require(:comment).permit(:comment)
	end
end
