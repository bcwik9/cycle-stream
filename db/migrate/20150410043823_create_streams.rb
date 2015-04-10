class CreateStreams < ActiveRecord::Migration
  def change
    create_table :streams do |t|
      t.string :name
      t.integer :current
      t.integer :last

      t.timestamps null: false
    end
  end
end
