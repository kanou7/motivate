class User < ApplicationRecord
  has_many :tweets, dependent: :destroy
  has_one_attached :image, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_tweets, through: :likes, source: :tweet

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :job
  belongs_to :status

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :name
    validates :job_id, numericality: { other_than: 1, message: 'を選択してください' }
  end
end
