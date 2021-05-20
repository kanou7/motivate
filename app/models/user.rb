class User < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :job
  belongs_to :status
  has_one_attached :image
  has_many :tweets

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :name
    validates :job_id, numericality: { other_than: 1, message: 'を選択してください' }
  end
end
