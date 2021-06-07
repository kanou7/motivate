class User < ApplicationRecord
  has_many :tweets
  has_one_attached :image
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :like_tweets, through: :likes, source: :tweet

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :job
  belongs_to :status

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.guest
    find_or_create_by!(name: 'ゲスト', email: 'guest@example.com', job_id: 24, status_id: 12) do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  with_options presence: true do
    validates :name
    validates :job_id, numericality: { other_than: 1, message: 'を選択してください' }
  end
end
