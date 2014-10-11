require_relative '../helper'

class SerializeBinary
  SIGNATURE_FILE = '.diff_data'.freeze

  def initialize(directory)
    @directory = directory

    @output_directory = directory.gsub($options.input_directory, $options.output_directory)
    @signature_path = File.join @output_directory, SIGNATURE_FILE
    
    FileIO.mkdir @output_directory
  end

  def load(path)
    @data || @data = Marshal::load(File.open(@signature_path), "rb")
  end

  def append_signature(signature)
    File.open(@signature_path, "ab") do |file|
      Marshal.dump(signature, file) == nil
    end
  end

  def delete_signature_file
    FileIO.delete @signature_path
  end

end
