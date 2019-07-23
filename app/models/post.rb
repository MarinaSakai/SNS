# frozen_string_literal: true

class Post < ApplicationRecord
  validates :content, presence: true
  has_many :post_photos
  accepts_nested_attributes_for :post_photos
  has_many :comments
  accepts_nested_attributes_for :comments
  has_many :favs_posts
  accepts_nested_attributes_for :favs_posts
  belongs_to :user
end
