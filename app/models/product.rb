# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id            :integer          not null, primary key
#  description   :string
#  mobile_number :string
#  price         :string
#  refetch_after :datetime
#  title         :string
#  url           :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_products_on_url  (url) UNIQUE
#
class Product < ApplicationRecord
  validates :url, presence: true, uniqueness: true

  def should_refetch?
    refetch_after >= Time.now
  end
end
