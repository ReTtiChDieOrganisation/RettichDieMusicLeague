class AddSubtitleToWeeks < ActiveRecord::Migration[7.1]
  def change
    add_column :weeks, :subtitle, :string
  end
end
