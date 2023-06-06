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

# Setting certain url to scrape
url = "https://www.imdb.com/chart/top/?ref_=nv_mv_250"
# Open the url and read it and setting it to a variable as html file
html_file = URI.open(url).read
# Parse the html file and setting it as an html doc
html_doc = Nokogiri::HTML(html_file)

# Create an array of hashes with the data
wrestlers = []
html_doc.search(".titleColumn").each do |element|
  wrestlers << {
    title: element.search("a").text,
    year: element.search("span.secondaryInfo").text.gsub("(", "").gsub(")", ""),
    poster_url: element.search("img").attribute("src").value,
    ranking: element.text.strip.match(/(?<=\n)\d+(?=.)/).to_s.to_i
  }
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
