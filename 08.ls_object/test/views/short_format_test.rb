require 'minitest/autorun'
require_relative '../../lib/models/ls_file'
require_relative '../../lib/views/short_format'

module Views
  class ShortFormatTest < Minitest::Test
    def test_format
      expected = <<~TEXT.chomp
        aa.txt c.txt  e.txt
        b.txt  d.txt
      TEXT
      ls_files = ('b'..'e').map do |name|
        Models::LsFile.new("#{name}.txt")
      end
      ls_files = [Models::LsFile.new('aa.txt'), *ls_files]
      assert_equal expected, ShortFormat.new(ls_files).format
    end
  end
end
