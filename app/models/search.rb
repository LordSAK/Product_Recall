class Search < ActiveRecord::Base
  attr_accessible :searches
  belongs_to :user

  validates :searches, presence: true
  validates :user_id, presence: true
  default_scope order: 'searches.created_at DESC'
end
