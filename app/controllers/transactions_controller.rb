class TransactionsController < ApplicationController

  def show
    @transaction = Transaction.find(params[:id])
  end
  
  def create
    # @posting = Posting.find(params[:posting_id])
    @posting = Posting.find(params[:posting_id])
    
    if Transaction.find_by(posting_id: @posting.id, user_id: current_user.id)
      flash[:notice] = "Transaction already been made"
      redirect_to posting_path(@posting.id)
    else
      a = current_user.transactions.new(posting_id: @posting.id, status: true)
      a.save
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
    @transaction.update(transaction_params)
    render 'show'
  end



  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      byebug
      params.require(:transaction).permit(:status, :success)
    end
end
