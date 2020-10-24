class Like < ApplicationRecord
  # - RELATIONS
  belongs_to :user
  belongs_to :post

  # - VALIDATIONS
  validates_presence_of :user_id
  validates_presence_of :post_id
end