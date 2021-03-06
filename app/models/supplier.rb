class Supplier < ActiveRecord::Base
	set_primary_key :id 
  attr_accessible :supplier, :user_id
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :supplier, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
end
