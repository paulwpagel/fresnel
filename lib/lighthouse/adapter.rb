if $adapter == "net"
  require File.expand_path(File.dirname(__FILE__) + "/../../vendor/lighthouse-api/lib/lighthouse")
else
  require "lighthouse/lighthouse"
end