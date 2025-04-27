class Creator::AssetsController < ApplicationController
  load_and_authorize_resource

  def index
    @assets = current_user.assets.page(params[:page]).per(Asset::PER_PAGE)
  end

  def bulk_import
    file = params.require(:json_file)
    result = AssetImportService.new(current_user, file).call
  
    if result.success?
      redirect_to creator_assets_path, 
        notice: "Successfully imported #{result.imported_count} assets."
    else
      redirect_to creator_assets_path, 
        alert: result.error_message
    end
  end
end