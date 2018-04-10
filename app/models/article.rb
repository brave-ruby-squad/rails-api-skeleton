class Article < ApplicationRecord
  # TODO: Replace with Form Object
  MIN_BODY      = 10
  MAX_BODY      = 200
  MIN_TITLE     = 3
  MAX_TITLE     = 100
  INVALID_REGEX = /.?kek.?/

  validates :title, length: { in: MIN_TITLE..MAX_TITLE }
  validates :body,  length: { in: MIN_BODY..MAX_BODY }

  validate :check_body!

  private

  def check_body!
    return unless body.to_s.match?(INVALID_REGEX)

    errors.add(:body, 'Invalid body')
  end
end
