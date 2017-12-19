class AddForeignKeys < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :rsa_id, :integer
    add_reference :messages, :rsas, index: true
    add_foreign_key :messages, :rsas
  end
end
