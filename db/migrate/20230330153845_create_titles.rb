class CreateTitles < ActiveRecord::Migration[7.0]
  def change
    create_table :titles do |t|
      t.string :name
      t.string :image
      t.daterange :time_used

      t.timestamps
    end
  end
end
