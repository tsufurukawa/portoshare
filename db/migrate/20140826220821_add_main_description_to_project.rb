class AddMainDescriptionToProject < ActiveRecord::Migration
  def change
    add_column :projects, :main_description, :text
  end
end
