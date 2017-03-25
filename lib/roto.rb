require 'fileutils'
require 'find'
require 'ruby-progressbar'

class Roto
  attr_accessor :types, :files, :rename_duplicates
  attr_reader :files, :errors

  def initialize
    @files = []
    @types = ['.mp4', '.mov', '.jpg', '.png', '.mts']
    @rename_duplicates = true
    @errors = {}
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
      filename = File.basename(file)
      ext = File.extname(file)
      name = File.basename(file, ext)
      begin
        if File.exist?("#{destination}/#{filename}") && @rename_duplicates
          FileUtils.mv("#{file}", "#{destination}/#{name}_#{Time.now.to_i}#{ext}")  
        end
        progressbar.increment
      rescue => error
        @errors[file] = error
      end
    end
  end

  def copy_files(destination)
    progressbar = ProgressBar.create(total: @files.count, format: '%w')
    @files.each do |file|
      filename = File.basename(file)
      ext = File.extname(file)
      name = File.basename(file, ext)
      begin
        if File.exist?("#{destination}/#{filename}") && @rename_duplicates
          FileUtils.cp("#{file}", "#{destination}/#{name}_#{Time.now.to_i}#{ext}")    
        end
        progressbar.increment
      rescue => error
        @errors[file] = error
      end
    end
  end
end
