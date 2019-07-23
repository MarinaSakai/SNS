# frozen_string_literal: true

class Post < ApplicationRecord
  validates :content, presence: true
  validates :images, length: { maximum: 3 }
  mount_uploaders :images, ImageUploader
  has_many :comments
  accepts_nested_attributes_for :comments
  has_many :favs_posts
  accepts_nested_attributes_for :favs_posts
  belongs_to :user
end
