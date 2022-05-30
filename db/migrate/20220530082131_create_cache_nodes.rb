class CreateCacheNodes < ActiveRecord::Migration[6.0]
  def change
    create_table :cache_nodes do |t|
      t.string :value

      t.timestamps
    end
  end
end
