class IntToBigInt < ActiveRecord::Migration[5.1]
  def change
    change_column :rsas, :n, :integer, :limit => 8
    change_column :rsas, :e, :integer, :limit => 8
    change_column :rsas, :d, :integer, :limit => 8
  end
end
