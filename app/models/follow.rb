# frozen_string_literal: true

class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :target_user, class_name: "User"
end
