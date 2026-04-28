module Enumerable
  # Your code goes here
  def my_all?(*args)
    
    if args.length > 1
      raise ArgumentError, "wrong number of arguments (given #{args.length}, expected 0..1)"
    end

    if args.length == 1
      warn "warning: given block not used" if block_given?
      self.my_each do |elem|
      return false unless args[0] === elem
    end
      return true
    end

    if block_given?
      self.my_each do |elem|
        return false unless yield(elem)
      end
      return true
    end

    if args.length == 0 && !block_given?
      self.my_each do |elem|
        return false unless elem
      end
      return true
    end
  end

  def my_any?(*args)
    
    if args.length > 1
      raise ArgumentError, "wrong number of arguments (given #{args.length}, expected 0..1)"
    end

    if args.length == 1
      warn "warning: given block not used" if block_given?
      self.my_each do |elem|
      return true if args[0] === elem
    end
      return false
    end

    if block_given?
      self.my_each do |elem|
        return true if yield(elem)
      end
      return false
    end

    if args.length == 0 && !block_given?
      self.my_each do |elem|
        return true if elem
      end
      return false
    end
  end

  def my_count(*args)

    if args.length == 1
      count = 0
      self.my_each do |elem|
        count+=1 if elem == args[0]
      end
      warn "warning: given block not used" if block_given?
      return count
    end
    return self.length unless block_given?
    
    count = 0
    self.my_each do |elem|
      count+=1 if yield(elem)
    end
    count
  end

  def my_each_with_index
    
    return to_enum(:my_each_with_index) unless block_given?

    index = 0
    self.my_each do |elem|
      yield(elem, index)
      index += 1
    end
    self
  end

  def my_inject(*args)
    
    if (args.length == 0 && !block_given?) || args.length > 2
      raise ArgumentError, "wrong number of arguments (given #{args.length}, expected 1..2)"
    end

    if args.length == 2
      unless args[1].is_a?(Symbol) || args[1].is_a?(String)
        raise TypeError, "#{args[1]} is not a symbol nor a string"
      end
      method = args[1].to_sym.to_proc
      result = args[0]
      self.my_each do |elem|
        result = method.call(result, elem)
      end
      return result
    end

    if args.length == 1 && !block_given?
      unless args[0].is_a?(Symbol) || args[0].is_a?(String)
        raise TypeError, "#{args[0]} is not a symbol nor a string"
      end
      method = args[0].to_sym.to_proc
      result = self.first
      skip_first_value = true
      self.my_each do |elem|
        if skip_first_value 
          skip_first_value = false
          next
        end
        result = method.call(result, elem)
      end
      return result
    end

    if args.length == 1 && block_given?
      result = args[0]
      self.my_each do |elem|
        result = yield(result, elem)
      end
      return result
    end

    if args.length == 0 && block_given?
      result = self.first
      skip_first_value = true
      self.my_each do |elem|
        if skip_first_value 
          skip_first_value = false
          next
        end
        result = yield(result, elem)
      end
      return result
    end  
  end

  def my_map
    
    return to_enum(:my_map) unless block_given?

    new_arr = []
    self.my_each do |elem|
      new_arr << yield(elem)
    end
    new_arr
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array

  def my_each

  return to_enum(:my_each) unless block_given?

  index = 0
    while index < self.length
      yield(self[index])
    index += 1
    end
    self
  end
end
