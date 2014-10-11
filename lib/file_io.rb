require_relative '../helper'

module FileIO

  def self.properties(path)
      properties = Hash.new
      properties[:size] = File.stat(path).size
      properties[:ctime] = File.stat(path).ctime
      properties[:mtime] = File.stat(path).mtime
      properties
  end

  def self.read_file(path)
    begin
      File.open(path, "rb").sysread(File::stat(path).size)
    rescue Errno::EINVAL
      ""
    end
  end

  def self.mkdir(directory)
    FileUtils.rm_rf directory
    Dir.mkdir directory
  end

  def self.delete(path)
    FileUtils.rm_rf path
  end

end
