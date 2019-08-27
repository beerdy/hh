module PagesHelper
  def show_file type
    @document ||= Content.find_by link: type
  end
end
