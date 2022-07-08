class RemoveColumnError < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :datetime
  end
end
