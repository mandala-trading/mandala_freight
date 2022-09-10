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
