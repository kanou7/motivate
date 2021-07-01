class TweetsTag

  include ActiveModel::Model
  attr_accessor :title, :text, :image, :job_id, :status_id, :user_id, :name

  with_options presence: true do
    validates :title
    validates :text

    with_options numericality: { other_than: 1, message: 'を選択してください' } do
      validates :job_id
      validates :status_id
    end
  end

  delegate :persisted?, to: :tweet

  def initialize(attributes = nil, tweet: Tweet.new)
    @tweet = tweet
    attributes ||= default_attributes
    super(attributes)
  end

  def save(tag_list)
    ActiveRecord::Base.transaction do

      @tweet.update(title: title, text: text, image: image, job_id: job_id, status_id: status_id, user_id: user_id)

      @tweet.tweet_tag_relations.each do |tag|
        tag.delete
      end

      tag_list.each do |tag_name|
        tag = Tag.where(name: tag_name).first_or_initialize
        tag.save

        tweet_tag = TweetTagRelation.where(tweet_id: @tweet.id, tag_id: tag.id).first_or_initialize
        tweet_tag.update(tweet_id: @tweet.id, tag_id: tag.id)
      end

    end
  end

  def to_model
    car
  end

  private

  attr_reader :tweet

  def default_attributes
    {
      title: tweet.title,
      image: tweet.image,
      text: tweet.text,
      job_id: tweet.job_id,
      status_id: tweet.status_id,
      name: tweet.tags.pluck(:name).join(',')
    }
  end

end