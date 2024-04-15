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

10.times do
  FactoryBot.create(:account)
end

czech_regions = [
  { name: 'Hlavní město Praha', code: 'CZ010' },
  { name: 'Středočeský kraj', code: 'CZ020' },
  { name: 'Jihočeský kraj', code: 'CZ031' },
  { name: 'Plzeňský kraj', code: 'CZ032' },
  { name: 'Karlovarský kraj', code: 'CZ041' },
  { name: 'Ústecký kraj', code: 'CZ042' },
  { name: 'Liberecký kraj', code: 'CZ051' },
  { name: 'Královéhradecký kraj', code: 'CZ052' },
  { name: 'Pardubický kraj', code: 'CZ053' },
  { name: 'Vysočina', code: 'CZ063' },
  { name: 'Jihomoravský kraj', code: 'CZ064' },
  { name: 'Olomoucký kraj', code: 'CZ071' },
  { name: 'Zlínský kraj', code: 'CZ072' },
  { name: 'Moravskoslezský kraj', code: 'CZ080' }
]

czech_regions.each do |region|
  Region.create!(region)
end

districts = [
  { name: 'Praha 1', code: 'CZ0101' },
  { name: 'Kladno', code: 'CZ0201' },
  { name: 'České Budějovice', code: 'CZ0311' },
  { name: 'Plzeň 1', code: 'CZ0321' },
  { name: 'Karlovy Vary', code: 'CZ0411' },
  { name: 'Ústí nad Labem', code: 'CZ0421' },
  { name: 'Liberec', code: 'CZ0511' },
  { name: 'Hradec Králové', code: 'CZ0521' },
  { name: 'Pardubice', code: 'CZ0531' },
  { name: 'Jihlava', code: 'CZ0631' },
  { name: 'Brno-střed', code: 'CZ0641' },
  { name: 'Olomouc', code: 'CZ0711' },
  { name: 'Zlín', code: 'CZ0721' },
  { name: 'Ostrava', code: 'CZ0801' }
]

Region.all.each_with_index do |region, index|
  District.create!(districts[index].merge(region_id: region.id))
end

awards_data = [
  { name: 'Medaile Za příkladnou práci', award_type: :medal, minimum_service_years: 10, minimum_age: 28, dependent_award_name: 'Čestné uznání OSH – MSH' },
  { name: 'Medaile Za zásluhy', award_type: :medal, minimum_service_years: 5, minimum_age: nil, dependent_award_name: 'Medaile Za příkladnou práci' },
  { name: 'Medaile sv. Floriána', award_type: :medal, minimum_service_years: 5, minimum_age: nil, dependent_award_name: 'Čestné uznání KSH' },
  { name: 'Medaile Za mimořádné zásluhy', award_type: :medal, minimum_service_years: 5, minimum_age: nil, dependent_award_name: 'Čestné uznání SH ČMS' },
  { name: 'Medaile Za věrnost', award_type: :medal, minimum_service_years: 10, minimum_age: 15, dependent_award_name: nil },
  { name: 'Medaile Za zásluhy o výchovu', award_type: :medal, minimum_service_years: 10, minimum_age: nil, dependent_award_name: 'Medaile Za příkladnou práci' },
  { name: 'Medaile Za záchranu života', award_type: :medal, minimum_service_years: nil, minimum_age: nil, dependent_award_name: nil },
  { name: 'Medaile Za odvahu a statečnost', award_type: :medal, minimum_service_years: nil, minimum_age: nil, dependent_award_name: nil },
  { name: 'Medaile Za mezinárodní spolupráci', award_type: :medal, minimum_service_years: nil, minimum_age: nil, dependent_award_name: nil },
  { name: 'Řád sv. Floriána', award_type: :order_award, minimum_service_years: 30, minimum_age: 50, dependent_award_name: 'Medaile Za mimořádné zásluhy' },
  { name: 'Záslužný řád českého hasičstva', award_type: :order_award, minimum_service_years: nil, minimum_age: nil, dependent_award_name: nil },
  { name: 'Titul Zasloužilý hasič', award_type: :recognition, minimum_service_years: 40, minimum_age: 65, dependent_award_name: 'Medaile Za mimořádné zásluhy' },
  { name: 'Titul Čestný funkcionář', award_type: :recognition, minimum_service_years: nil, minimum_age: nil, dependent_award_name: nil },
  { name: 'Titul Čestný člen SH ČMS', award_type: :recognition, minimum_service_years: nil, minimum_age: nil, dependent_award_name: nil }
]

# Creating awards without dependencies
awards_data.each do |award_data|
  Award.create(
    name: award_data[:name],
    award_type: award_data[:award_type],
    minimum_service_years: award_data[:minimum_service_years] || 0,
    minimum_age: award_data[:minimum_age] || 0
  )
end

# Associating dependent awards
awards_data.each do |award_data|
  next unless award_data[:dependent_award_name]
  award = Award.find_by(name: award_data[:name])
  dependent_award = Award.find_by(name: award_data[:dependent_award_name])
  award.update(dependent_award_id: dependent_award.id) if dependent_award
end

# db/seeds.rb

fire_departments = [
  { name: 'Hasičský záchranný sbor Praha 1', code: 'FD0101', address: 'Address 1' },
  { name: 'Hasičský záchranný sbor Kladno', code: 'FD0201', address: 'Address 2' },
  { name: 'Hasičský záchranný sbor České Budějovice', code: 'FD0311', address: 'Address 3' },
  { name: 'Hasičský záchranný sbor Plzeň 1', code: 'FD0321', address: 'Address 4' },
  { name: 'Hasičský záchranný sbor Karlovy Vary', code: 'FD0411', address: 'Address 5' },
  { name: 'Hasičský záchranný sbor Ústí nad Labem', code: 'FD0421', address: 'Address 6' },
  { name: 'Hasičský záchranný sbor Liberec', code: 'FD0511', address: 'Address 7' },
  { name: 'Hasičský záchranný sbor Hradec Králové', code: 'FD0521', address: 'Address 8' },
  { name: 'Hasičský záchranný sbor Pardubice', code: 'FD0531', address: 'Address 9' },
  { name: 'Hasičský záchranný sbor Jihlava', code: 'FD0631', address: 'Address 10' },
  { name: 'Hasičský záchranný sbor Brno-střed', code: 'FD0641', address: 'Address 11' },
  { name: 'Hasičský záchranný sbor Olomouc', code: 'FD0711', address: 'Address 12' },
  { name: 'Hasičský záchranný sbor Zlín', code: 'FD0721', address: 'Address 13' },
  { name: 'Hasičský záchranný sbor Ostrava', code: 'FD0801', address: 'Address 14' }
]

District.all.each_with_index do |district, index|
  FireDepartment.create!(fire_departments[index].merge(district_id: district.id))
end