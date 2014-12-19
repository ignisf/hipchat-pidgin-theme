require 'json'

module HipChat
  module Helpers
    module_function

    def open_file(file, &block)
      FileUtils.mkdir_p File.dirname File.join 'HipChat', file
      File.open(File.join('HipChat', file), 'w') do |f|
        block.call f
      end
    end
  end
end
