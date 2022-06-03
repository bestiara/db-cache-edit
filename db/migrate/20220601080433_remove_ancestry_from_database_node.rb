class RemoveAncestryFromDatabaseNode < ActiveRecord::Migration[7.0]
  def change
    remove_column :database_nodes, :ancestry, :string, index: true
  end
end
