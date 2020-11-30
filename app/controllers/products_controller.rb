class ProductsController < ApplicationController
  def index
    products = Product.all.order(id: :desc)
    render json: { data: products, success: true }
  end

  def search
    render json: { success: false, error: 'URL is not of Hamrobazaar' } and return unless url_valid?

    @product = Product.find_by(url: params[:search])

    # If record is old then a week, refetch in background
    ScrapeJob.perform_later(params[:search]) if @product.present? && @product.should_refetch?

    # If record is not in DB, fetch immediately
    @product ||= ScrapeJob.perform_now(params[:search])

    render json: { data: @product, success: true }
  end

  private

  def url_valid?
    params[:search].match(%r{https://hamrobazaar.com/.*\.html}).present?
  end
end
