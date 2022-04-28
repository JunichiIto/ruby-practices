require 'optparse'

class Params
  def initialize(argv)
    opt = OptionParser.new

    @params = {}
    opt.on('-a') { @params[:a] = true }
    opt.on('-l') { @params[:l] = true }
    opt.on('-r') { @params[:r] = true }

    paths = opt.parse!(argv)
    @target_directory = paths[0]
  end

  def dot_match?
    !!@params[:a]
  end

  def reverse?
    !!@params[:r]
  end

  def long_format?
    !!@params[:l]
  end

  def target_directory
    @target_directory || Dir.getwd
  end
end
