class AddVotesCountToProject < ActiveRecord::Migration
  def up
    add_column :projects, :votes_count, :integer, null: false, default: 0

    Project.select(:id) do |project|
      Project.reset_counters(project.id, :votes)
    end
  end

  def down
    remove_column :projects, :votes_count
  end
end
