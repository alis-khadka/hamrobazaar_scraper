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
require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
