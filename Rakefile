require 'open-uri'
require 'fileutils'
require_relative 'lib/emoticon_list'
require_relative 'lib/emoticon'
require_relative 'lib/manifest'
require_relative 'lib/helpers'

desc 'Download the emoticons'
task :fetch do
  emoticons = HipChat::FullEmoticonList.new

  manifest = HipChat::Manifest.new emoticons
  HipChat::Helpers.open_file('theme') { |f| f.write manifest.to_s }

  emoticons.each do |emoticon|
    print "Downloading #{emoticon.file_name}... "
    emoticon.fetch!
    puts 'Done.'
  end

  HipChat::Helpers.open_file('fetched_at') { |f| f.write Marshal.dump DateTime.now }
end

desc 'Create the theme archive'
task archive: [:fetch] do
  date = Marshal.load open(File.join('HipChat', 'fetched_at')).read
  `tar -czf HipChat-#{date.strftime('%Y%m%d%H%M%S')}.tar.gz HipChat`
end

desc 'Clean up'
task :clean do
  FileUtils.rm_rf 'HipChat'
  FileUtils.rm Dir.glob 'HipChat*.tar.gz'
end

task default: 'archive'
