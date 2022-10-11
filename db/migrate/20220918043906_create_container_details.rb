class CreateContainerDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :container_details do |t|
      t.string     :name,          null: false, default: "", limit: 250
      t.string     :description,   null: false, default: "", limit: 250
      t.string     :status,        null: false, default: "active"
      t.references :account,       null: false, foreign_key: true
      t.bigint     :created_by_id,              index: true
      t.bigint     :updated_by_id,              index: true

      t.timestamps null: false
    end

    add_column :accounts, :container_details_count, :integer, null: false, default: 0, after: :buyers_count
  end
end
