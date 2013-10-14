module ApplicationHelper

  def timestamp(time)
    time.strftime("%b #{time.day.ordinalize}, %Y") # ordinalize will make the date read like "18th" or "1st"
  end

  def options_for_video_ratings(selected=nil) # used in video show, and queue index views for a dropdown to select rating
    options_for_select([["5 Stars", 5], ["4 Stars", 4], ["3 Stars", 3], ["2 Stars", 2], ["1 Star", 1]], selected)
  end
end
