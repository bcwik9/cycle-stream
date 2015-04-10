class CreateStreams < ActiveRecord::Migration
  def change
    create_table :streams do |t|
      t.string :stream1name
      t.integer :stream1value
      t.string :stream2name
      t.integer :stream2value

      t.timestamps null: false
    end
  end
end
