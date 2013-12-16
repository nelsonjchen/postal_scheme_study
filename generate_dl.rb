require 'csv'
require 'uri'
require 'digest'

File.open('aria2_import.txt', 'w') do |file|
  CSV.foreach(ARGV[0]) do |row|
    url = 'http://maps.googleapis.com/maps/api/staticmap?size=600x300&sensor=false&key=AIzaSyBZh3BSaHzLRuVQTka_NpTHmvLqg5sWdrM&markers='
    addr = row[0]

    number_regex = /^(\d+)-(\d+)/
    numbers = number_regex.match(addr)
    puts addr
    example_addr_begin_number = numbers[1].to_i
    example_addr_end_number = numbers[2].to_i
    example_addr_number = (example_addr_begin_number + example_addr_end_number)/2
    eg_addr = addr.gsub(number_regex, example_addr_number.to_s)

    # Delete own notation for odd or even
    clean_addr = eg_addr.gsub(/ [A-Z]'/, '')
    full_addr = clean_addr + ', La Puente, CA ' + ARGV[1]
    uri_addr = URI.escape(full_addr)
    filename = Digest::MD5.hexdigest(eg_addr) + '.png'
    file.puts url + uri_addr + "\n  " + 'out=' + filename + "\n  " + 'dir=downloads'
  end
end
