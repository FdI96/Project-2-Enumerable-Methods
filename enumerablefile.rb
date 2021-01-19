# Methods
module Enumerable
  def my_each
    self.length.times do |i|
      yield self[i]
    end
  end
  #my_each_with_index
  def my_each_with_index
    self.length.times do |i|
      yield self[i], i
    end
  end
  #my_select
  def my_select
    result = []
    self.my_each do |elem|
      if yield elem
        result.push << elem
      end
    end
    p result
  end
end

a = [1,2,3,4,5]
a.my_select {|elem| elem > 2}