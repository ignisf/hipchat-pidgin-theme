module HipChat
  class Manifest
    attr_accessor :name, :description, :icon, :author, :emoticons

    def initialize(options = {})
      @name, @description, @icon, @author = options.values_at :name, :description, :icon, :author
      @emoticons = options[:emoticons] || []
    end

    def to_s
      output = ''
      output << "Name=#{@name}\n" if @name
      output << "Description=#{@description}\n" if @description
      output << "Icon=#{@icon}\n" if @icon
      output << "Author=#{@author}\n" if @author

      output << "\n[XMPP]\n"

      @emoticons.each do |emoticon|
        output << [emoticon.image, emoticon.shortcuts].flatten.join(' ')
        output << "\n"
      end
      output
    end
  end
end
