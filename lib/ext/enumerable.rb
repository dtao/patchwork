module Enumerable
  def sort_by_descending(&block)
    self.sort { |x, y| block.call(y) <=> block.call(x) }
  end
end
