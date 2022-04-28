require_relative 'params'
require_relative 'ls_file'
require_relative 'views/short_format'
require_relative 'views/long_format'

class Ls
  def main
    params = Params.new(ARGV)
    ls_files = LsFile.all(params)
    if params.long_format?
      puts Views::LongFormat.new(ls_files).format
    else
      puts Views::ShortFormat.new(ls_files).format
    end
  end
end

Ls.new.main
