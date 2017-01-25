require 'pg'

conn = PG.connect(dbname: 'sql_intro')

conn.exec('SET client_min_messages TO WARNING');

#To modify table structure, 1st DROP (delete) existing one before recreating.
conn.exec('DROP TABLE software_items;')


result = conn.exec('CREATE TABLE IF NOT EXISTS software_items (id serial primary key, name varchar(100),university varchar(30), contract_signed boolean, category varchar(20), price float(2));')

p result

conn.exec("INSERT INTO software_items (name, university, contract_signed, category, price) VALUES ('Traffic cop', 'NCSU', true, 'GOV', 125);")

conn.exec("INSERT INTO software_items (name, university, contract_signed, category, price) VALUES ('Comparative Toxicogenomic Database', 'NCSU', true, 'BIO', 2000);")

conn.exec("INSERT INTO software_items (name, university, contract_signed, category, price) VALUES ('DNA Aanlyzer', 'Duke', false, 'BIO', 400);")

conn.exec("INSERT INTO software_items (name, university, contract_signed, category, price) VALUES ('MRI Interpreter', 'UNC', false, 'MED DEVICE', 1500);")

conn.exec("INSERT INTO software_items (name, university, contract_signed, category, price) VALUES ('School Disctrict Map', 'NCSU', false, 'GOV', 4500);")

conn.exec("INSERT INTO software_items (name, university, contract_signed, category, price) VALUES ('Diabetes App', 'Duke', false, 'MED DEVICE', 400);")


category = conn.exec('SELECT category FROM software_items;')
puts category

added = conn.exec("SELECT * FROM software_items;")
#added.each { |row| puts row}

# Rescues program if the UniqueViolation is raised b/c insert is not unique.
# begin
#   conn.exec("INSERT INTO characters (name, age, weapon) VALUES ('Thor', 30, 'hammer')")
# rescue PG::UniqueViolation
# end
#
#
# results.each do |character|
#   p character
# end
#

conn.close
