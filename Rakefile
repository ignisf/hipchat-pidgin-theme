require 'open-uri'
require 'fileutils'
require_relative 'lib/emoticon'
require_relative 'lib/manifest'
require_relative 'lib/helpers'

options = {
  name: 'Hip Chat',
  description: 'A HipChat smiley theme',
  icon: 'hipchat.png',
  author: 'Petko Bordjukov',
  emoticon_file: File.join('emoticon-list', 'emoticons.json'),
  source_url: 'https://dujrsrsgsd3nh.cloudfront.net/img/emoticons/'
}

desc 'Create the theme manifest file'
task :manifest do
  manifest = HipChat::Manifest.new options
  manifest.emoticons = HipChat::Helpers.emoticons_from options[:emoticon_file]
  HipChat::Helpers.open_file('theme') { |f| f.write manifest.to_s }
end

desc 'Download the emoticons'
task :images do
  HipChat::Helpers.emoticons_from(options[:emoticon_file]).each do |emoticon|
    print "Downloading #{emoticon.image}... "
    open(File.join options[:source_url], emoticon.image) do |source|
      HipChat::Helpers.open_file(emoticon.image) { |f| f.write source.read }
    end
    puts 'Done.'
  end
end

desc 'Create the theme archive'
task archive: [:manifest, :images] do
  `tar -czf HipChat.tar.gz HipChat`
end

desc 'Clean up'
task :clean do
  FileUtils.rm_rf 'HipChat'
  FileUtils.rm 'HipChat.tar.gz'
end

task default: 'archive'
