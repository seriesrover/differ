require_relative '../helper'

class Walk
  include ::Retry

  def initialize(controller)
    @controller = controller
  end

  def is_dot_dotdot?(path)
    path == '.' || path == '..'
  end

  def contains_output_directory?(directory)
    directory.include? $options.output_directory
  end

  def run(directory)
    iterate_directory directory
  end

  private

  def iterate_directory(directory)
    iterate_through_files directory

    begin
      with_retry(3, :user_continue => true) do
        Dir.foreach directory do |subdirectory|
          next if is_dot_dotdot? subdirectory

          new_directory = File.join directory, subdirectory
          next unless File.directory? new_directory
          next if contains_output_directory? new_directory

          iterate_directory new_directory
        end
      end
    rescue
      puts "Exiting differ, directory: #{e.message}"
      exit
    end
  end

  def iterate_through_files(directory)
    begin
      invoke_directory directory

      with_retry(3, :user_continue => true) do
        invoke_delete_data_file directory

        Dir.foreach directory do |filename|
          next if is_dot_dotdot? filename

          path = File.join directory, filename
          next unless File.file? path

          invoke_file path
        end
      end
    rescue Exception => e
      puts "Exiting differ, files: #{e.message}"
      exit
    end
  end

  def invoke_directory(directory)
    @controller.invoke_directory directory
  end

  def invoke_file(path)
    @controller.invoke_file path
  end

  def invoke_delete_data_file(directory)
    @controller.invoke_delete_data_file directory
  end

end
