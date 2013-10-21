class Vendor < ActiveRecord::Base
	set_primary_key :id 
  attr_accessible :user_id, :vendor
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :vendor, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
end
