require_relative '../helper'

class Verbose

  def initialize
    @verbose_line_count = 1
  end

  def write(data)
    if $options.verbose == :all || $options.verbose == :directory
      if data[:directory]
        puts "#{@verbose_line_count}: #{data[:directory]}"
        inc_counter
      end
    end

    if $options.verbose == :all || $options.verbose == :file
      if data[:file]
        puts "#{@verbose_line_count}: #{data[:file]}"
        inc_counter
      end
    end
  end

  private

  def inc_counter
    @verbose_line_count += 1
  end

end
