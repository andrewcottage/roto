require "minitest/autorun"
require "./lib/roto.rb"

class TestRoto < Minitest::Test
  def setup
    @roto = Roto.new
    @fixtures_path = "./test/fixtures"
    @moved_files_path = "./test/moved_files"
    @copied_files_path = "./test/copied_files"
    @duplicates_path = "./test/duplicates"
    FileUtils.touch("#{@fixtures_path}/test.jpg")
    FileUtils.touch("#{@fixtures_path}/test.png")
    FileUtils.touch("#{@fixtures_path}/test.mp4")
    @filetypes = ['mp4', 'jpg', 'png']
  end

  def teardown
    FileUtils.rm_rf("#{@moved_files_path}/.")
    FileUtils.rm_rf("#{@copied_files_path}/.")
    FileUtils.rm_rf("#{@duplicates_path}/.")
  end

  def test_that_finder_can_find_jpgs
    filetypes=['jpg']
    photos = @roto.find_files(@fixtures_path)
    assert_equal ["#{@fixtures_path}/test.jpg"], photos
  end

  def test_that_finder_can_find_pngs
    filetypes=['png']
    photos = @roto.find_files(@fixtures_path)
    assert_equal ["#{@fixtures_path}/test.png"], photos
  end

  def test_that_finder_can_find_mp4s
    filetypes=['mp4']
    photos = @roto.find_files(@fixtures_path)
    assert_equal ["#{@fixtures_path}/test.mp4"], photos
  end

  def test_that_finder_can_find_mutiple_filetypes
    filetypes=['mp4', 'jpg', 'png']
    photos = @roto.find_files(@fixtures_path)
    assert_equal ["#{@fixtures_path}/test.mp4", "#{@fixtures_path}/test.jpg", "#{@fixtures_path}/test.png"], photos
  end


  def test_that_mover_can_move
    files = @roto.find_files(@fixtures_path)
    @roto.move_files(files, @moved_files_path)
    assert_equal ["test.mp4", "test.jpg", "test.png"], @roto.find_files(@moved_files_path, @filetypes).map {|path| File.basename path}
  end

  def test_that_copier_can_copy
    files = @roto.find_files(@fixtures_path)
    @roto.copy_files(files, @moved_files_path)
    assert_equal ["test.mp4", "test.jpg", "test.png"], @roto.find_files(@moved_files_path, @filetypes).map {|path| File.basename path}
    assert_equal ["test.mp4", "test.jpg", "test.png"], @roto.find_files(@fixtures_path, @filetypes).map {|path| File.basename path}
  end

  def test_that_duplicates_are_renamed
    FileUtils.touch("#{@duplicates_path}/test.jpg")
    FileUtils.touch("#{@duplicates_path}/test.png")
    FileUtils.touch("#{@duplicates_path}/test.mp4")
    files = []
    files << @roto.find_files(@fixtures_path)
    files << @roto.find_files(@duplicates_path)
    @roto.copy_files(@moved_files_path)
    assert_equal ["test.mp4", "test.jpg", "test.png", "test_2.mp4", "test_2.jpg", "test_2.png"], @roto.find_files(@moved_files_path, @filetypes).map {|path| File.basename path}
  end
end
