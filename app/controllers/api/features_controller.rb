class Api::FeaturesController < ApplicationController
    # GET /features
    def index
        # @features = Feature.all
        @per_page = params[:per_page] || 10
        @mag_type = params[:mag_type]
        @page = params[:page] || 1

        if @per_page.to_i > 1000
            render json: { error: "El número por página no puede ser mayor de 1000" }
            return
        end
       
        @features = Feature.paginate(page: @page, per_page: @per_page)

        if @mag_type.present? && (@mag_type != "md" && @mag_type != "ml" && @mag_type != "ms" && @mag_type != "mw" && @mag_type != "me" && @mag_type != "mi" && @mag_type != "mb" && @mag_type != "mlg")
            render json: { error: "Valor mag_type no permitido" }
            return
        end

        if @mag_type.present?
            @features = @features.where(mag_type: @mag_type)
        end
        
        render :index
    end
end
