account = Account.create(name: "Mandala Freight Pty. Lty.", time_zone: "Sydney")

user = User.create!(
  first_name: "Mandala",
  last_name: "Reports",
  email: "mandalareports@gmail.com",
  superadmin: true,
  password: "123456",
  confirmed_at: Time.now,
  account: account
)

User.current_user = user

account.countries.create(name: "Argentina", short_name: "ARG")
account.countries.create(name: "Turkey", short_name: "TUR")
account.countries.create(name: "Brazil", short_name: "BRA")
account.countries.create(name: "Nepal", short_name: "NPL")
account.countries.create(name: "Australia", short_name: "AUS")

account.currencies.create(name: "Australian Dollar", code: "AUD", symbol: "A$")
account.currencies.create(name: "US Dollar", code: "USD", symbol: "$")
account.currencies.create(name: "UK Pound", code: "GBP", symbol: "£")
account.currencies.create(name: "Rupees", code: "INR", symbol: "₹")

account.units.create(name: "Container", container_type: true)
account.units.create(name: "Document", container_type: false)

account.payment_types.create(name: "Prepaid")
account.payment_types.create(name: "Collect")

account.charge_types.create(name: "Origin")
account.charge_types.create(name: "Destination")

account.freight_items.create(name: "Premium Quality Container")
account.freight_items.create(name: "Documentation Fee")
account.freight_items.create(name: "Terminal Handling Service")
account.freight_items.create(name: "Inland Haulage Import")
account.freight_items.create(name: "Ocean Freight")
account.freight_items.create(name: "Container Grade Service")
account.freight_items.create(name: "Customs Clearance Destination")
account.freight_items.create(name: "Food Quality Surcharge")

account.container_details.create(name: "20 Feet Container", description: "Packed in 20 Feet Containers")
account.container_details.create(name: "25 KG Bag", description: "Packed in 25 KG bags")
account.container_details.create(name: "40 Feet Container", description: "Packed in 40 Feet Containers")
account.container_details.create(name: "45 KG Bag", description: "Packed in 45 KG bags")

account.ports.create(name: "Adelaide", city: "Adelaide", country_id: account.countries.sample.id, loading_port: true, transhipment_port: false, discharge_port: true, delivery_port: true)
account.ports.create(name: "Fremantle", city: "Fremantle", country_id: account.countries.sample.id, loading_port: true, transhipment_port: false, discharge_port: true, delivery_port: true)
account.ports.create(name: "Brisbane", city: "Brisbane", country_id: account.countries.sample.id, loading_port: true, transhipment_port: false, discharge_port: true, delivery_port: true)
account.ports.create(name: "Melbourne", city: "Melbourne", country_id: account.countries.sample.id, loading_port: true, transhipment_port: false, discharge_port: true, delivery_port: true)
account.ports.create(name: "Sydney", city: "Sydney", country_id: account.countries.sample.id, loading_port: true, transhipment_port: false, discharge_port: true, delivery_port: true)
account.ports.create(name: "Paranagua", city: "Brazil", country_id: account.countries.sample.id, loading_port: true, transhipment_port: false, discharge_port: false, delivery_port: false)

40.times do |t|
  short_name = Faker::Company.name
  account.shipping_lines.create(
    name: "#{short_name} #{Faker::Company.suffix}",
    short_name: short_name,
    street_address: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    zip_code: Faker::Address.zip,
    risk_profile: ShippingLine::RISK_PROFILES_LIST.sample,
    remarks: Faker::Quote.famous_last_words,
    country_id: account.countries.sample.id
  )

  short_name = Faker::Company.name
  account.buyers.create(
    name: "#{short_name} #{Faker::Company.suffix}",
    short_name: short_name,
    street_address: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    zip_code: Faker::Address.zip,
    risk_profile: ShippingLine::RISK_PROFILES_LIST.sample,
    remarks: Faker::Quote.famous_last_words,
    country_id: account.countries.sample.id
  )
end
