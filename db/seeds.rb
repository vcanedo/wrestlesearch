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

url = "https://www.imdb.com/chart/top/?ref_=nv_mv_250"
html_file = URI.open(url).read
html_doc = Nokogiri::HTML(html_file)

# Create an array of hashes with the data
movies = []
html_doc.search(".titleColumn").each do |element|
  movies << {
    title: element.search("a").text,
    year: element.search("span.secondaryInfo").text.gsub("(", "").gsub(")", ""),
    poster_url: element.search("img").attribute("src").value,
    ranking: element.text.strip.match(/(?<=\n)\d+(?=.)/).to_s.to_i
  }
end

# Create the movies
movies.each do |movie|
  Movie.create!(movie)
end

puts "Finished seeding!"

# optional template
# url = "https://www.imdb.com/list/ls009668711/"
# html_file = open(url).read
# html_doc = Nokogiri::HTML(html_file)

# # Create the movies
# html_doc.search(".lister-item-content").each do |element|
#   title = element.search(".lister-item-header a").text.strip
#   year = element.search(".lister-item-year").text.strip.gsub(/[()]/, "").to_i
#   director = element.search(".text-muted+ p a").text.strip
#   plot = element.search(".text-muted+ p").text.strip
#   image_url = element.search(".lister-item-image img").attribute("src").value

#   Movie.create(title: title, year: year, director: director, plot: plot, image_url: image_url)
# end
