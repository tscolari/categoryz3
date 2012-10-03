class CreateDummyObjects < ActiveRecord::Migration
  def change
    create_table :dummy_objects do |t|

      t.timestamps
    end
  end
end
