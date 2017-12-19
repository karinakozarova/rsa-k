class NedToString < ActiveRecord::Migration[5.1]
  def change
    change_column :rsas, :n, :string
    change_column :rsas, :e, :string
    change_column :rsas, :d, :string
  end
end
