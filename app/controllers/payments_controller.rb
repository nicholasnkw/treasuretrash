class PaymentsController < ApplicationController
  before_action :require_login

  def new
  	@client_token = Braintree::ClientToken.generate
    @user = User.find(params[:id])
    @payment = Payment.new
  end

  def create
  	amount = params[:payment][:total_price]
    nonce = params[:payment_method_nonce]

    render action: :new and return unless nonce

    @result = Braintree::Transaction.sale(
      amount: "100",
      payment_method_nonce: params[:payment_method_nonce]
    )

    if @result.success?
      Payment.create(user_id: params[:payment][:user_id], braintree_payment_id: @result.transaction.id, status: @result.transaction.status, fourdigit: @result.transaction.credit_card_details.last_4)

        redirect_to user_path(:id => params[:payment][:user_id]), notice: "Congratulations! Your transaction is successful!"
    else
        Payment.create(user_id: params[:payment][:user_id], braintree_transaction_id: @result.transaction.id, status: @result.transaction.status, fourdigit: @result.transaction.credit_card_details.last_4)
        flash[:alert] = "Something went wrong while processing your transaction. Please try again!"
        @client_token = Braintree::ClientToken.generate
        @user = User.find(params[:payment][:user_id])
        @payment = Payment.new
        render :new
    end
  end
end
