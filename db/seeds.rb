require_relative '../scraper'

Scraper.scrape_brewery_page.each do |brewery_attr_hash|
    Brewery.create(brewery_attr_hash)
end