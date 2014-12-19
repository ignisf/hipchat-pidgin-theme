module HipChat
  class Manifest
    attr_accessor :name, :description, :icon, :author, :emoticons

    def initialize(emoticons)
      @name = 'HipChat'
      @description = 'A HipChat smiley theme'
      @author = 'Petko Bordjukov'
      @emoticons = emoticons
    end

    def to_s
      output = ''
      output << "Name=#{@name}\n" if @name
      output << "Description=#{@description}\n" if @description
      output << "Icon=#{@emoticons.find('(hipchat)').file_name}\n" if @emoticons.find('(hipchat)')
      output << "Author=#{@author}\n" if @author

      output << "\n[XMPP]\n"

      @emoticons.each do |emoticon|
        output << [emoticon.file_name, emoticon.shortcuts].flatten.join(' ')
        output << "\n"
      end
      output
    end
  end
end
