require 'open3'

class Mystem
  BIN = Rails.root.join('bin/mystem')
  DEFAULT_PARAMS = '-n -l -e utf8'

  class << self

    def clean(text)
      exec = [BIN, DEFAULT_PARAMS].join(' ')

      words = Open3.popen3(exec) do |stdin, stdout, _|
        stdin.write text
        stdin.close
        stdout.read
      end

      words = words.split(/\n/)
    end

    def parts_of_speach(text)
      exec = [BIN, DEFAULT_PARAMS, '-g -i'].join(' ')

      words = Open3.popen3(exec) do |stdin, stdout, _|
        stdin.write text
        stdin.close
        stdout.read
      end

      words = words.scan(/^([^=]+?)=([A-Z]+?)/).group_by { |m| m[1] }
      words.symbolize_keys
    end
  end
end
