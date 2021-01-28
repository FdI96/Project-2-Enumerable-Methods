
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

  def my_all?(regex = nil)
    if !block_given? and regex == nil and self == nil
      p 'Error'
    end
    if regex.is_a?(Regexp) || regex.is_a?(Class)
      self.my_each do |elem|
        unless regex == elem || elem.is_a?(Numeric)
          return false
        end
      end
      return true
    elsif regex == nil and !block_given?
      self.my_each do |elem|
        unless elem == false || elem == nil
          return false
        end
      end
      return true
    else
      
      self.my_each do |elem| #block case
        unless yield elem
          return false
        end
      end
      return true  
    end
  
  end

  # my_any

  def my_any?(regex = nil)
    if !block_given? and regex == nil and self == nil
      p 'Error'
    end
    if regex.is_a?(Regexp) || regex.is_a?(Class)
      self.my_each do |elem|
        unless elem
          return true
        end
      end
      return false
    elsif regex == nil and !block_given?
      self.my_each do |elem|
        if elem != nil || elem == false
          return true
        end
      end
      return false
    else
      self.my_each do |elem|
        if yield elem
          return true
        end
      end
      return false
    end
  end

  # my_none

  def my_none?(arg = nil)
    for elem in self
      if block_given?
        if yield elem 
          return false
        end
      elsif arg.is_a?(Regexp) || arg.is_a?(Class)      
        if elem.is_a?(Regexp) || elem.is_a?(Float)
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
    count = 0
    if search == nil and !block_given?
      return self.length
    elsif block_given?      
      self.my_each do |elem|
        if yield elem
          count += 1
        end
      end
    else     
      self.my_each do |elem|        
        if search == elem
          count += 1
        end
      end
    end
    return count
  end

 # my_map

  def my_map(proc = nil)
    result = []
    self.my_each do |elem|      
      result.push(proc.call(elem)) if proc.is_a?(Proc)
      result.push(yield elem) if block_given? && proc.nil?           
    end
    result
  end


  # my_inject or reduce

  def my_inject(acc = nil, sym = nil)
    
    if !block_given? and sym.nil? and acc.nil?
      p 'Error!'
    end
      
    if block_given?
      r = acc unless acc.nil? 
      self.my_each do |elem|     
        if r.nil?          
          r = elem          
        else
          r = yield r, elem
        end
      end
      return r
    elsif acc.is_a?(Symbol)
      self.my_each do |elem|
        if r.nil?
          r = elem
        else
          r = r.public_send(acc, elem)
        end
      end
    elsif acc.is_a?(Numeric) and sym.is_a?(Symbol)
      r = acc
      self.my_each do |elem|
        r = r.public_send(sym, elem)
      end
    else
      self.my_each do |elem|
        yield elem
      end
    end
    return r
  end
end

# multiply_els

def multiply_els(array = [])
  array.my_inject(1) { |acc, elem| acc * elem }
end

