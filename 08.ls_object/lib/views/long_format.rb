# frozen_string_literal: true

module Views
  class LongFormat
    FILE_TYPE_TABLE = {
      'file' => '-',
      'directory' => 'd'
    }.freeze

    PERMISSION_TABLE = {
      '1' => '--x',
      '2' => '-w-',
      '3' => '-wx',
      '4' => 'r--',
      '5' => 'r-x',
      '6' => 'rw-',
      '7' => 'rwx'
    }.freeze

    def initialize(ls_files)
      @ls_files = ls_files
    end

    def format
      total = @ls_files.sum(&:block_size)
      header = "total #{total}"
      widths = calc_widths
      body = @ls_files.map do |ls_file|
        columns = []
        columns << "#{format_mode(ls_file)} "
        columns << ls_file.link_count.to_s.rjust(widths[:link_count])
        columns << "#{ls_file.owner_name.ljust(widths[:owner_name])} "
        columns << "#{ls_file.group_name.ljust(widths[:group_name])} "
        columns << ls_file.bytesize.to_s.rjust(widths[:bytesize])
        columns << ls_file.mtime.strftime('%b %d %H:%M')
        columns << ls_file.name
        columns.join(' ')
      end
      [header, *body].join("\n")
    end

    private

    def format_mode(ls_file)
      file_type = FILE_TYPE_TABLE[ls_file.file_type]
      permission = ls_file.permission.each_char.map { |c| PERMISSION_TABLE[c] }.join
      file_type + permission
    end

    def calc_widths
      widths = Hash.new { |h, k| h[k] = [] }
      @ls_files.each do |ls_file|
        widths[:link_count] << ls_file.link_count.to_s.size
        widths[:owner_name] << ls_file.owner_name.size
        widths[:group_name] << ls_file.group_name.size
        widths[:bytesize] << ls_file.bytesize.to_s.size
      end
      widths.transform_values(&:max)
    end
  end
end
