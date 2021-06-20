class ReviewForm
  include ActiveModel::Model
  include Virtus.model

  LENGTH = {
    title: 80,
    body: 500
  }.freeze

  SCORE_RANGE = (1..5).freeze

  attribute :title, String
  attribute :body, String
  attribute :score, Integer
  attribute :book_id, Integer
  attribute :user_id, Integer

  validates :title, :body, :score, presence: true

  validates :title,
            length: { maximum: LENGTH[:title] }

  validates :body,
            length: { maximum: LENGTH[:body] }

  validates :score,
            inclusion: { in: SCORE_RANGE }

  def save
    return false unless valid?

    Review.create(params)
  end

  private

  def params
    {
      title: title,
      body: body,
      score: score,
      book_id: book_id,
      user_id: user_id
    }
  end
end
