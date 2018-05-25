require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_index = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    binding.pry
    students = doc.css("div.student-card")
    students.each_with_index |student, index|
      name = names[index].text
      location = location[index].text
      student_index << {:name=>name, :profile_url=> url, :location=>location}
    end
    student_index
  end
  
  def get_link(linkObject)
    link = linkObject.attribute[0].values || ""
  end

  def self.scrape_profile_page(profile_url)
    twitter, linkedin, github, blog = ""
    student_profile = {}
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    social_media = doc.css("")
    social_media.each do |linkObject|
      linkText = get_link(linkObject)
      if linkText.include?("twitter")
        student_profile[:twitter] = linkText
      elsif linkText.include?("linkedin")
        student_profile[:linkedin] = linkText
      elsif linkText.include?("github")
        student_profile[:github] = linkText
      else
        student_profile[:blog] = linkText
      end
    end
    quote = doc.css("")
    if quote != nil
      student_profile[:profile_quote] = quote.text
    end
    bio = doc.css("")
    if bio != nil
      student_profile[:bio] = bio.text
    end
    student_profile
  end

end

