require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students=[]

    doc.css("div.student-card").each do |project|
      student_info={
      :name => project.css("h4.student-name").text,
      :location => project.css("p.student-location").text,
      :profile_url => project.css("a").attribute("href").value
      }
      students << student_info
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    student=[]

    content = doc.css("div.social-icon-container a").collect {|project| project.attribute("href").value}
      content.each do |link|
        if link.include?("linkedin")
          student[:linkedin] = link
        elsif link.include?("github")
          student[:github] = link
        elsif link.include?(".com")
          student[:blog] = link
        end
      end
    student[:profile_quote] = doc.css("div.profile.quote").text
    student[:bio] = doc.css("div.description-holder p").text
    end
  end

end
