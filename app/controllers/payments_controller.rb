class PaymentsController < ApplicationController

  def new
  	@client_token = Braintree::ClientToken.generate
    @user = User.find(params[:id])
    @payment = Payment.new
  end

  def create
    
  	amount = params[:payment][:price]
    nonce = params[:payment_method_nonce]

    render action: :new and return unless nonce
    @user = current_user
    @result = Braintree::Transaction.sale(
      amount: amount,
      payment_method_nonce: params[:payment_method_nonce]
    )
    if @result.success?
      Payment.create(user_id: @user.id, braintree_payment_id: @result.transaction.id, status: @result.transaction.status, fourdigit: @result.transaction.credit_card_details.last_4)
      @user.update(account_type: "premium")
      redirect_to user_path(:id => @user.id), notice: "Congratulations! Your transaction is successful!"
    else
        Payment.create(user_id: @user.id, braintree_transaction_id: @result.transaction.id, status: @result.transaction.status, fourdigit: @result.transaction.credit_card_details.last_4)
        flash[:alert] = "Something went wrong while processing your transaction. Please try again!"
        @client_token = Braintree::ClientToken.generate
        @payment = Payment.new
        render :new
    end
  end
end
