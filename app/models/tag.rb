class Tag < ApplicationRecord

  has_many :post, dependent: :destroy

end
