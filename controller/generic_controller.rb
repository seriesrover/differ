require_relative '../helper'

class GenericController

  def initialize
  end

  def run
    walk = Walk.new self
    walk.run $options.input_directory
  end

  def invoke_directory(directory)
    verbose( {:directory => directory} )

    @serializer = SerializeBinary.new directory
  end

  def invoke_file(path)
    verbose( {:file => path} )

    signature = Signature.new path
    signature.invoke

    @serializer.append_signature signature
  end

  def invoke_delete_data_file(directory)
    verbose( {:error_file => directory} )

    @serializer.delete_signature_file 
  end

  def verbose(data)
    @verbose ||= Verbose.new
    @verbose.write(data) if @verbose
  end

end
