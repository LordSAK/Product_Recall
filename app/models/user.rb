# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :cell_no, :address
   has_secure_password

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :name, presence: true,length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
  				format: { with: VALID_EMAIL_REGEX },
  				uniqueness: {case_sensitive: false }
  
  validates :password,  length: { minimum: 6 }
  validates :password_confirmation, presence: true

  #VALID_CELL_NO_REGEX = /\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})/i
  #validates :cell_no, format: {with: VALID_CELL_NO_REGEX}

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end


end
