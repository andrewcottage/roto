require 'fileutils'
require 'find'
require 'ruby-progressbar'
require 'logger'

class Roto
  attr_accessor :types, :files, :rename_duplicates
  attr_reader :errors

  def initialize
    @files = []
    @types = ['.mp4', '.mov', '.jpg', '.png', '.mts']
    @rename_duplicates = true
    @errors = {}
    @logger = Logger.new(STDOUT)
  end

  def find_files(path)
    progressbar = ProgressBar.create(total: nil, format: "%a Finding Files")
    Find.find(path).each do |file|
      if @types.include?(File.extname(file).downcase)
        @files << file
        progressbar.increment
      end
    end
    @logger.info("Found: #{@files.count} files")
  end

  def move_files(destination)
    progressbar = ProgressBar.create(total: @files.count, format: '%a %B %p%% %t')
  	@files.each do |file|
      filename = File.basename(file)
      ext = File.extname(file)
      name = File.basename(file, ext)
      begin
        if File.exist?("#{destination}/#{filename}") && @rename_duplicates
          FileUtils.mv("#{file}", "#{destination}/#{name}_#{Time.now.to_i}#{ext}")
        else
          FileUtils.mv("#{file}", "#{destination}")
        end
        progressbar.increment
      rescue => error
        @errors[file] = error
      end
    end
    self
  end

  def copy_files(destination)
    progressbar = ProgressBar.create(total: @files.count, format: '%a %B %p%% %t')
    @files.each do |file|
      filename = File.basename(file)
      ext = File.extname(file)
      name = File.basename(file, ext)
      begin
        if File.exist?("#{destination}/#{filename}") && @rename_duplicates
          FileUtils.cp("#{file}", "#{destination}/#{name}_#{Time.now.to_i}#{ext}")
        else
          FileUtils.cp("#{file}", "#{destination}")
        end
        progressbar.increment
      rescue => error
        @errors[file] = error
      end
    end
  end
  self
end
