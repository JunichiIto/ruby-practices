# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/models/ls_file'
require_relative '../../lib/views/short_format'

class ShortFormatTest < Minitest::Test
  def test_render
    expected = <<~TEXT.chomp
      aa.txt c.txt  e.txt
      b.txt  d.txt
    TEXT
    ls_files = ('b'..'e').map do |name|
      LsFile.new("#{name}.txt")
    end
    ls_files = [LsFile.new('aa.txt'), *ls_files]
    assert_equal expected, ShortFormat.new(ls_files).render
  end
end
