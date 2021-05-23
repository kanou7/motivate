class Tweet < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :job
  belongs_to :status

  with_options presence: true do
    validates :title
    validates :text

    with_options numericality: { other_than: 1, message: 'を選択してください' } do
      validates :job_id
      validates :status_id
    end
  end
end
