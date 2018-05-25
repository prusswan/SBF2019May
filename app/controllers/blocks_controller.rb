class BlocksController < ApplicationController
  def index
    @units = Unit.joins(:block)

    respond_to do |format|
      format.html
      format.csv do
        render csv: @units,
          only: [:price, :area, :flat_type],
          add_methods: [:address, :long, :lat, :price_per_area, :delivery_date, :lease_start]
      end
    end
  end

  def updateCoords
    @block = Block.find(params[:id])
    if @block.long_address != params[:address]
      render :status => 500, :nothing => true
      return
    end

    # upgrade to Rails 5 for native JSON column support
    @block.geocode_result = params[:geocode_result]

    @block.long, @block.lat = params[:longlat].split(",").map(&:to_f)
    @block.save
    render :json => {status: :ok}
  end
end
