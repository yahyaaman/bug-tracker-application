class AddScreenshotToBugs < ActiveRecord::Migration[7.0]
  def change
    add_column :bugs, :screenshot, :string
  end
end
