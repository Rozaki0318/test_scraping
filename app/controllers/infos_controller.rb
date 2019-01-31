class InfosController < ApplicationController
  def index
    require 'rss'
    @articles = []
    filename = 'https://news.yahoo.co.jp/pickup/computer/rss.xml'
    rss = RSS::Parser.parse(filename)
    rss.items.each{|item|
      agent = Mechanize.new
      page = agent.get("#{item.link}")
      @elements = {'date' => page.search('.date').inner_text, 
                    'title' => page.search('#link').inner_text, 
                    'abstruct' => page.search('.hbody').inner_text}
      @articles << @elements
    }
    render :json => @articles
  end
end
