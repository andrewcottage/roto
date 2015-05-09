require "minitest/autorun"
require "./lib/roto.rb"

class TestRoto < Minitest::Test
  def setup
    @roto = Roto.new
    @path = "#{Dir.pwd}/test/fixtures"
  end
  def test_that_finder_can_find_jpgs    
    filetypes=['jpg']
    photos = @roto.find_photos(@path, filetypes)
    assert_equal ["#{@path}/test.jpg"], photos
  end

  def test_that_finder_can_find_pngs
    filetypes=['png']
    photos = @roto.find_photos(@path, filetypes)
    assert_equal ["#{@path}/test.png"], photos
  end

  def test_that_finder_can_find_mp4s
    filetypes=['mp4']
    photos = @roto.find_photos(@path, filetypes)
    assert_equal ["#{@path}/test.mp4"], photos
  end

  def test_that_finder_can_find_mutiple_filetypes
    filetypes=['mp4', 'jpg', 'png']
    photos = @roto.find_photos(@path, filetypes)
    assert_equal ["#{@path}/test.mp4", "#{@path}/test.jpg", "#{@path}/test.png"], photos
  end


  def test_that_mover_can_move
  end

  def test_that_duplicates_are_reconciled
  end
end
