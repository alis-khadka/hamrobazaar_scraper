# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'pry'

class ScrapingService
  def initialize(hamrobazaar_url)
    @url = hamrobazaar_url
  end

  def call
    begin_scraping
  end

  private

  def begin_scraping
    page = URI.open(@url)
    html_body = Nokogiri::HTML(page)

    # remove product id Ad is removed
    remove_product if html_body.at('b:contains("Ad expired or removed")').try(:text).present?

    {
      url: @url,
      title: html_body.at('.title').text.strip,
      description: html_body.at('//b[contains(text(), "Description")]/../../../../../../..').children[1].text.strip,
      price: html_body.at('//td[contains(text(), "Price:")]/..').children.last.text,
      mobile_number: html_body.at('//td[contains(text(), "Mobile Phone:")]/..').children.last.children.first.text.strip,
      refetch_after: Time.now + 1.weeks
    }
  end

  def remove_product
    product = Product.find_by(url: @url)
    product.destroy if product.present?
    raise StandardError, 'The Ad you are looking for is either expired or removed.'
  end
end
