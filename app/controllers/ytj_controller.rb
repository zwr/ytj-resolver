require 'mechanize'
require 'logger'
require 'nokogiri'
require 'open-uri'

class YtjController < ApplicationController
  def index
    code = params.permit('ytunnus')['ytunnus']
    agent = Mechanize.new
    agent.log = Logger.new "mech.log"
    agent.user_agent_alias = 'Mac Safari'
    agent.verify_mode = OpenSSL::SSL::VERIFY_NONE
    page = agent.get('https://www.ytj.fi/')
    form = page.forms.last
    form.fields.last.value = code
    result_page = form.submit
    redirect_to "https://tietopalvelu.ytj.fi/#{result_page.links.find { |l| l.text == code }.uri.to_s}"
  end
end
