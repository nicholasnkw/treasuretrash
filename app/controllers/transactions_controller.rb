class TransactionsController < ApplicationController

  def show
    @transaction = Transaction.find(params[:id])
  end
  
  def create
    # @posting = Posting.find(params[:posting_id])
    @transaction = Transaction.new(transaction_params)
    @transaction.posting_id = params[:posting_id]
    @transaction.user_id = current_user.id 
    respond_to do |format|
      if @transaction.save
        format.html { redirect_to posting_transaction_path(@transaction.posting, @transaction.id), notice: 'Transaction was successfully created.' }
      #   format.json { render :show, status: :created, full_address: @posting }
      # # else
      #   format.html { render :new }
      #   format.json { render json: @posting.errors, status: :unprocessable_entity }
      end
    end
  end



  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:status, :success)
    end
end
