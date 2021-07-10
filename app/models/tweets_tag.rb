class TweetsTag
  include ActiveModel::Model
  attr_accessor :title, :text, :image, :message, :job_id, :status_id, :user_id, :tweet_id, :name

  with_options presence: true do
    validates :title
    validates :text

    with_options numericality: { other_than: 1, message: 'を選択してください' } do
      validates :job_id
      validates :status_id
    end
  end

  def save(tag_list)
    tweet = Tweet.create(title: title, text: text, image: image, message: message, job_id: job_id, status_id: status_id, user_id: user_id)

    tag_list.each do |tag_name|
      tag = Tag.where(name: tag_name).first_or_initialize
      tag.save

      TweetTagRelation.create(tweet_id: tweet.id, tag_id: tag.id)
    end
  end

  def update(tag_list)
    @tweet = Tweet.where(id: tweet_id)
    tweet = @tweet.update(title: title, text: text, image: image, message: message, job_id: job_id, status_id: status_id, user_id: user_id)
    if tag_list != []
      old_relations = TweetTagRelation.where(tweet_id: tweet)
      old_relations.destroy_all
    end

    tag_list.each do |tag_name|
      tag = Tag.where(name: tag_name).first_or_initialize
      tag.save

      new_relation = TweetTagRelation.new(tweet_id: tweet_id, tag_id: tag.id)
      new_relation.save
    end
  end
end
