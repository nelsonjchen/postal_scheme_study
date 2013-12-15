require 'csv'
require 'cgi'

CSV.foreach('./input.csv') do |row|
  puts row[0], row[1]
end
