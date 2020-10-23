class Post < ApplicationRecord
  # - RELATIONS
  belongs_to :author, class_name: "User", foreign_key: "author_id"
  # has_many :comments

  # - VALIDATIONS
  validates_presence_of :author_id
  validates_presence_of :content

end