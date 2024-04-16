class CreateBugs < ActiveRecord::Migration[7.0]
  def change
    create_table :bugs do |t|
      t.string :title
      t.text :description
      t.datetime :deadline
      t.integer :bug_type
      t.integer :bug_status

      t.timestamps
    end
  end
end
