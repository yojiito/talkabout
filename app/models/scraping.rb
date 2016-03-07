 class Scraping

    def self.lecture_urls
   
     agent = Mechanize.new
     links = []

     next_url = "http://www.rikkyo.ac.jp/events/2015/03/"

    while true do
     page = agent.get(next_url)
     elements = page.search('.right td span a')
     elements.each do |ele|
     links << ele[:href]
   end

    next_link = page.at('.right ul .next a')
    next_url = next_link.get_attribute('href')
    break unless next_url


    links.each do |link|
      puts get_lecture(link)
    end
  end
end

     def self.get_lecture(link)
        agent = Mechanize.new
        page = agent.get(link)
        title = page.at('.right h3 span').inner_text
        place = page.at('.bgc_000000093 a').inner_text if page.at('.bgc_000000093 a')
        detail = page.at('.right p').inner_text if page.at('.right p')

        lecture = Lecture.where(title: title, place: place, detail: detail).first_or_initialize
        lecture.save
    end
  end

