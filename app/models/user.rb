class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
	has_many :favorites, dependent: :destroy
	has_many :book_comments, dependent: :destroy
  attachment :profile_image, destroy: false

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name Like?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name Like?", "#{word}%")
    elsif search == "backward_match"
      @user = User.where("name Like?", "%#{word}")
    elsif search == "partial_match"
      @user = User.where("name Like?", "%#{word}%")
    else
      @user = User.all
    end
  end
end
