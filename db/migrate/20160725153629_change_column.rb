class ChangeColumn < ActiveRecord::Migration
  def change
    change_column_default :links, :read, false
  end
end
