class AddUserRefToBugs < ActiveRecord::Migration[7.0]
  def change
    add_reference :bugs, :user, null: false, foreign_key: true
  end
end
