require 'pry'
require 'nokogiri'
require 'open-uri'


class Scraper
    BASEPATH = 'https://www.mncraftbrew.org/find-a-brewery'

    def self.get_page
        Nokogiri::HTML(open(BASEPATH))
    end

    def self.scrape_brewery_list
        self.get_page.css("#lcp_instance_0")
    end

    def self.collect_breweries
        breweries_array = []
        self.scrape_brewery_list.each do |brewery|
            breweries_array << {
                :name => brewery.css("li a").attr("title").text,
                :url => brewery.css("li a").attr("href").text
            }
            binding.pry
        end
        breweries_array
    end

    def self.get_brewery_page
        self.collect_breweries.each do |brewery|
            Nokogiri::HTML(open(brewery[:url]))
            
            

end