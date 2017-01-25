#require 'search_engine'
require 'pg'

@conn = PG.connect(dbname: 'sql_intro')

def print_search_results(search_results)
  search_results.each { |row| puts "Title: #{row['name']},\nUniversity: #{row['university']},\nCategory: #{row['category']},\nPrice:  $#{row['price']}"}
end



def get_user_choice
  print "\nWhat would you like to do, search the available software items by category (1) or originating university (2)? "
  user_choice = gets.chomp

  if user_choice == "1"
    puts "\nHere are the available categories: "

    result = @conn.exec('SELECT DISTINCT category FROM software_items')

    result.each { |row| puts row['category']}

    print "\nWhat category would you like to search? "
    user_choice = gets.chomp

    choice = @conn.exec("SELECT * FROM software_items WHERE category = '#{user_choice}';")

    #choice = search_items(user_choice)

    puts "\nAvailable software: \n"

    print_search_results(choice)

  else
    result = @conn.exec('SELECT DISTINCT university FROM software_items')
    result.each { |row| puts row['university']}

    print "Which university's software would you like to see? "
    user_choice = gets.chomp

    university_search = search_items(user_choice)

    # @conn.exec("SELECT * FROM software_items WHERE university = '#{user_choice}';")

    print_search_results(university_search)
  end
end

def search_items(user_choice)
  @conn.exec("SELECT * FROM software_items WHERE university = '#{user_choice}';")
end

# Not called yet.
def sort_by_column(column)
  conn.exec('SELECT column FROM software_items ORDER BY university, category, price;')
end



def main

get_user_choice




end

main if __FILE__ == $PROGRAM_NAME
