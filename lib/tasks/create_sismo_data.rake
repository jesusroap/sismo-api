module CreateDataSismo
    def self.create_data
        data = get_external('https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson')
        features = data["features"]
    
        features.take(4).each do |feature|
            if (feature["properties"]["title"] && feature["properties"]["url"] && feature["properties"]["place"] && feature["properties"]["magType"] && feature["geometry"]["coordinates"])
                Feature.find_or_create_by(
                    external_id: feature["id"],
                    magnitude: feature["properties"]["mag"],
                    place: feature["properties"]["place"],
                    time: feature["properties"]["time"],
                    tsumani: feature["properties"]["tsunami"],
                    mag_type: feature["properties"]["magType"],
                    title: feature["properties"]["title"],
                    longitude: feature["geometry"]["coordinates"][0],
                    latitude: feature["geometry"]["coordinates"][1],
                    external_url: feature["properties"]["url"]
                )
            end
        end
        
        puts "Datos sismológicos guardados en la base de datos."
    end

    private
        def self.get_external(url)
            response = HTTParty.get(url)
            # @data = JSON.parse(response.body)
            JSON.parse(response.body)
        end
end

namespace :create_sismo_data do
    desc "Fetch sismo data"
    task fetch: :environment do
        CreateDataSismo.create_data
    end
end
