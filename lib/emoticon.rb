module HipChat
  class Emoticon
    attr_accessor :image, :shortcuts

    def initialize(options = {})
      @image, @shortcuts = options.values_at :image, :shortcuts
    end
  end
end
