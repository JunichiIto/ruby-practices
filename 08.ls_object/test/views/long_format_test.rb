# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/controllers/params'
require_relative '../../lib/models/ls_file'
require_relative '../../lib/views/long_format'

module Views
  class LongFormatTest < Minitest::Test
    def ls_files
      directory = Pathname.new(__dir__).join('../fixtures')
      params = Controllers::Params.new(['-a', directory])
      Models::LsFile.all(params)
    end

    def test_render
      expected = <<~TEXT.chomp
        total 96
        drwxr-xr-x  16 jnito  staff   512 Apr 28 11:09 .
        drwxr-xr-x   5 jnito  staff   160 Apr 28 13:05 ..
        -rw-r--r--   1 jnito  staff  6148 Apr 28 11:08 .DS_Store
        -rw-r--r--   1 jnito  staff   740 Mar 20 17:45 application.rb
        -rw-r--r--   1 jnito  staff   207 Mar 20 17:45 boot.rb
        -rw-r--r--   1 jnito  staff   193 Mar 20 17:45 cable.yml
        -rw-r--r--   1 jnito  staff   464 Mar 20 17:45 credentials.yml.enc
        -rw-r--r--   1 jnito  staff   620 Mar 20 17:45 database.yml
        -rw-r--r--   1 jnito  staff   128 Mar 20 17:45 environment.rb
        drwxr-xr-x   5 jnito  staff   160 Mar 20 17:45 environments
        -rw-r--r--   1 jnito  staff   381 Apr 10 07:35 importmap.rb
        drwxr-xr-x   9 jnito  staff   288 Mar 20 17:45 initializers
        drwxr-xr-x   5 jnito  staff   160 Mar 20 17:45 locales
        -rw-r--r--   1 jnito  staff  1792 Mar 20 17:45 puma.rb
        -rw-r--r--   1 jnito  staff   322 Mar 20 17:45 routes.rb
        -rw-r--r--   1 jnito  staff  1152 Mar 20 17:45 storage.yml
      TEXT
      assert_equal expected, LongFormat.new(ls_files).render
    end
  end
end
