require 'bundler/setup'
require './scraper'

collection = Scraper.scrape_brewery_page
binding.pry
puts "gotcha"