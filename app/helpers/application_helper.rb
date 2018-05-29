module ApplicationHelper

  def get_stops
    stops = []
    stops_file = "public/busstops_all.json"

    if File.exist? stops_file
      stops = JSON.parse(File.read(stops_file))
    else
      offset = 0

      loop do
        result = get_stops_from_api(offset)
        stops += result
        break if result.length < 500
        offset += 500
      end

      File.open(stops_file,"w") do |f|
        f.write(stops.to_json)
      end
    end

    stops
  end

  def get_stops_from_api(offset=0)
    url = URI("http://datamall2.mytransport.sg/ltaodataservice/BusStops?$skip=#{offset}")

    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Get.new(url)
    request["AccountKey"] = ENV['DATAMALL_KEY']
    request["accept"] = 'application/json'
    # request["Authorization"] = 'Bearer AAAAAAAAAAAAAAAAAAAAAEMALAAAAAAApCSCNq6dqEuCeSVr9l9mh7yGeAQ%3DV8xOltRxERzzvv14h7qkR4muDZ6qFJICAfvcYHAQRUwd8INBoS'
    request["Cache-Control"] = 'no-cache'
    # request["Postman-Token"] = 'dec6dd3e-32a7-404a-8ec7-17b6998627bb'

    response = http.request(request)
    result = JSON.parse response.read_body
    result['value']
  end

  def write_stops_geojson
    stops = get_stops

    entity_factory = RGeo::GeoJSON::EntityFactory.instance
    factory = RGeo::Geographic.simple_mercator_factory

    result = stops.map do |s|
      entity_factory.feature(factory.point(b.long, b.lat), s['BusStopCode'], s)
    end

        render json: RGeo::GeoJSON.encode(entity_factory.feature_collection(result))
      File.open(geojson_file,"w") do |f|
        json = RGeo::GeoJSON.encode(entity_factory.feature_collection(result))
        f.write(json)
      end
  end

end
