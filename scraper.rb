require './config/environment'
require 'pry'
require 'nokogiri'
require 'open-uri'


class Scraper
    BASEPATH = 'https://www.mncraftbrew.org/find-a-brewery/'

    def self.get_page
        Nokogiri::HTML(open(BASEPATH))
    end

    def self.scrape_brewery_list
        check = self.get_page.css("#lcp_instance_0 li a")
    end

    def self.collect_breweries
        brewery_pages = []
        self.scrape_brewery_list.each do |brewery|
            brewery_pages << brewery.attr("href")
        end
        brewery_pages
    end

    def self.get_brewery_page(brewery_url)
        Nokogiri::HTML(open(brewery_url))
    end

    def self.scrape_description(index)
        if index.css("div.bt_bb_text div.sqs-block-content").text != ""
            index.css("div.bt_bb_text div.sqs-block-content").text.strip
        elsif index.css("div.bt_bb_text p")[0].text == "*Associate Member"
            index.css("div.bt_bb_text p")[1].text.strip
        #Drastic Measures
        elsif index.css("div.bt_bb_text #block-9d227ccbe9b3ef52320a p")[0..1].text != ""
            index.css("div.bt_bb_text #block-9d227ccbe9b3ef52320a p")[0..1].text.strip
        #Wayzata
        #elsif index.css("div.bt_bb_text div.wpb_wrapper") != ""
        #    index.css("div.bt_bb_text div.wpb_wrapper").text.strip
        else
            index.css("div.bt_bb_text p")[0].text.strip
        end
    end


    def self.scrape_street_address(index)
        if index.css("div.bt_bb_text p span.postal-code span.street-address").text != ""
            index.css("div.bt_bb_text p span.postal-code span.street-address").text.strip
        #3rd Act, Bobbing Bobber, Duluth Brewhouse, Waldman
        elsif index.css("div.bt_bb_text div.address").children[0] != nil
            index.css("div.bt_bb_text div.address").children[0].text()
        #The Lab, Torg
        elsif index.css("div.bt_bb_text div.address div._2wzd div.address").children[0] != nil
            address = index.css("div.bt_bb_text div.address div._2wzd div.address").children[1].text().strip.split(/\n/)
            address[0]
        #Drastic Measures, Angry Inch
        elsif index.css("div.bt_bb_text #block-9d227ccbe9b3ef52320a p").text != ""
            address = index.css("div.bt_bb_text #block-9d227ccbe9b3ef52320a p .postal-code").children[0].text().strip
        #YES!!! ENKI, Fitger's Beer, Forager
        elsif index.css("div.bt_bb_text .LrzXr").text != ""
            index.css("div.bt_bb_text .LrzXr").children[0].text().strip
        else
            index.css("div.bt_bb_text p span.street-address").text.strip
        end
    end   

    def self.scrape_city(index)
        if index.css("div.bt_bb_text p span.postal-code span.locality").text != ""
            index.css("div.bt_bb_text p span.postal-code span.locality").text.titleize.strip
        #3rd Act, Bobbing Bobber, Duluth Brewhouse, Waldman
        elsif index.css("div.bt_bb_text div.address").children[1] != nil
            index.css("div.bt_bb_text div.address").children[1].text()
        #The Lab, Torg
        elsif index.css("div.bt_bb_text div.address div._2wzd div.address").children[1] != nil
            address = index.css("div.bt_bb_text div.address div._2wzd div.address").children[1].text().strip.split(/\n/)
            address[1]
        #Drastic Measures, Duluth?
        elsif index.css("div.bt_bb_text #block-9d227ccbe9b3ef52320a p").text != ""
            address = index.css("div.bt_bb_text #block-9d227ccbe9b3ef52320a p .postal-code").children[0].text().strip
        #YES!!! ENKI, Fitger's Beer, Forager
        elsif index.css("div.bt_bb_text .LrzXr").text != ""
            index.css("div.bt_bb_text .LrzXr").children[2].text.titleize.strip
        else
            index.css("div.bt_bb_text p span.locality").text.titleize.strip
        end
    end

    def self.scrape_url(index)
        if index.css("div.bt_bb_text div a").attr("href") != nil
            index.css("div.bt_bb_text div a").attr("href").text.strip
        else   
            index.css("div.bt_bb_text p a").attr("href").text.strip
        end
    end

    def self.scrape_brewery_page
        breweries_array = []
        self.collect_breweries.each do |page|
            index = self.get_brewery_page(page)
                breweries_array << {
                    :name => index.css("span.bt_bb_headline_content span")[0].text,
                    :description => self.scrape_description(index),
                    :street_address => self.scrape_street_address(index),
                    :city => self.scrape_city(index),
                    :state => "MN",
                    :phone => index.css("div.bt_bb_text p span.tel").text.strip,
                    :url => self.scrape_url(index)
                }
        end
        breweries_array
    end          

end