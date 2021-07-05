class Tag < ApplicationRecord
  has_many :tweet_tag_relations, dependent: :destroy
  has_many :tweets, through: :tweet_tag_relations

  validates :name, uniqueness: true

  def self.search(search)
    if search != ""
      Tag.where(['name LIKE ?', "%#{search}%"])
    else
      Tag.all
    end
  end
end
