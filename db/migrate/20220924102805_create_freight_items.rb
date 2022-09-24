class CreateFreightItems < ActiveRecord::Migration[6.1]
  def change
    create_table :freight_items do |t|
      t.string     :name,          null: false, default: "", limit: 250
      t.boolean    :archived,      null: false, default: false
      t.references :account,       null: false, foreign_key: true
      t.datetime   :discarded_at
      t.bigint     :created_by_id,              index: true
      t.bigint     :updated_by_id,              index: true

      t.timestamps null: false
    end

    add_column :accounts, :freight_items_count, :integer, null: false, default: 0, after: :shipping_lines_count
  end
end
