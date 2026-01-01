class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  validates :email, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  before_save :capitalize_user

  private 
  def capitalize_user
    if first_name.present?
      self.first_name = first_name.strip.split.map(&:capitalize).join(" ")
    end

    if last_name.present?
      self.last_name = last_name.strip.split.map(&:capitalize).join(" ")
    end
  end
end