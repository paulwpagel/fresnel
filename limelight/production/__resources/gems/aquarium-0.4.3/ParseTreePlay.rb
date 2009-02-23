require 'rubygems'
require 'parse_tree'

class Foo
  attr_accessor :name
  def intialize name
    @name = name
  end
end

p ParseTree.new.parse_tree(Foo)

class Bar
  attr_accessor :name
  def initialize name
    @name = name
  end
  def attrset x
    p "calling attrset for #{x}"
    super
  end
end

b=Bar.new "name"
b.name = "name2"
