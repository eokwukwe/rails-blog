class DropPunches < ActiveRecord::Migration[5.2]
  def change
    drop_table :punches
  end
end
