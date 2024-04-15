class CreateSismoDatum < ApplicationRecord
    def test
        data = get_external('https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson')
        features = data["features"]
    
        features.take(6).each do |feature|
          User.find_or_create_by(
            username: feature["properties"]["title"],
          )
        end
        
        # render json: {"success": true}
        puts "Datos de terremotos guardados en la base de datos."
    end

    private
        def get_external(url)
            response = HTTParty.get(url)
            # @data = JSON.parse(response.body)
            JSON.parse(response.body)
        end
end
