require 'fileutils'
require 'find'

class Roto
  attr_reader :files
  attr_accessor :types
  def initialize
    @files = []
    @types = ['.mp4', '.jpg', '.png']
  end

  def find_files(path)
    Find.find(path).each do |file|
      if @types.include?(File.extname(file).downcase)
        @files << file
      end
    end
  end

  def move_files(destination)
  	@files.each do |file|
			FileUtils.mv("#{file}", "#{destination}")
		end
  end

  def copy_files(destination)
    @files.each do |file|
			FileUtils.cp("#{file}", "#{destination}")
      puts "on file #{@files.index(file) + 1} of #{files.count}"
		end
  end
end
