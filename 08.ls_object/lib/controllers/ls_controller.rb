# frozen_string_literal: true

require_relative 'params'
require_relative '../models/ls_file'
require_relative '../views/short_format'
require_relative '../views/long_format'

module Controllers
  class LsController
    def main
      params = Params.new(ARGV)
      ls_files = Models::LsFile.all(params)
      if params.long_format?
        puts Views::LongFormat.new(ls_files).format
      else
        puts Views::ShortFormat.new(ls_files).format
      end
    end
  end
end
