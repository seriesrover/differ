require_relative 'helper'

class App

  def self.run
    $options = Options.new
    $options.parse

    generic_controller = GenericController.new
    generic_controller.run
  end

end
