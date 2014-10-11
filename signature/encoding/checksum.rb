require_relative '../../helper'

class Checksum

  def initialize(path)
    @path = path
  end

  def get
    FileIO.read_file @path
  end

end
