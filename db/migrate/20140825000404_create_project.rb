class CreateProject < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title, :subtitle
      t.timestamps
    end
  end
end
