[![Gem Version](https://badge.fury.io/rb/roto.svg)](https://badge.fury.io/rb/roto)
[![CircleCI](https://circleci.com/gh/andrewcottage/roto.svg?style=svg)](https://circleci.com/gh/andrewcottage/roto)
# Roto
Roto the ruby photo finder


Roto is an easy way to find and move all of the photos on your computer, while segregading duplicates and organizing them into
a clean readable folder structure that allows you to take control your photos


Installation

```ruby
gem 'roto'
```
or
```ruby
gem install roto
```
Examples

- Find Files and copy them
```
roto = Roto.new
path = "some/path/with/photos
roto.find_files(path)

new_path = "some/new/path/for/photos"
roto.copy_photos(new_path)
```

 Or move photos permanently (use caution)
```ruby
 roto.move_photos(new_path)
```

It will rename duplicates by default, but to change this behavior do
```ruby
roto = Roto.new
roto.rename_duplicates = false
```

Roto also ships as an executable. Simply do
```
roto copy path/to/source/directory path/to/destination/directory
```
