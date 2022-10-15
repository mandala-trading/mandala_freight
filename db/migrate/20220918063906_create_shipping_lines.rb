class CreateShippingLines < ActiveRecord::Migration[6.1]
  def change
    create_table :shipping_lines do |t|
      t.string     :name,           null: false, default: "", limit: 250
      t.string     :short_name,     null: false, default: "", limit: 50
      t.string     :street_address, null: false, default: "", limit: 250
      t.string     :city,           null: false, default: "", limit: 250
      t.string     :state,          null: false, default: "", limit: 250
      t.string     :zip_code,       null: false, default: "", limit: 50
      t.column     :risk_profile,   "ENUM('no_risk', 'high_risk', 'medium_risk', 'low_risk')", default: "no_risk"
      t.text       :remarks
      t.boolean    :archived,       null: false, default: false
      t.references :country,        null: false, foreign_key: true
      t.references :account,        null: false, foreign_key: true
      t.bigint     :created_by_id,               index: true
      t.bigint     :updated_by_id,               index: true

      t.timestamps null: false
    end

    add_column :accounts, :shipping_lines_count, :integer, null: false, default: 0, after: :container_details_count
  end
end
