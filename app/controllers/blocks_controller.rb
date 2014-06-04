class BlocksController < ApplicationController
  def index
  end
  def updateCoords
    @block = Block.find(params[:id])
    if @block.long_address != params[:address]
      render :status => 500, :nothing => true
      return
    end

    @block.lat = params[:lat]
    @block.long = params[:long]
    @block.save
    render :json => {status: :ok}
  end
end
