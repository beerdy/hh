module PagesHelper
  def show_file type
    begin
      content = Content.find_by link: type  
      if content.document.url == '' or content.document.nil? or content.document.nil?
        nil
      else
        content
      end
    rescue Exception => e
      nil
    end
  end
end
