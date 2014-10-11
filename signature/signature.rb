require_relative '../helper'

class Signature

  def initialize(path)
    @version = SignatureHeader::VERSION
    @path = path
  end

  def invoke
    invoke_properties if $options.properties?

    @header ||= digest Header.new(@path).get if $options.header?
    @metadata ||= digest Metadata.new(@path).get if $options.metadata?
    @checksum ||= digest Checksum.new(@path).get if $options.checksum?

    @path = File.basename(@path)
  end

  private
  
  def invoke_properties
    properties = Properties.new(@path)

    @property_file_size = properties.get_size
    @property_file_created = properties.get_creation_time
    @property_file_modified = properties.get_modification_time
  end

  def digest(data)
    Digest::SHA2.hexdigest data if data
  end

end
