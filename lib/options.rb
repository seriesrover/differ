require_relative '../helper'

class Options
  INPUT_DIRECTORY = './'.freeze
  OUTPUT_DIRECTORY = './.diff'.freeze

  def initialize
    @options = {}

    @opt_parser = OptionParser.new do |opt|
      opt.banner = "Usage: diff [options]"
      opt.separator  ""
      opt.separator  "Options"

      @options[:verbose] = :none
      opt.on("-v", "--verbose none,diff,all,directory,file", "Verbose output") do |verbose|
        @options[:verbose] = verbose.to_sym
      end

      @options[:byte_repeat] = false
      opt.on("-e", "--repeat BYTE_REPEAT", "Byte Repeat") do |byte_repeat|
        @options[:byte_repeat] = byte_repeat
      end

      @options[:properties] = true
      opt.on("-l", "--properties PROPERTIES", "Properties") do |properties|
        @options[:properties] = properties
      end

      @options[:header] = false
      opt.on("-l", "--header HEADER", "Header") do |header|
        @options[:header] = header
      end

      @options[:metadata] = false
      opt.on("-l", "--metadata METADATA", "Metadata") do |metadata|
        @options[:metadata] = metadata
      end

      @options[:checksum] = true
      opt.on("-l", "--checksum CHECKSUM", "Checksum") do |checksum|
        @options[:checksum] = checksum
      end

      @options[:input_dir] = INPUT_DIRECTORY
      opt.on("-l", "--input DIRECTORY", "Input directory") do |input_dir|
        @options[:input_dir] = input_dir
      end
      @options[:input_dir] = File.expand_path @options[:input_dir]

      @options[:output_dir] = OUTPUT_DIRECTORY
      opt.on("-l", "--output DIRECTORY", "Output directory") do |output_dir|
        @options[:output_dir] = output_dir
      end
      @options[:output_dir] = File.expand_path @options[:output_dir]

      opt.on("-h", "--help", "help") do
        puts opt_parser
        exit
      end
    end
  end

  def parse
    return unless @opt_parser
    @opt_parser.parse!
  end

  def verbose
    @options[:verbose]
  end

  def properties?
    @options[:properties]
  end

  def header?
    @options[:header]
  end

  def metadata?
    @options[:metadata]
  end

  def checksum?
    @options[:checksum]
  end

  def input_directory
    @options[:input_dir]
  end

  def output_directory
    @options[:output_dir]
  end

end
