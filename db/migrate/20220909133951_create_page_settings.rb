class CreatePageSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :page_settings do |t|
      t.string     :module_name,          null: false, limit: 250
      t.string     :module_class,         null: false, limit: 250
      t.integer    :page_items,           null: false, default: 20
      t.json       :column_settings,      null: false
      t.boolean    :hide_deleted_records, null: false, default: true
      t.references :user,                 null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
