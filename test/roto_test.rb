require "minitest/autorun"
require_relative "../lib/roto.rb"

class TestRoto < Minitest::Test
  def setup
    @roto = Roto.new
  end
  def test_that_finder_can_find
    photos = @roto.find('./fixtures', filetypes=['jpg'])
    assert_equal ['test.jpg'], photos
  end

  def test_that_mover_can_move
  end

  def test_that_duplicates_are_reconciled
  end
end
