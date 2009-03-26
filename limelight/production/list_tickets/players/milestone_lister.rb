module MilestoneLister
  def list_titles
    production.stage_manager[scene.stage.name]
  end
end