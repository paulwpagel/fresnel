require "limelight/prop"

module Limelight
  class Prop
    def show_spinner(&block)
      spinner = Limelight::Prop.new(:name => "spinner", :id => "spinner")
      spinner.add(Limelight::Prop.new(:name => "spinner_message", :text => "Loading..."))
      scene.add(spinner) unless scene.find("spinner")
      yield
      spinner = scene.find("spinner")
      scene.remove(spinner) if production.producer.theater['default'].current_scene == scene
    end
  end
end