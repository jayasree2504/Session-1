class AddEmailToPatients < ActiveRecord::Migration[8.0]
  def change
    add_column :patients, :email, :string
    add_index :patients, :email, unique: true
  end
end
