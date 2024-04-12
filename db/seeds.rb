# db/seeds.rb

Account.create!(
  email: "superadmin@example.com",
  password_hash: BCrypt::Password.create('password123'),
  full_name: "Super Admin",
  birth_date: "1980-01-01",
  phone: "123456789",
  member_code: "UNIQCODE123",
  is_super_admin: true,
  status: 2
)

Account.create!(
  email: "franta@example.com",
  password_hash: BCrypt::Password.create('password123'),
  full_name: "Franta",
  birth_date: "1980-01-01",
  phone: "123456789",
  member_code: "UNIQCODE122",
  is_super_admin: false,
  status: 2
)
