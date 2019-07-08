# frozen_string_literal: true

# Article
class Article < ApplicationRecord
  belongs_to :user
  has_many :article_categories
  has_many :categories, through: :article_categories
  validates :categories, presence: true
  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 50 }
  validates :user_id, presence: true
  before_create :generate_article_slug
  before_create :calculate_article_read_time

  def to_param
    slug
  end

  # Generate a unique slug for an article
  def generate_article_slug
    slug = "#{title.to_s.downcase.gsub(/\W/, '-')}-#{Time.now.to_i}"
    self.slug = slug
  end

  # Calculate the an estimated amount of time it'll take to read an article
  def calculate_article_read_time
    time = description.split(' ').length
    self.read_time = (time.to_f / 250).ceil.to_s
  end
end
