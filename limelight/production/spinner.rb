module Spinner
  
  def self.included(source)
    @source_object = source
  end
  
  def self.spins_on(*spinner_method_names)
    @source_object.class_eval extended_method_definition(spinner_method_names) 
  end
  
  def self.extended_method_definition(spinner_method_names)
    extended_method = <<END
      def self.extended(source)
        #{wrapper_alias_and_definitions(spinner_method_names)}
    end
END
    return extended_method

  end
  
  
  def self.wrapper_alias_and_definitions(spinner_method_names)
    all_methods = ""
    spinner_method_names.each do |spinner_method_name|
      a_method_rename = <<END
alias :#{spinner_method_name.to_s}_old :#{spinner_method_name.to_s}
#{wrapper_method_definition(spinner_method_name)}
source.class_eval method
END
      all_methods << a_method_rename
    end
    return all_methods
  end
  
  def self.wrapper_method_definition(spinner_method_name)
    definition = <<END
    method = <<CONTENT
def #{spinner_method_name.to_s}(event)
  spinner = Limelight::Prop.new(:name => "spinner", :id => "spinner")
  spinner.add(Limelight::Prop.new(:name => "spinner_message", :text => "Loading..."))
  scene.add(spinner) unless scene.find("spinner")
  return_val = #{spinner_method_name.to_s}_old(event)
  scene.remove(scene.find("spinner")) if scene.find("spinner")
  return return_val
end
CONTENT
END
    return definition
  end

end