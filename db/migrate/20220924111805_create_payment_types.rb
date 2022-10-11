class CreatePaymentTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_types do |t|
      t.string     :name,          null: false, default: "", limit: 250
      t.string     :status,        null: false, default: "active"
      t.references :account,       null: false, foreign_key: true
      t.bigint     :created_by_id,              index: true
      t.bigint     :updated_by_id,              index: true

      t.timestamps null: false
    end

    add_column :accounts, :payment_types_count, :integer, null: false, default: 0, after: :units_count
  end
end
