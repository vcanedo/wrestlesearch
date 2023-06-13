# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Scrape the data from the website
require "open-uri"
require "nokogiri"

# Setting up array of all wrestling promotions
promotions = ["wwe", "aew", "roh", "njpw", "nwa", "wcw", "ecw", "tna", "wccw"]

# Setting certain url to scrape
# ("a".."z").to_a
urls = promotions.map do |promotion|
  "https://www.thesmackdownhotel.com/roster/?promotion=#{promotion}&date=all-time"
end
# Open the url and read it and setting it to a variable as html file
wrestlers = []
html_files = urls.map do |url|
  URI.open(url).read
end
# Parse the html file and setting it as an html doc
html_doc = html_files.map do |html_file|
  Nokogiri::HTML(html_file)
end

# Create an array of hashes with the data
html_doc.each do |doc|
  doc.search(".roster").each do |element|
    wrestlers << {
      name: element.search(".roster_name").text.strip,
      image: element.search(".jch-lazyloaded").attribute("src").value # ,
      # youtube_url: element.search(".wrestler-img").attribute("data-youtube").value
    }
  end
end

# Create the wrestlers
wrestlers.each do |wrestler|
  Wrestler.create!(wrestler)
end

puts "Finished seeding!"

#  =======================================

# template for scraping news
# https://www.wrestle.buzz/ <---!! This website can be used later to scrape wrestling news, but I need to create a news model first

# create scraper for news
# url = "https://www.wrestle.buzz/"
# html_file = URI.open(url).read
# html_doc = Nokogiri::HTML(html_file)

# news = []
# html_doc.search("div.post").each do |element|
#   news << {
#     title: element.search("h2.post-title").text.strip,
#     date: element.search("span.post-date").text.strip,
#     image_url: element.search("img").attribute("src").value,
#     description: element.search("div.post-entry p").text.strip
#   }
# end

# news.each do |news|
#   News.create!(news)
# end

# =======================================

# optional template for main scraping
# url = "https://www.imdb.com/list/ls009668711/"
# html_file = open(url).read
# html_doc = Nokogiri::HTML(html_file)

# # Create the wrestlers
# html_doc.search(".lister-item-content").each do |element|
#   title = element.search(".lister-item-header a").text.strip
#   year = element.search(".lister-item-year").text.strip.gsub(/[()]/, "").to_i
#   director = element.search(".text-muted+ p a").text.strip
#   plot = element.search(".text-muted+ p").text.strip
#   image_url = element.search(".lister-item-image img").attribute("src").value

#   Wrestler.create(title: title, year: year, director: director, plot: plot, image_url: image_url)
# end
