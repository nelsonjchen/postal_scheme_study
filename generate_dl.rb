require 'csv'
require 'uri'
require 'digest'

File.open('aria2dl.txt', 'w') do |file|
  CSV.foreach(ARGV[0]) do |row|
    url = 'http://maps.googleapis.com/maps/api/staticmap?size=600x300&sensor=false&key=AIzaSyBZh3BSaHzLRuVQTka_NpTHmvLqg5sWdrM&markers='
    # Delete own notation for odd or even
    addr = row[0]
    clean_addr = addr.gsub(/ [A-Z]'/, '')
    full_addr = clean_addr + ', La Puente, CA ' + ARGV[1]
    uri_addr = URI.escape(full_addr)
    filename = Digest::MD5.hexdigest(addr)
    file.puts url + uri_addr + "\n  " + 'out=' + filename + ".png\n  " + 'dir=downloads/'
  end
end
