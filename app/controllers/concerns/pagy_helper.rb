# frozen_string_literal: true

module PagyHelper
  def pagination_metadata
    {
      page: @pagy.page - 1,
      page_size: @pagy.items,
      total_count: @pagy.count,
      total_pages: @pagy.pages
    }
  end

  def page_size
    params[:size] || Pagy::DEFAULT[:items]
  end

  def page_number
    params[:page].to_i + 1 || Pagy::DEFAULT[:page]
  end
end
