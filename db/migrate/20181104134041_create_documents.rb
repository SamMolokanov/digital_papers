class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents, id: :uuid do |t|
      t.string :name, limit: 255, null: false
      t.uuid :user_id, null: false, foreign_key: true
      t.timestamps
    end

    add_index :documents, [:user_id, :name], unique: true
    add_foreign_key :documents, :users, column: :user_id, primary_key: :id, on_delete: :restrict
  end
end
