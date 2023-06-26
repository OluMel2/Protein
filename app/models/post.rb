class Post < ApplicationRecord
  has_one_attached :image
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :tag

  validates :product_name, presence: true
  validates :tast, presence: true
  validates :price, presence: true
  validates :net, presence: true
  validates :serving_size, presence: true
  validates :calorie, presence: true
  validates :protein, presence: true
  validates :description, presence: true



  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def self.ransackable_attributes(auth_object = nil)
    ["price"]
  end
end
