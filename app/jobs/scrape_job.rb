class ScrapeJob < ApplicationJob
  queue_as :default

  def perform(url)
    product_details = ScrapingService.new(url).call
    product = Product.find_by(url: url)

    if product.present?
      product.update!(product_details)
    else
      Product.create!(product_details)
    end

    product_details
  end
end
