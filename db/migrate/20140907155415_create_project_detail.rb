class CreateProjectDetail < ActiveRecord::Migration
  def change
    create_table :project_details do |t|
      t.string :header
      t.text :content
      t.integer :project_id
      t.timestamps
    end
  end
end
