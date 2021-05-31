class ShortUrlsController < ApplicationController
  def show
    if short_url.present?
      render json: { link: short_url.link }, status: 200
    else
      render json: { message: 'Not Found!' }, status: 404
    end
  end

  def create
    # TODO: change to find_or_initialize_by to avoid link duplication
    new_short_url = ShortUrl.new(short_url_attributes)
    if new_short_url.save
      render json: { short_url: new_short_url.get_full_short_url(request.url) }, status: 200
    else
      render json: { message: new_short_url.errors }, status: 500
    end
  end

  private

  def short_url
    @short_url ||= ShortUrl.find_by(internal_path: params[:internal_path])
  end

  def short_url_attributes
    params.require(:short_url).permit(:link)
  end
end
