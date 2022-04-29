# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/ls_app'

class LsAppTest < Minitest::Test
  def setup
    @directory = Pathname.new(__dir__).join('fixtures/config')
  end

  def test_long_format
    expected = <<~TEXT
      total 80
      drwxr-xr-x  15 jnito  staff   480 Apr 29 12:20 .
      drwxr-xr-x   4 jnito  staff   128 Apr 29 12:20 ..
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
    argv = ['-al', @directory]
    assert_output(expected) do
      LsApp.main(argv)
    end
  end

  def test_short_format_without_options
    expected = <<~TEXT
      application.rb      environment.rb      puma.rb
      boot.rb             environments        routes.rb
      cable.yml           importmap.rb        storage.yml
      credentials.yml.enc initializers
      database.yml        locales
    TEXT
    argv = [@directory]
    assert_output(expected) do
      LsApp.main(argv)
    end
  end

  def test_short_format_with_a_and_r_options
    expected = <<~TEXT
      storage.yml         importmap.rb        cable.yml
      routes.rb           environments        boot.rb
      puma.rb             environment.rb      application.rb
      locales             database.yml        ..
      initializers        credentials.yml.enc .
    TEXT
    argv = ['-ar', @directory]
    assert_output(expected) do
      LsApp.main(argv)
    end
  end

  def test_short_format_without_args
    expected = <<~TEXT
      Rakefile lib
      bin      test
    TEXT
    argv = []
    assert_output(expected) do
      LsApp.main(argv)
    end
  end
end
