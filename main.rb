#require 'search_engine'
require 'pg'

@conn = PG.connect(dbname: 'sql_intro')

def get_user_choice
  puts "What would you like to do, search the available software items by category (1) or originating university (2)? "
  user_choice = gets.chomp
  if user_choice == "1"
    result = @conn.exec('SELECT DISTINCT category FROM software_items')
    result.each { |row| puts row['category']}
    print "What category would you like to search?"
    category_choice = gets.chomp
    choice = @conn.exec("SELECT * FROM software_items WHERE category = '#{category_choice}';")
    choice.each { |row| puts "#{row['name']} : #{row['university']} : #{row['price']}"}
  else
    result = @conn.exec('SELECT DISTINCT university FROM software_items')
    result.each { |row| puts row['university']}
    print "Which university's software would you like to see? "
    user_univ_choice = gets.chomp
    university_search = @conn.exec("SELECT * FROM software_items WHERE university = '#{user_univ_choice}';")
    university_search.each { |row| puts "#{row['name']}\n#{row['category']}\n#{row['price']}"}

  end
end


def sort_by_column(column)
  conn.exec('SELECT column FROM software_items ORDER BY university, category, price;')
end



def main

get_user_choice




end

main if __FILE__ == $PROGRAM_NAME


# Write a program that connects to the database and asks the user to search, sort, and filter the data using SQL statements. You will need to research a little bit in how to select and order by certain columns for this to work. Or you can perform the searching, sorting, and filtering in Ruby - but it's faster if you do it in SQL.
# For a given result set, have the program display the results in a clean manner to the user.
