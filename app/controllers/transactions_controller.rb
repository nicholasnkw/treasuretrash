class TransactionsController < ApplicationController

  def show
    @transaction = Transaction.find(params[:id])
  end
  
  def create
    # @posting = Posting.find(params[:posting_id])
    @posting = Posting.find(params[:posting_id])
    if Transaction.find_by(posting_id: @posting.id, user_id: current_user.id)
      flash[:notice] = "Transaction already been made"
      redirect_to posting_transaction_path(@posting.transaction.id)
    else
      a = current_user.transactions.new(posting_id: @posting.id, status: true)
      a.save
      @posting.update(availability: false)
            #transaction gets created here.

      # @transaction = Transaction.find(params[:id]) #Needed to find the transaction.exp for credit update
      # @transaction.update(transaction_params) #exp for credit update
      # @transaction.user.minus_credit #exp for credit update
      # @transaction.posting.user.add_credit #exp for credit update



      redirect_to posting_transaction_path(@posting.id, a.id)
    end

    # @transaction = Transaction.new(transaction_params)
    # @transaction.posting_id = params[:posting_id]
    # @transaction.user_id = current_user.id 
    # respond_to do |format|
    #   if @transaction.save 
    #     format.html { redirect_to posting_transaction_path(@transaction.posting, @transaction.id), notice: 'Transaction was successfully created.' }
    #   #   format.json { render :show, status: :created, full_address: @posting }
    #   # # else
    #   #   format.html { render :new }
    #   #   format.json { render json: @posting.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def update
    @transaction = Transaction.find(params[:id]) 
    @transaction.update(transaction_params)
    if @transaction.success
      @transaction.user.minus_credit
      @transaction.posting.user.add_credit
    end
    flash[:notice] = "Transaction was successfully completed. You have #{@transaction.user.credit} credits left"
    render 'show'
  end


# if Transaction.find_by(posting_id: @posting.id, user_id: current_user.id)
#       flash[:notice] = "Transaction has already been made"
#       redirect_to posting_transaction_path(@posting.transaction.id)
#     else
#       a = current_user.transactions.new(posting_id: @posting.id, status: true)
#       a.save
#       @posting.update(availability: false)


 def destroy
    @posting = Posting.find(params[:posting_id])
    @transaction = Transaction.find(params[:id])

    @transaction.user.minus_credit
    @transaction.posting.user.add_credit

    @transaction.destroy
    @posting.update(availability: true)
    
    redirect_to posting_path(@posting.id)
 end



  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:status, :success)
    end
end
