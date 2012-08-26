# encoding: utf-8
require 'open-uri'
require 'rubygems'
require 'hpricot'
require 'iconv'
#grabing files from 6 park
(31833..31879).each do |index|
	#index = "31833"
	url = "http://club.6park.com/ghost/messages/#{index}.html";
	puts url
	doc = open(url) { |f| Hpricot(f) }

	content = ''
	index = 0
	(doc/"table:nth(0)/tr:nth(1)//p").each do |text|
	  #skip first 2 lines
	  if index > 2
		#<[^>]*>.*?> start with < , then zero or more repetion of non '>' symbols, then followed by >, then any symbol until >
		#<.*?/.*?> start with < , then any symbol followng by /> .  for example <br />
		clean = text.inner_html.gsub(%r{<[^>]*>.*?>|<.*?/.*?>|<!.*?-->},"")  
		content << "\n" << clean
	  end
	  index += 1
	end

	#get title
	title = (doc/"title").inner_html
	title = Iconv.iconv('utf-8//IGNORE', 'gb2312',title)

	text = Iconv.iconv('utf-8//IGNORE', 'gb2312',content)
	File.open("#{title[0]}.txt", 'w') {|f| f.write(text[0]) }
end 

