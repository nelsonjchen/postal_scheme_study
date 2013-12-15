require 'csv'
require 'uri'
require 'digest'

File.open('anki_import.txt', 'w') do |file|
  CSV.foreach(ARGV[0]) do |row|
    # Delete own notation for odd or even
    addr = row[0]
    carrier = row[1]
    clean_addr = addr.gsub(/ [A-Z]'/, '')
    full_addr = clean_addr + ', La Puente, CA ' + ARGV[1]
    uri_addr = URI.escape(full_addr)
    filename = Digest::MD5.hexdigest(addr) + '.png'
    file.puts full_addr + '<br/>' + '<img src=\'' + filename + '\'/>' + ';' + carrier
  end
end
