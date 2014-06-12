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
  set_primary_key :id 
  attr_accessible :email, :FirstName, :LastName, :password, :password_confirmation,
   :cell_no, :street,:city,:state,:zip,:usertype, :alerts,:Advance_Search_allow,:paid_Alert,:basic_Alert,
   :alert_type
   has_secure_password
   has_many :searches, dependent: :destroy
   has_many :vendors, dependent: :destroy
   has_many :suppliers, dependent: :destroy
   has_many :histories,dependent: :destroy

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  

  #validates :name, presence: true,length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
  				format: { with: VALID_EMAIL_REGEX },
  				uniqueness: {case_sensitive: false }
  
  validates :FirstName,presence: true
  validates :LastName,presence: true
  validates :cell_no,presence: true
  validates :street,presence: true
  validates :city,presence: true
  validates :state,presence: true
  validates :zip,presence: true
  
  validates :password,  length: { minimum: 6 }

  validates :password_confirmation, presence: true

  VALID_CELL_NO_REGEX = /\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})/i
  validates :cell_no, format: {with: VALID_CELL_NO_REGEX}

  def Supplier_feed
    # This is preliminary. See "Following users" for the full implementation.
    Supplier.where("user_id = ?", id)
  end

   def Vendor_feed
    # This is preliminary. See "Following users" for the full implementation.
    Vendor.where("user_id = ?", id)
  end

  def is_Basic?(basic)
    self.where(:usertype => basic).present?
  end

def send_password_reset
  generate_token(:password_reset_token)
  self.password_reset_sent_at = Time.zone.now
  save!(validate: false)
  UserMailer.password_reset(self).deliver
end

def generate_token(column)
  begin
    self[column] = SecureRandom.urlsafe_base64
  end while User.exists?(column => self[column])
end

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end



end
