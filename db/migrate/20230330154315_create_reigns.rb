class CreateReigns < ActiveRecord::Migration[7.0]
  def change
    create_table :reigns do |t|
      t.string :name
      t.daterange :duration
      t.references :wrestler, null: false, foreign_key: true
      t.references :title, null: false, foreign_key: true

      t.timestamps
    end
  end
end
