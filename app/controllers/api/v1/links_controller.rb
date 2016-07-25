class Api::V1::LinksController < Api::V1::BaseController
  respond_to :json
  def update
    respond_with Link.find(params[:id]).update(link_params)
  end

  private
    def link_params
      params.require(:link).permit(:read)
    end
end
