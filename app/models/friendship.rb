class Friendship < ApplicationRecord
  # - RELATIONS
  belongs_to :user
  belonds_to :friend, class_name: "User"

  # - VALIDATIONS
  validates_presence_of :user_id, :friend_id
  validate :user_not_equal_to_friend
  validates_uniqueness_of :user_id, scope: [:friend_id]

  def mutual?
    self.friend.friends.include?(self.user)
  end

  private
  def user_not_equal_to_friend
    errors.add(:friend, "can't be the same as the user") if self.user == self.friend
  end
end