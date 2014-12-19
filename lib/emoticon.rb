require 'uri'
require_relative 'helpers'

module HipChat
  class Emoticon
    attr_accessor :url, :shortcuts

    def initialize(options = {})
      @url, @shortcuts = options.values_at :url, :shortcuts
    end

    def file_name
      File.basename URI.parse(@url).path
    end

    def fetch!
      open(@url) do |source|
        HipChat::Helpers.open_file(file_name) { |f| f.write source.read }
      end
    end
  end
end
