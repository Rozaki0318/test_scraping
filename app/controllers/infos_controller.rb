class InfosController < ApplicationController
  def index
    agent = Mechanize.new
    page = agent.get('https://news.yahoo.co.jp/pickup/6311783')
    @elements = {'date' => page.search('.date').inner_text, 
                  'title' => page.search('#link').inner_text, 
                  'abstruct' => page.search('.hbody').inner_text}
    render :json => @elements
  end
end
