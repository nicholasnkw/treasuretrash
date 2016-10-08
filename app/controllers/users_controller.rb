class UsersController < ApplicationController
  
    

  def show
  	@user = User.find(params[:id])
    # @base64_identicon
  end

  def edit
  	@user = current_user
  end

  def update
  	@user = User.find(current_user.id)
  	if @user.update(user_params)
  		bypass_sign_in(@user)
  		redirect_to root_path
  	else 
  		render "edit"
  	end
  end

  def transactions
  end

  def postings
  end

  private
  def user_params
  	params.require(:user).permit(:password, :password_confirmation)
  end

end
