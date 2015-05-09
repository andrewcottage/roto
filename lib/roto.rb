require 'fileutils'

class Roto
  def intialize
  end

  def find_photos(path, types=[])
    puts path
    puts types
    files = []
    types.each do |type|
      files << Dir.glob("#{path}/**/*.#{type}")
    end
    return files.flatten
  end
end
