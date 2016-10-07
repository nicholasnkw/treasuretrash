class TransactionsController < ApplicationController

  def show
    
  end
  
  def create
    @transaction = Transaction.new

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @transaction.posting, notice: 'Transaction was successfully created.' }
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
