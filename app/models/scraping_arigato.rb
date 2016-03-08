 class Scraping

    def self.lecture_urls
   
     agent = Mechanize.new
     links = []

     next_url = "http://www.39asset.co.jp/html/seminar/index/htm"

    while true do
     page = agent.get(next_url)
     elements = page.search('.seminer_entry_list li a')
     elements.each do |ele|
     links << ele[:href]
   end

    next_link = page.at('.fm_entry_list_next a')
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
        title = page.at('.contents h2').inner_text
        date = page.at('.contents .seminer_entry_dat').inner_text if page.at('.contents .seminer_entry_dat')
        place = page.at('.contents .seminer_entry_loca').inner_text if page.at('.contents .seminer_entry_loca')
        detail = page.at('.contents .seminaer_entry_body').inner_text if page.at('.contents .seminaer_entry_body')

        lecture = Lecture.where(title: title, date: date, place: place, detail: detail).first_or_initialize
        lecture.save
    end
  end

