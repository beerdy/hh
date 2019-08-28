module PagesHelper
  def show_file type
    if @document
      document  = @document
      @document = nil
      return document
    end

    @document = Content.find_by link: type
  end
end
