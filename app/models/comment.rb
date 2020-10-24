class Comment < ApplicationRecord
  # - RELATIONS
  belongs_to :author, class_name: "User", foreign_key: "author_id"
  belongs_to :post

  # - VALIDATIONS
  validates_presence_of :author_id
  validates_presence_of :post_id
  validates_presence_of :content

end