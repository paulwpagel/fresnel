module Production
  attr_accessor :stage_manager

  # Define this method if you want the production name to be different from the default, directory name.
  def name
    return "Fresnel"
  end

  # Hook #1.  Called when the production is newly created, before any loading has been done.
  # This is a good place to require needed files and instantiate objects in the business layer.
  def production_opening
    $: << File.expand_path(File.dirname(__FILE__) + "/list_tickets/players")
    $: << File.expand_path(File.dirname(__FILE__) + "/list_tickets/stagehands")
    $: << File.expand_path(File.dirname(__FILE__) + "/lib")
    $: << File.expand_path(File.dirname(__FILE__))
    $: << File.expand_path(File.dirname(__FILE__) + "/__resources/jars")
    require "OpenWebsite.jar"
    import "Browser"
    if ARGV[1] and ARGV[1].downcase == "memory"
      $adapter = "memory"
    else
      $adapter = "net"
    end
  end

  # Hook #2.  Called after internal gems have been loaded and stages have been instantiated, yet before
  # any scenes have been opened.
  def production_loaded
    require "lighthouse/adapter"
    require 'lighthouse/lighthouse_api/base' # do i need this
    require "stage_manager"
    @stage_manager = StageManager.new
    require "prop"
  end

  # Hook #3.  Called when the production, and all the scenes, have fully opened.
  def production_opened
  end

  # The system will call this methods when it wishes to close the production, perhaps when the user quits the
  # application.  By default the production will always return true. You may override this behavior by re-doing
  # the methods here.
  def allow_close?
    return true
  end

  # Called when the production is about to be closed.
  def production_closing
  end

  # Called when the production is fully closed.
  def production_closed
  end

end