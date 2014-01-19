require 'csv'
require 'uri'
require 'digest'

File.open('anki_import.txt', 'w') do |file|
  CSV.foreach(ARGV[0]) do |row|
    addr = row[0]
    carrier = row[1]

    number_regex = /^(\d+)-(\d+)/
    numbers = number_regex.match(addr)
    puts addr
    example_addr_begin_number = numbers[1].to_i
    example_addr_end_number = numbers[2].to_i
    example_addr_number = (example_addr_begin_number + example_addr_end_number)/2
    eg_addr = addr.gsub(number_regex, example_addr_number.to_s)

    # Delete own notation for odd or even
    clean_addr = addr.gsub(/ [A-Z]'/, '')
    full_addr = addr + ', La Puente, CA ' + ARGV[1]
    uri_addr = URI.escape(full_addr)
    filename = Digest::MD5.hexdigest(addr) + '.png'
    file.puts("#{full_addr} <br/>e.g. #{eg_addr} <br/><img src='#{filename}'>;#{carrier}")
  end
end
