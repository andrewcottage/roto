Gem::Specification.new do |s|
  s.name        = 'roto'
  s.version     = '0.1.8'
  s.date        = '2015-12-30'
  s.summary     = "Roto the Ruby Photo Finder!"
  s.description = "A gem to find and move photos on your computer"
  s.authors     = ["Andrew Cottage"]
  s.email       = 'andcott@Gmail.com'
  s.files       = ["lib/roto.rb"]
  s.homepage    = 'https://github.com/andrewcottage/roto'
  s.license       = 'MIT'
  s.executables << 'roto'
  s.add_runtime_dependency 'ruby-progressbar'
end
