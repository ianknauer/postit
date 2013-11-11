module ApplicationHelper
  def fix_url(str)
    str.starts_with?('http://') ? str : "http://#{str}"
  end
  
  def display_datetime(dt)
    dt.strftime("%l:%M%P on %m/%d/%Y") # 03/14/2013 9:09pm
  end
end