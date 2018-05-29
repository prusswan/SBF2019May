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

      format.json do
        render json: Block.all,
          only: [:id, :lat, :long, :address, :delivery_date, :lease_start],
          methods: [:address]
      end

      format.geojson do
        entity_factory = RGeo::GeoJSON::EntityFactory.instance
        factory = RGeo::Geographic.simple_mercator_factory
        result = Block.all.map do |b|
          entity_factory.feature(factory.point(b.long, b.lat), b.id,
            address: b.address,
            delivery_date: b.delivery_date,
            lease_start: b.lease_start,
            link:  RailsAdmin::Engine.routes.url_helpers.show_path('block', b.id)
          )
        end

        render json: RGeo::GeoJSON.encode(entity_factory.feature_collection(result))
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
