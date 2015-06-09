class FlexiloadsController < ApplicationController
  before_action :set_flexiload, only: [:show]

  # GET /flexiloads
  def index
    @flexiloads = Flexiload.order(flmcs_order_id: :desc).all
  end

  # GET /flexiloads/1
  def show
  end

  # GET /flexiloads/new
  def new
    @flexiload = Flexiload.new
  end


  # POST /flexiloads
  def create
    @flexiload = Flexiload.new(flexiload_params)

    respond_to do |format|
      if @flexiload.save
        format.html { redirect_to @flexiload, notice: 'Flexiload request was successfully submitted' }
      else
        format.html { render :new }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flexiload
      @flexiload = Flexiload.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flexiload_params
      params.require(:flexiload).permit(:phone, :type, :amount, :flmcs_order_id)
    end
end
