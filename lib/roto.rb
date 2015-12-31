require 'fileutils'
require 'find'
require 'ruby-progressbar'

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
        puts "collected #{@files.count} files"
      end
    end
  end

  def move_files(destination)
    progressbar = ProgressBar.create(total: @files.count)
  	@files.each do |file|
			FileUtils.mv("#{file}", "#{destination}")
      progressbar.increment
		end
  end

  def copy_files(destination)
    progressbar = ProgressBar.create(total: @files.count)
    @files.each do |file|
			FileUtils.cp("#{file}", "#{destination}")
      progressbar.increment
		end
  end
end
