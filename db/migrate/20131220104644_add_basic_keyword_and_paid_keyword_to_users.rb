class AddBasicKeywordAndPaidKeywordToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :num_of_keywords, :integer
    add_column :users, :basic_keyword, :integer
    add_column :users, :paid_keyword, :integer
  end
end
