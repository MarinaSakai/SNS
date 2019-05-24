class Post < ApplicationRecord
  validates :content, presence: true
  validates :images, length: {maximum: 3}
  mount_uploaders :images, ImageUploader
end
