class User < ApplicationRecord
  has_many :tweets, dependent: :destroy
  has_one_attached :image, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_tweets, through: :likes, source: :tweet

  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follower
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :job
  belongs_to :status

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :name
    validates :job_id, numericality: { other_than: 1, message: 'を選択してください' }
  end

  def following?(user)
    followings.include?(user)
  end

  def follow(user_id)
    relationships.create(follower: user_id)
  end

  def unfollow(relationship_id)
    relationships.find(relationship_id).destroy!
  end
end
