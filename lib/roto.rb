require 'fileutils'
require 'find'
require 'ruby-progressbar'

class Roto
  attr_accessor :types, :files
  def initialize
    @files = []
    @types = ['.mp4', '.mov', '.jpg', '.png']
  end

  def find_files(path)
    progressbar = ProgressBar.create(:total => nil, :unknown_progress_animation_steps => ['==>', '>==', '=>='])
    Find.find(path).each do |file|
      if @types.include?(File.extname(file).downcase)
        @files << file
        progressbar.increment
      end
    end
  end

  def move_files(destination)
    progressbar = ProgressBar.create(total: @files.count, format: '%w')
  	@files.each do |file|
			FileUtils.mv("#{file}", "#{destination}")
      progressbar.increment
		end
  end

  def copy_files(destination)
    progressbar = ProgressBar.create(total: @files.count, format: '%w')
    @files.each do |file|
			FileUtils.cp("#{file}", "#{destination}")
      progressbar.increment
		end
  end
end
