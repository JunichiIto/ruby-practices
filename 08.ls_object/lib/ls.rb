require_relative 'params'
require_relative 'ls_file'

class Ls
  def main
    params = Params.new(ARGV)
    @ls_files = LsFile.all(params)
    puts @ls_files
    # ファイルの一覧をviewに渡す
    # if params.long_format?
    #   render 'long'
    # else
    #   render 'short'
    # end
  end
end

Ls.new.main
