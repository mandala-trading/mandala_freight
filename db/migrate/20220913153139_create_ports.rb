class CreatePorts < ActiveRecord::Migration[6.1]
  def change
    create_table :ports do |t|
      t.string     :name,              null: false, limit: 250
      t.string     :city,              null: false, limit: 250
      t.references :country,           null: false, foreign_key: true
      t.boolean    :loading_port,      null: false, default: false
      t.boolean    :transhipment_port, null: false, default: false
      t.boolean    :discharge_port,    null: false, default: false
      t.boolean    :delivery_port,     null: false, default: false
      t.boolean    :archived,          null: false, default: false
      t.references :account,           null: false, foreign_key: true
      t.datetime   :discarded_at
      t.bigint     :created_by_id,     index: true
      t.bigint     :updated_by_id,     index: true

      t.timestamps null: false
    end

    add_column :accounts, :ports_count, :integer, null: false, default: 0, after: :currencies_count
  end
end
