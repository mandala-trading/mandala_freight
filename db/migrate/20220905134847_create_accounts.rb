class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.string :name,        null: false, default: "",    limit: 255
      t.string :time_zone,   null: false, default: "UTC", limit: 50

      t.timestamps null: false
    end
  end
end
