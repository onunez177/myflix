Fabricator(:queued_video) do
  queue_position {[1,2,3,4,5].sample}
end