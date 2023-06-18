class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  has_many :posts,    dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  validates :work_out, presence: true

  def active_for_authentication?
    super && (is_deleted == false)
  end

  #ゲストユーザー
  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@guest.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/user_no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image
  end

end
