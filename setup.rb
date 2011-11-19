require 'rubygems'
require 'nokogiri'
require 'open-uri'

output_file = File.new('output.txt', 'w')

if FileTest.exists?('input.txt')
  File.open('input.txt', 'r') do |input_file|

    while line = input_file.gets
      line.chomp.each_line do |url|
        begin
          puts "Fetching: #{url}"
          doc = Nokogiri::HTML(open(url))
          company_url = doc.at_css("small.company_site").text
          puts "Fetched: #{ company_url }"
          output_file.puts company_url
        rescue
          puts "<--- Either the URL isn't correct or unavailable --->"
          output_file.puts "N/A"
        end
      end
    end

  end
else
  puts "================================================================="
  puts "'input.txt' file is missing"
  File.open('input.txt', 'w').close
  puts "We created the file for you. :)"
  puts "Paste the Inc company URLs to the file, and run the setup again."
  puts "================================================================="
end


output_file.close
