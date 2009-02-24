require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require "spinner"


describe Spinner do  
  
  it  "should call class eval on the source object" do
    class TestSpinner
      include Spinner
      def self.use_spinner(spinner_method_name)
        Spinner.spins_on(spinner_method_name)
      end
    end
    
    TestSpinner.should_receive(:class_eval).with(Spinner.extended_method_definition([:some_method]))
    TestSpinner.use_spinner(:some_method)
  end
  
end


describe Spinner do
  it "should alias the old method" do
    Spinner.extended_method_definition([:some_method]).should match(/alias :some_method_old :some_method/)
  end
  
  it "should define multiple wrapper methods" do
    method_definition = Spinner.extended_method_definition([:some_method, :another_method])
    method_definition.should match(/alias :some_method_old :some_method/)
    method_definition.should match(/alias :another_method_old :another_method/)
  end
  
  it "should define the new method" do
    Spinner.wrapper_method_definition(:some_method).should match(/def some_method/)
  end
  
  it "should call the old method on spinner_method_definition" do
    Spinner.wrapper_method_definition(:some_method).should match(/some_method_old/)
  end
  
  
end