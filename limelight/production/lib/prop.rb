module Limelight
  class Prop
    def show_spinner(&block)
      spinner = Limelight::Prop.new(:name => "modal_base", :id => "spinner")
      spinner.add(Limelight::Prop.new(:name => "spinner_message", :text => "Loading..."))
      scene.add(spinner) unless scene.find("spinner")
      yield
      spinner = scene.find("spinner")
      scene.remove(spinner) if scene.stage && scene.stage.current_scene == scene
    end

  end
end