
# New DSL ideas.
Aspect.new {
  after
  pointcut {
    within_context_of named_pointcuts {
      matching /^STATE/
      within_types_and_descendents /Foo|Bar/
    } and not_within_context_of pointcuts {
      calls_from /callback$/
      in_types_and_descendents_of /Active/
    } and pointcut {
      pointcut {
        calls_to /index/
        in_types_and_ancestors_of [String, Fixnum]
      } or pointcut {
        calls_to /outdex/
        in_types_and_ancestors_of /^Foo/
      }    
    }
  }
  invoke_advice do |join_point, object, *args|
    p join_point.inspect
  end
}

Aspect.new {
  after
  pointcut {
    within_context_of {
      pointcuts_named /^STATE/
      within_types_and_descendents /Foo|Bar/
    } and not within_context_of {
      calls_to /_handle$/
      in_types_and_descendents_of /Active/
    } and pointcut {
      pointcut {
        calls_to /index/
        in_types_and_ancestors_of [String, Fixnum]
      } or pointcut {
        calls_to /outdex/
        in_types_and_ancestors_of /^Foo/
      }    
    }
  }
  invoke_advice do |join_point, object, *args|
    p join_point.inspect
  end
}

Aspect.new {
  after {
    calls_to /index/
    in_types_and_ancestors_of [String, Fixnum]
  } or after {
    calls_to /outdex/
    in_types_and_ancestors_of /^Foo/
  } within_context_of {
    pointcuts_named /^STATE/
    within_types_and_descendents /Foo|Bar/
  } and not within_context_of {
      calls_to /_handle$/
      in_types_and_descendents_of /Active/
    } and pointcut {
      pointcut {
        calls_to /index/
        in_types_and_ancestors_of [String, Fixnum]
      } or pointcut {
        calls_to /outdex/
        in_types_and_ancestors_of /^Foo/
      }    
    }
  }
  invoke_advice do |join_point, object, *args|
    p join_point.inspect
  end
}

Aspect.new {
  after
  pointcut {
    within named_pointcuts {
      matching /^STATE/
      within_types_and_descendents /Foo|Bar/
    } 
    not_within pointcuts {
      calls_from /callback$/
      in_types_and_descendents_of /Active/
    } 
    pointcut {
      calls_to /index/
      in_types_and_ancestors_of [String, Fixnum]
    } 
    pointcut {
      calls_to /outdex/
      in_types_and_ancestors_of /^Foo/
    }
  }
  invoke_advice do |join_point, object, *args|
    p join_point.inspect
  end
}

Aspect.new {
  after
  pointcut {
    within named_pointcuts {
      matching /^STATE/
      within_types_and_descendents /Foo|Bar/
    }.and_not_within pointcuts {
      calls_from /callback$/
      in_types_and_descendents_of /Active/
    } {
      pointcut {
        calls_to /index/
        in_types_and_ancestors_of [String, Fixnum]
      } 
      pointcut {
        calls_to /outdex/
        in_types_and_ancestors_of /^Foo/
      }
    }
  }
  invoke_advice do |join_point, object, *args|
    p join_point.inspect
  end
}

Aspect.new {
  after
  pointcut {
    within {
      named_pointcuts {
        matching /^STATE/
        within_types_and_descendents /Foo|Bar/
      } 
      exclude_pointcuts {
        calls_from /callback$/
        in_types_and_descendents_of /Active/
      }
    } 
    pointcut {
      calls_to /index/
      in_types_and_ancestors_of [String, Fixnum]
    } 
    pointcut {
      calls_to /outdex/
      in_types_and_ancestors_of /^Foo/
    }
  }
  invoke_advice do |join_point, object, *args|
    p join_point.inspect
  end
}



after :named_pointcuts => { :matching => /^STATE/, :within_types_and_descendents => /Foo|Bar/ } do ... end
after :named_pointcuts => { :with_names_matching => /^STATE/, :within_types_and_descendents => /Foo|Bar/ } do ... end
after :named_pointcuts => { :named => /^STATE/, :within_types_and_descendents => /Foo|Bar/ } do ... end

after :named_pointcuts => { :constants_matching => /^STATE/, :within_types_and_descendents => /Foo|Bar/ } do ... end
after :named_pointcuts => { :constants_with_names_matching => /^STATE/, :within_types_and_descendents => /Foo|Bar/ } do ... end
after :named_pointcuts => { :constants_named => /^STATE/, :within_types_and_descendents => /Foo|Bar/ } do ... end

after :named_pointcuts => { :class_variables_matching => /^STATE/, :within_types_and_descendents => /Foo|Bar/ } do ... end
after :named_pointcuts => { :class_variables_with_names_matching => /^STATE/, :within_types_and_descendents => /Foo|Bar/ } do ... end
after :named_pointcuts => { :class_variables_named => /^STATE/, :within_types_and_descendents => /Foo|Bar/ } do ... end

after :constant_pointcuts => { :matching => /^STATE/, :within_types_and_descendents => /Foo|Bar/ } do ... end
after :class_variable_pointcuts => { :matching => /^state/, :within_types_and_descendents => /Foo|Bar/ } do ... end
  
regex=  /(constants_|instance_variables_|class_variables_)?(with_)?(named_matching|named|matching)/
after :pointcuts => { :named => /^STATE/, :within_types_and_descendents => /Foo|Bar/ } do ... end
after :pointcuts => { :constants_named => /^STATE/, :within_types_and_descendents => /Foo|Bar/ } do ... end
after :pointcuts => { :class_variables_named => /^state/, :within_types_and_descendents => /Foo|Bar/ } do ... end
after :pointcuts => { :instance_variables_named => /^state/, :within_types_and_descendents => /Foo|Bar/ } do ... end

after :named_pointcuts => { :matching => /^STATE/, :within_types_and_descendents => /Foo|Bar/ } do ... end
after :named_pointcuts => { :matching => 'STATE_CHANGE', :within_types_and_descendents => /Foo|Bar/ } do ... end
after :constant_pointcuts => { :matching => /^STATE/, :within_types_and_descendents => /Foo|Bar/ } do ... end
after :class_variables_pointcuts => { :matching => /^state/, :within_types_and_descendents => /Foo|Bar/ } do ... end
after :instance_variables_pointcuts => { :matching => /^state/, :within_types_and_descendents => /Foo|Bar/ } do ... end

after :pointcuts_matching => { :constants_named => /^STATE/, :within_types_and_ancestors => /Foo|Bar/ }
after :pointcuts_matching => { :class_variables_named => /^STATE/, :within_types_and_ancestors => /Foo|Bar/ }
