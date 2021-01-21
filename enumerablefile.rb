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

  #my_all

  def my_all
    self.my_each do |elem|
      unless yield elem
        return false
      end
    end
    return true
  end

  #my_any

  def my_any
    self.my_each do |elem|
      if yield elem
        return true
      end
    end
    return false
  end

  #my_one

  def my_one
    self.my_each do |elem|
      if yield elem
        return true
      end
    end
    return false
  end

  #my_none

  def my_none
    self.my_each do |elem|
      if yield elem
        return false
      end
    end
    return true
  end

  #my_count

  def my_count(search = nil)
    if search == nil
      return self.length
    else
      count = 0
      self.my_each do |elem|
        if search == elem
          count += 1
        end
      end
      return count 
    end
  end

  #my_map

  def my_map
    result = []
    self.my_each do |elem|
      result.push(yield elem)
    end
    return result
  end

  #my_inject or reduce

  def my_inject(acc = 0)
    self.my_each do |elem|
      acc = yield elem, acc
    end
    return acc
  end

  #multiply_els

  def multiply_els
    self.my_inject(1) { |acc, elem| acc * elem }
  end
end
