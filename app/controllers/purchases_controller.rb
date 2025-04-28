class PurchasesController < ApplicationController
  load_and_authorize_resource

  # shows assets store
  def index
    @assets = current_user.purchased_assets.page(params[:page]).per(Asset::PER_PAGE)
  end


  def create
    asset = Asset.find(params[:asset_id])

    purchase = current_user.purchases.build(asset: asset)

    if purchase.save
      redirect_to purchases_path, notice: "You’ve purchased “#{asset.title}” successfully!"
    else
      redirect_back fallback_location: asset_path(asset), alert: purchase.errors.full_messages.to_sentence
    end
  end

  def shop
    @available_assets = Asset.includes(:creator).page(params[:page]).per(Asset::PER_PAGE)
  end
end
