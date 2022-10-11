class CreateCountries < ActiveRecord::Migration[6.1]
  def change
    create_table :countries do |t|
      t.string     :name,          null: false, default: "", limit: 250
      t.string     :short_name,    null: false, default: "", limit: 20
      t.string     :status,        null: false, default: "active"
      t.references :account,       null: false, foreign_key: true
      t.bigint     :created_by_id,              index: true
      t.bigint     :updated_by_id,              index: true

      t.timestamps null: false
    end

    add_column :accounts, :countries_count, :integer, null: false, default: 0, after: :users_count
  end
end
