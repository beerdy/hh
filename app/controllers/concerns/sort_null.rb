module SortNull
  extend ActiveSupport::Concern
  
  def sort_null(content, max_sort=9999)
    contents = []
    content.each do |c|
      c.sort = max_sort unless c.sort
      contents.push c
    end
    return contents
  end
end
