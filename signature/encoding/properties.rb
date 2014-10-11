require_relative '../../helper'

class Properties

  def initialize(path)
    @properties = FileIO.properties path
  end

 def get_size
   @properties[:size]
 end

 def get_creation_time
   @properties[:ctime]
 end

 def get_modification_time
   @properties[:mtime]
 end

end
