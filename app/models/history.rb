class History < ActiveRecord::Base
  set_primary_key :id 
  belongs_to :user
  attr_accessible :TimeLogin, :TimeLogout, :user_id
  default_scope -> {order('created_at DESC')}
  validates :user_id, presence: true
end
