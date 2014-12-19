require 'open-uri'
require 'fileutils'
require 'json'
require_relative 'emoticon'

module HipChat
  class EmoticonList < Array
    def find(shortcut)
      self.select { |emoticon| emoticon.shortcuts.include? shortcut }.first
    end
  end

  class FullEmoticonList < EmoticonList
    def initialize
      super APIEmoticonList.new + NonAPIEmoticonList.new
    end
  end

  class APIEmoticonList < EmoticonList
    begin
      API_TOKEN = File.read(File.expand_path "~/.hipchat-token").strip
    rescue Errno::ENOENT
      raise("Get your API token from https://auctionet.hipchat.com/account/api and put it in ~/.hipchat-token")
    end

    URL = "https://api.hipchat.com/v2/emoticon?max-results=1000&auth_token=#{API_TOKEN}"

    def initialize
      json = open(URL).read
      items = JSON.parse(json)['items']

      emoticons = items.group_by { |item| item['url'] }.map do |url, item_group|
        Emoticon.new url: url, shortcuts: item_group.map { |item| "(#{item['shortcut']})" }
      end

      super emoticons
    end

  end

  class NonAPIEmoticonList < EmoticonList
    FILE = "non-api.json"
    BASE_URL = "https://dujrsrsgsd3nh.cloudfront.net/img/emoticons"

    def initialize
      json = open(FILE).read
      items = JSON.parse(json).values

      emoticons = items.group_by { |item| item['file'] }.map do |file, item_group|
        Emoticon.new url: File.join(BASE_URL, file), shortcuts: item_group.map { |item| item['shortcut'] }
      end

      super emoticons
    end
  end
end
