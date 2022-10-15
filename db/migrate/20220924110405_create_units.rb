class CreateUnits < ActiveRecord::Migration[6.1]
  def change
    create_table :units do |t|
      t.string     :name,           null: false, default: "", limit: 250
      t.boolean    :container_type, null: false, default: false
      t.boolean    :archived,       null: false, default: false
      t.references :account,        null: false, foreign_key: true
      t.bigint     :created_by_id,               index: true
      t.bigint     :updated_by_id,               index: true

      t.timestamps null: false
    end

    add_column :accounts, :units_count, :integer, null: false, default: 0, after: :freight_items_count
  end
end
