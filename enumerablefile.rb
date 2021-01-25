# Methods
module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    for elem in self
      yield elem      
    end
  end
  
   # my_each_with_index

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?
    index = 0
    for elem in self
      yield elem, index
      index += 1      
    end

    return self
  end

  # my_select

  def my_select
    return to_enum(:my_select) unless block_given?
    
    result = []
    self.my_each do |elem|
      if yield elem
        result << elem
      end
    end
    
    return result
  end

  # my_all

  def my_all?
    self.my_each do |elem|
      unless yield elem
        return false
      end
    end
    return true
  end

  # my_any

  def my_any?
    self.my_each do |elem|
      if yield elem
        return true
      end
    end
    return false
  end

 # my_none

  def my_none?
    for elem in self
      if block_given?
        if yield elem 
          return false
        end
      else
        if elem == true
          return false
        end
      end      
    end
    return true
  end
  
  # my_count

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

  # my_map

  def my_map(proc = nil)
    result = []
    self.my_each do |elem|
      result.push(yield elem)
            
    end
    return result
  end


  # my_inject or reduce

  def my_inject(acc = 0)
    self.my_each do |elem|
      acc = yield elem, acc
    end
    return acc
  end

  # multiply_els

  def multiply_els
    self.my_inject(1) { |acc, elem| acc * elem }
  end
end
