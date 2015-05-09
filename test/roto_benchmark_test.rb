require "minitest/autorun"
require "minitest/benchmark" #if ENV["BENCH"]
require './lib/roto.rb'

class TestMeme < Minitest::Benchmark
	 def setup
    @roto = Roto.new
    @path = "#{Dir.pwd}/test/fixtures"
  end

	def bench_finding_one_file
    assert_performance_linear 0.0898113483151454 do |n| # n is a range value8
      photos = @roto.find_photos(@path, ['jpg'])
    end
  end
end