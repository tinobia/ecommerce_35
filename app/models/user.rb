class User < ApplicationRecord
  attr_accessor :remember_token

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :orders
  has_many :ratings
  has_many :comments
  has_many :products, through: :ratings
  has_many :user_suggestions
  has_many :viewed_product_by_users

  mount_uploader :picture, AvatarUploader

  before_save{self.email = email.downcase}
  validates :name, presence: true, length: {maximum: Settings.user.name.maximum_length}
  VALID_PHONE_REGEX = /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/i
  validates :phone, presence: true, format: {with: VALID_PHONE_REGEX}, uniqueness: {case_sensitive: false}
  validates :address, presence: true, length: {maximum: Settings.user.address.maximum_length}
  # validates :password, presence: true, length: {minimum: Settings.user.password.minimum_length}, allow_nil: true

  scope :alphabet_name, ->{order :name}
end
