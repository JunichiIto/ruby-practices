# frozen_string_literal: true

require_relative 'params'
require_relative 'models/ls_file'
require_relative 'views/short_format'
require_relative 'views/long_format'

class LsApp
  def main(argv = ARGV)
    params = Params.new(argv)
    ls_files = LsFile.all(params)
    if params.long_format?
      puts LongFormat.new(ls_files).render
    else
      puts ShortFormat.new(ls_files).render
    end
  end
end
