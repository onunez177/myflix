module ApplicationHelper
  

  def timestamp(time)
    time.strftime("%b #{time.day.ordinalize}, %Y") # ordinalize will make the date read like "18th" or "1st"
  end

end
