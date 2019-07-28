# frozen_string_literal: true

# Comment
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article
  validates :content, presence: true,
                      length: { minimum: 5, maximum: 500 }
end
