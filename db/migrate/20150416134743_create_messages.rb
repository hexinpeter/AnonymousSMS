class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :to
      t.text :content
      t.datetime :time

      t.timestamps null: false
    end
  end
end
