json.data do
    json.array! @features do |feature|
        json.id feature.id
        json.type "feature"
        json.attributes do
            json.external_id feature.external_id
            json.magnitude feature.magnitude.to_f
            json.place feature.place
            json.time Time.at(feature.time.to_i / 1000).strftime("%d/%m/%Y %H:%M")
            json.tsunami feature.tsumani
            json.mag_type feature.mag_type
            json.title feature.title
            json.coordinates do
                json.longitude feature.longitude.to_f
                json.latitude feature.latitude.to_f
            end
        end
        json.links do
            json.external_url feature.external_url
        end
    end
end
  
json.pagination do
    json.current_page @page.to_i
    json.total @features.count()
    json.per_page @per_page.to_i
end