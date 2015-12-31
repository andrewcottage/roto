require 'fileutils'
require 'find'

class Roto
  attr_reader :files
  attr_accessor :types
  def initialize
    @files = []
    @types = ['.mp4', '.jpg', '.png']
  end

  def uniq_files_only
    @types.uniq!
  end

  def find_files(path)
    @types.each do |type|
      Find.find(path).each do |file|
        if @types.include?(File.extname(file))
          @files << file
        end
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
		end
  end
end
