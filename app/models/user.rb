class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]
  
  validates :name, presence: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.email = auth.info.email || "email@example.com" # email here in case user has no email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name   # assuming the user model has a name
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  # - FRIENDSHIPS
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :received_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :received_friends, through: :received_friendships, source: 'user'

  def active_friends
    friends.select { |friend| friend.friends.include?(self) }
  end

  def pending_friends
    friends.select { |friend| !friend.friends.include?(self) }
  end

  def pending_requests
    return Friendship.where(["friend_id = ?", self.id]).select { |friendship| !friendship.mutual?}
  end

  # - POSTS
  has_many :posts, class_name: "Post", foreign_key: "author_id", dependent: :destroy
  
  # - LIKES
  has_many :likes, class_name: "Like", foreign_key: "user_id", dependent: :destroy
  has_many :liked_posts, through: :likes, source: 'post'

  def unlike(post)
    likes.find_by(post: post)&.destroy
  end

  def like(post)
    likes.create(post: post)
  end
end
