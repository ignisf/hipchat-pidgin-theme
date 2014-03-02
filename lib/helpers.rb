module HipChat
  module Helpers
    module_function
    def load_emoticon_file(file)
      JSON.load File.read file
    end

    def emoticons_from(emoticon_file)
      emoticon_list = load_emoticon_file(emoticon_file).sort_by { |emoticon| emoticon["shortcut"] }
      emoticon_list.group_by { |entry| entry['image'] }.map do |image, emotions|
        Emoticon.new image: image, shortcuts: emotions.map { |emoticon| emoticon['shortcut'] }
      end
    end

    def open_file(file, &block)
      FileUtils.mkdir_p File.dirname File.join 'HipChat', file
      File.open(File.join('HipChat', file), 'w') do |f|
        block.call f
      end
    end
  end
end
