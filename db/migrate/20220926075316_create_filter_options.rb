class CreateFilterOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :filter_options do |t|
      t.string     :name,         null: false, limit: 250
      t.string     :module_name,  null: false, limit: 250
      t.string     :module_class, null: false, limit: 250
      t.json       :filters,      null: false
      t.references :user,         null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
