class API::V1::StoresController < API::V1::APIController
  def index
    if params[:product_id].present? && Product.normalize_isn(params[:product_id]).to_i > 999999
      return unless enforce_feature_flag!(:has_upc_lookup)
    end

    @query = query(:stores)

    respond_to do |format|
      format.csv { render text: @query.as_csv }
      format.tsv { render text: @query.as_tsv }
      format.any(:js, :json) { render_json @query.as_json }
    end
  end

  def show
    @query = query(:store)

    respond_to do |format|
      format.csv { render text: @query.as_csv }
      format.tsv { render text: @query.as_tsv }
      format.any(:js, :json) { render_json @query.as_json }
    end
  end
end
