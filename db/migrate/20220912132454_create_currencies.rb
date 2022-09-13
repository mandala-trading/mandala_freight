class CreateCurrencies < ActiveRecord::Migration[6.1]
  def change
    create_table :currencies do |t|
      t.string     :name,          null: false, default: "", limit: 250
      t.string     :code,          null: false, default: "", limit: 20
      t.string     :symbol,        null: false, default: "", limit: 20
      t.boolean    :archived,      null: false, default: false
      t.references :account,       null: false, foreign_key: true
      t.datetime   :discarded_at
      t.bigint     :created_by_id,              index: true
      t.bigint     :updated_by_id,              index: true

      t.timestamps null: false
    end

    add_column :accounts, :currencies_count, :integer, null: false, default: 0, after: :countries_count
  end
end
